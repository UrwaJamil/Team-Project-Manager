# Project Management System (Flutter + Firebase)

Full product spec: `docs/SPEC.md` (read it before starting any phase).
This file = decisions, architecture, and build rules. If they conflict, ask me.

## Stack (decided)
- Flutter (target: Android + Web first; Windows desktop optional)
- State management: **Riverpod** (`flutter_riverpod`, use `riverpod_annotation` only if I ask)
- Navigation: **go_router** with role-aware redirects
- Backend: **Firebase** — Auth, Cloud Firestore, Cloud Storage, FCM
- Models: plain immutable Dart classes with `fromMap` / `toMap` (add `freezed` later only if needed)
- Lints: `flutter_lints`, keep `flutter analyze` at 0 issues

## Architecture: feature-first

lib/
main.dart
app/ # app widget, router, theme, constants
core/ # shared: firebase providers, utils, widgets, error handling
features/
auth/ # login, register, auth state, role
projects/ # project CRUD, members, progress
tasks/ # task CRUD, status, subtasks, comments, help notes
chat/ # per-project chat
leave/ # leave requests + On Leave badge
notifications/ # in-app center + FCM
dashboard/ # PM dashboard, Member "My Tasks"
reports/ # analytics, calendar, PDF export

each feature: data/ (repositories, models) · application/ (providers) · presentation/ (screens, widgets)
Rules: UI never talks to Firestore directly — only through a repository. Repositories are exposed via Riverpod providers.

## Requirements numbering
If `docs/SPEC.md` contains FR-numbered requirements (e.g. FR-1.1, FR-2.3), treat each FR as a precise, testable requirement — more authoritative than the prose sections above it when the two overlap. When implementing a phase, list which FR numbers it covers and confirm each is satisfied before calling the phase done.

## Key decisions on the spec
1. **Hybrid role model.** At registration the user picks a default role (Project Leader or Team Member, per FR-1.1) — this decides which dashboard they land on right after login/register (FR-1.3) and is stored on `users/{uid}.defaultRole`. The role's stored/code value is exactly `"leader"` for Project Leader and `"member"` for Team Member — use `leader`, never `pm` or `pl`, anywhere in code, Firestore fields, enum names (`UserRole.leader`), or debug output, so the stored value always reads unambiguously as "Project Leader". Actual permissions are per project: `projects/{id}.members` = map `{uid: "leader" | "member"}` plus `memberIds[]` (for `array-contains` queries). A user's role inside a specific project always follows that project's `members` map, even if it differs from their `defaultRole` (e.g. a Project Leader added as a member on someone else's project sees that project as a member). The home screen shows the user's projects grouped by their role in each, and a user can switch which dashboard view they're in.
2. **Login and register screen layout:** logo at top, then a role toggle (Project Leader / Team Member). On the register screen this toggle sets `users/{uid}.defaultRole`. On the login screen it's a convenience for which dashboard to land on this session (default to the account's stored `defaultRole`), not a re-registration. Below the toggle: the email/password fields and the primary action button. At the bottom: a link to switch between login and register ("Don't have an account? Create new account" / "Already have an account? Log in").
3. **Permissions are enforced in Firestore Security Rules**, not just hidden in the UI.
   - Members: read whole project; update only tasks where `assignedTo` contains their uid, and only fields: `status`, `helpNote`, `subtasks`, `attachments`.
   - PM: full write on the project's tasks/members.
4. **Chat messages live in a subcollection** (`projects/{id}/messages`), never an array in a document. One chat per project, chat id = project id.
5. **Task comments and history** are subcollections of the task (`comments`, `history`).
6. **Leave**: `leaveRequests` collection; an approved request in the current date range shows the "On Leave" badge (computed on read, not stored as a flag).
7. **Notifications**: build the in-app notification center first (Firestore `notifications`). Push (FCM) and scheduled "deadline in 24h" reminders need Cloud Functions, which may need the Blaze plan — do these last and ask me before enabling anything paid.
8. Cloud Storage (attachments) may also need Blaze on new projects — verify in console; if unavailable, stub attachments behind a repository interface and defer.

## Data model (Firestore)

users/{uid} name, email, defaultRole(leader|member), skillTags[], photoUrl, createdAt
projects/{pid} name, description, startDate, deadline, status(active|archived),
createdBy, members{uid: role}, memberIds[], createdAt
projects/{pid}/tasks/{tid} title, description, assignedTo[], priority(high|medium|low),
status(todo|in_progress|blocked|completed), deadline,
helpNote{text, taggedUserId?, taggedSkill?}, subtasks[{title,done}],
attachments[], createdBy, createdAt, updatedAt
projects/{pid}/tasks/{tid}/comments/{cid}
projects/{pid}/tasks/{tid}/history/{hid} who, action, from, to, at
projects/{pid}/messages/{mid} text, senderId, createdAt, mentions[], attachments[], pinned
leaveRequests/{lid} userId, fromDate, toDate, reason, status(pending|approved|rejected), decidedBy
notifications/{nid} userId, type, projectId?, taskId?, message, read, createdAt

Note: tasks are a subcollection of the project (not top-level) so rules and queries stay simple. Use a `collectionGroup` query for "My Tasks across all projects" (needs a composite index — Claude Code should tell me the exact index to create).

## Build phases (do ONE phase at a time, stop after each)
| # | Phase | Done when |
|---|-------|-----------|
| 0 | Scaffold: packages, folder structure, theme (light+dark), router, Firebase init, placeholder screens | `flutter run` shows a themed app; `flutter analyze` clean |
| 1 | Auth: register/login/logout, user doc, profile with skill tags, auth-gated router | I can register, log in, and stay logged in after restart |
| 2 | Projects: create/edit/archive project, add/remove members (search by email), project list with progress % | PM creates a project and adds a member who then sees it |
| 3 | Tasks: create/edit/delete/reassign (PM), per-task deadline + priority, status updates (assignee), overdue highlight, Member "My Tasks" screen, Firestore rules for permissions | Member can edit only their own tasks; rules verified in emulator/tests |
| 4 | Blocked/Help: status Blocked + help note + tag person/skill, "suggested helpers" by skill tag, sub-tasks, task comments, task history | Blocked note visible to PM and team |
| 5 | Project chat: realtime messages, @mentions, pin, image/file share (if storage available) | Two accounts chat in realtime, one chat per project |
| 6 | Leave: request → PM approve/reject → On Leave badge everywhere members are listed + deadline-conflict warning | Badge shows in members list, task assignee picker, chat participants |
| 7 | Views: Kanban (drag & drop), calendar of deadlines, search/filters, favorites, archive | Dragging a card changes status (respecting permissions) |
| 8 | Notifications: in-app center first, then FCM push | Assigned task → assignee sees notification |
| 9 | Analytics + PDF weekly report, polish, empty/error/loading states | Report exports |

## Working rules for Claude Code
- Start each phase with a short plan (files to create/change) and wait for my OK.
- Small, working increments. After each step run `flutter analyze` and fix issues; run `flutter test` when tests exist.
- Never commit secrets. `firebase_options.dart` is fine to commit; service-account keys are not.
- Every screen needs loading, empty, and error states.
- Don't add packages without saying why. Prefer well-maintained ones (check pub.dev score).
- Keep widgets small; extract when a build method passes ~80 lines.
- Add unit tests for repositories' permission logic and progress-% calculation.
- Commit-ready state at the end of each phase, with a one-paragraph summary of what changed and what to test manually.
- If something needs manual setup (Firebase console, indexes, SHA-1 keys), give me exact steps instead of guessing.