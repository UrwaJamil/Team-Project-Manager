import 'package:go_router/go_router.dart';

import '../core/user_role.dart';
import '../features/common/notifications_screen.dart';
import '../features/member/screens/my_tasks_screen.dart';
import '../features/member/screens/profile_screen.dart';
import '../features/member/screens/project_chat_screen.dart';
import '../features/member/screens/project_detail_screen.dart' as member;
import '../features/member/screens/request_leave_screen.dart';
import '../features/member/screens/task_detail_screen.dart' as member;
import '../features/pm/screens/analytics_screen.dart';
import '../features/pm/screens/calendar_screen.dart';
import '../features/pm/screens/leave_requests_screen.dart';
import '../features/pm/screens/project_detail_screen.dart' as pm;
import '../features/pm/screens/projects_overview_screen.dart';
import '../features/pm/screens/task_detail_screen.dart' as pm;
import '../features/pm/screens/team_members_screen.dart';
import '../features/role_select/role_select_screen.dart';
import '../navigation/member_shell.dart';
import '../navigation/pm_shell.dart';

GoRouter buildAppRouter(SessionController session) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: session,
    redirect: (context, state) {
      final role = session.value;
      final loggedIn = role != null;
      final atRoleSelect = state.matchedLocation == '/';

      if (!loggedIn) return atRoleSelect ? null : '/';
      if (atRoleSelect) {
        return role == UserRole.pm ? '/pm/projects' : '/member/tasks';
      }
      if (role == UserRole.pm && state.matchedLocation.startsWith('/member')) {
        return '/pm/projects';
      }
      if (role == UserRole.member && state.matchedLocation.startsWith('/pm')) {
        return '/member/tasks';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => RoleSelectScreen(session: session),
      ),
      GoRoute(
        path: '/pm/projects/:projectId',
        builder: (context, state) => pm.ProjectDetailScreen(
          projectId: state.pathParameters['projectId']!,
        ),
        routes: [
          GoRoute(
            path: 'tasks/:taskId',
            builder: (context, state) => pm.TaskDetailScreen(
              projectId: state.pathParameters['projectId']!,
              taskId: state.pathParameters['taskId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/member/projects/:projectId',
        builder: (context, state) => member.ProjectDetailScreen(
          projectId: state.pathParameters['projectId']!,
        ),
        routes: [
          GoRoute(
            path: 'tasks/:taskId',
            builder: (context, state) => member.TaskDetailScreen(
              projectId: state.pathParameters['projectId']!,
              taskId: state.pathParameters['taskId']!,
            ),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => ProjectChatScreen(
              projectId: state.pathParameters['projectId']!,
            ),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            PmShell(navigationShell: navigationShell, session: session),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/projects',
                builder: (context, state) => const ProjectsOverviewScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/team',
                builder: (context, state) => const TeamMembersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/leave',
                builder: (context, state) => const LeaveRequestsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/calendar',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/analytics',
                builder: (context, state) => const AnalyticsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pm/notifications',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MemberShell(navigationShell: navigationShell, session: session),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/member/tasks',
                builder: (context, state) => const MyTasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/member/leave',
                builder: (context, state) => const RequestLeaveScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/member/notifications',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/member/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
