# Flutter Project Management System — Spec Document

## 1. Overview

A Flutter-based Project Management System with **two dashboards**:

1. **Project Leader (PM) Dashboard** — create projects, assign tasks, set deadlines, monitor progress, manage team.
2. **Team Member Dashboard** — view assigned tasks, update task status, chat, request help, request leave.

---

## 2. Core Features (from original idea)

### 2.1 Project Creation (PM only)
- PM creates a new project (name, description, start date, overall deadline).
- PM adds team members to the project.
- PM creates tasks inside the project and assigns each task to one or more members.
- Each task has its **own deadline**, independent of other tasks (e.g. "Task A deadline: 5 Oct", "Task B deadline: 10 Oct").

### 2.2 Task Visibility & Access
- **Members** can see the **entire project** (all tasks, all members, overall progress) — read-only for tasks not assigned to them.
- Members have **edit access only to their own assigned tasks** (status updates, notes, attachments).
- **PM** has full edit access to everything (create/edit/delete/reassign any task).

### 2.3 Task Status
- **To Do** — not started yet
- **In Progress** — member currently working on it
- **Blocked / Needs Help** — stuck, waiting on someone (see 2.4)
- **Completed** — done, marked by the assigned member (PM can also verify/reopen)

### 2.4 "Help Needed" Notes
- If a task is stuck (e.g. needs a graphic designer, needs input from another member, waiting on PM approval), the member can:
  - Set status to **Blocked**
  - Add a **note** explaining why (e.g. "Waiting on graphic designer for banner design")
  - Optionally **tag/mention** the specific person or role whose help is needed
- This note is visible to PM and (optionally) the whole project team, so the right person can jump in.

### 2.5 Project Chat
- Every project has **its own dedicated chat** (group chat between PM + assigned members).
- **New project = new chat**, even if the members are exactly the same as another project. Chats are never shared/reused across projects.
- Chat is scoped strictly to that project's context.

### 2.6 Leave Status
- If a member is on leave, an **"On Leave" badge/tag** appears next to their name everywhere they're listed — in the project members list, task assignment list, and chat participant list.
- PM (and ideally the member) can set/update leave status with a date range.

---

## 3. Additional Recommended Features

### 3.1 Task Management Enhancements
- **Priority levels**: High / Medium / Low per task.
- **Sub-tasks / checklist** inside a task (e.g. "Design → Wireframe, Mockup, Final Export").
- **File attachments** on tasks (images, PDFs, docs).
- **Task-level comments** — a mini discussion thread specific to one task, separate from the main project chat. Keeps task-specific back-and-forth organized.
- **Task history/timeline** — log of status changes, reassignments, edits (who did what, when).
- **Reassign task** — PM can move a task from one member to another.
- **Overdue highlighting** — tasks past their deadline are visually flagged (e.g. red) on both dashboards.

### 3.2 Member Skill Tags
- Each member profile has **skill tags** (e.g. Graphic Designer, Backend Developer, Content Writer, QA).
- When a task is marked "Blocked / Needs Help", PM (or the member) can see a quick list of team members with the relevant skill tag to request help from — directly useful for the "graphic designer ki help chahiye" scenario.

### 3.3 Notifications
- Task assigned to you
- Deadline approaching (e.g. 24 hrs before)
- Task marked overdue
- Someone requested your help on a task (skill-tag match or direct mention)
- New chat message / you were @mentioned
- Leave request approved/rejected
- Push notifications (Firebase Cloud Messaging) + in-app notification center.

### 3.4 Leave Request Workflow
- Member submits a leave request (date range + reason) from their dashboard.
- PM approves/rejects.
- Approved leave automatically shows the "On Leave" tag during that date range and can optionally auto-notify PM if any of the member's tasks have deadlines during the leave period (conflict warning).

### 3.5 Views & Reporting (PM Dashboard)
- **Kanban board view**: columns for To Do / In Progress / Blocked / Completed, drag-and-drop across a project.
- **Calendar view**: all task deadlines across all projects in one calendar.
- **Progress bar / completion %** per project (auto-calculated from task statuses).
- **Analytics/reports**: team performance, tasks completed vs overdue, per-member workload, project health at a glance.
- **Export report as PDF** (e.g. weekly project summary).

### 3.6 Chat Enhancements
- **@mentions** within project chat (notifies the mentioned person).
- **Pin important messages** (e.g. pinned deadline reminders or decisions).
- **File/image sharing** in chat.
- **Online/offline / last seen** indicator for members.
- **Read receipts** (optional).

### 3.7 Access & Roles
- Role-based permissions:
  - **PM**: create/edit/delete projects & tasks, assign/reassign, manage members, approve leave, view all reports.
  - **Member**: view full project, edit only own tasks, chat, request help, request leave.
- Option for **Co-Leader / Sub-lead** role in bigger projects (optional, for scalability).

### 3.8 Quality-of-Life Features
- **Search & filters**: by project, member, status, priority, deadline.
- **Archive** completed/closed projects (keeps dashboard clean, but data retained).
- **Star/favorite** projects for quick access.
- **Multi-project view** for members who are on more than one project at once — a unified "My Tasks" list across all their projects, sorted by deadline.
- **Dark mode**.

---

## 4. Suggested Tech Stack

| Layer | Suggestion |
|---|---|
| Frontend | Flutter (mobile + web from same codebase) |
| State Management | Riverpod or Bloc |
| Backend / DB | Firebase (Firestore + Auth + Cloud Storage + Cloud Messaging) — fastest for real-time chat & notifications; OR custom REST API (Node.js/Django) + PostgreSQL if you need more control |
| Real-time Chat | Firestore streams (if Firebase) or Socket.IO (if custom backend) |
| Notifications | Firebase Cloud Messaging (FCM) |
| File Storage | Firebase Storage / S3 |

---

## 5. Suggested Data Model (Firestore-style collections)

```
users/
  - id, name, email, role (pm/member), skillTags[], leaveStatus{from, to, approved}

projects/
  - id, name, description, createdBy(pmId), memberIds[], startDate, deadline, status, chatId

tasks/
  - id, projectId, title, description, assignedTo[], priority, status,
    deadline, helpNote{text, taggedUserId}, attachments[], subtasks[], createdAt, updatedAt

chats/
  - id, projectId, participantIds[], messages[] (subcollection: text, senderId, timestamp, attachments, mentions[])

leaveRequests/
  - id, userId, fromDate, toDate, reason, status(pending/approved/rejected)

notifications/
  - id, userId, type, referenceId, message, read(bool), timestamp
```

---

## 6. Suggested Screen List

**PM Dashboard**
1. Projects Overview (list + progress %)
2. Create/Edit Project
3. Project Detail (Kanban board + members + chat access)
4. Task Detail / Create Task
5. Team Members & Skills
6. Leave Requests (approve/reject)
7. Analytics/Reports
8. Calendar View
9. Notifications

**Member Dashboard**
1. My Tasks (across all projects, sorted by deadline)
2. Project Detail (full view, own tasks editable)
3. Task Detail (status update, add "help needed" note, sub-tasks, attachments, comments)
4. Project Chat
5. Request Leave
6. Notifications
7. Profile (edit skill tags)

---

## 7. Next Steps
- Decide backend: Firebase (faster to build, good for MVP) vs custom API (more control, more work).
- Wireframe the Kanban board + task detail screen first, since they're the most-used surfaces.
- Build role-based auth first (PM vs Member) since permissions touch every other screen.