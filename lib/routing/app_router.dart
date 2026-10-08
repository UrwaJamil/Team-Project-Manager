import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_controller.dart';
import '../features/auth/data/app_user.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/common/notifications_screen.dart';
import '../features/common/splash_screen.dart';
import '../features/leader/screens/analytics_screen.dart';
import '../features/leader/screens/calendar_screen.dart';
import '../features/leader/screens/leave_requests_screen.dart';
import '../features/leader/screens/project_detail_screen.dart' as leader;
import '../features/leader/screens/projects_overview_screen.dart';
import '../features/leader/screens/task_detail_screen.dart' as leader;
import '../features/leader/screens/team_members_screen.dart';
import '../features/member/screens/my_tasks_screen.dart';
import '../features/member/screens/project_chat_screen.dart';
import '../features/member/screens/project_detail_screen.dart' as member;
import '../features/member/screens/request_leave_screen.dart';
import '../features/member/screens/task_detail_screen.dart' as member;
import '../features/profile/presentation/profile_page.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../navigation/leader_shell.dart';
import '../navigation/member_shell.dart';
import 'router_refresh.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ref.watch(routerRefreshProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final target = authRedirect(auth, state.matchedLocation);
      authLog(
        'redirect: ${state.matchedLocation} -> ${target ?? '(stay)'} '
        '[status=${auth.status.name}, role=${auth.sessionRole?.value}]',
      );
      return target;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/leader/projects/:projectId',
        builder: (context, state) => leader.ProjectDetailScreen(
          projectId: state.pathParameters['projectId']!,
        ),
        routes: [
          GoRoute(
            path: 'tasks/:taskId',
            builder: (context, state) => leader.TaskDetailScreen(
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
            LeaderShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/projects',
                builder: (context, state) => const ProjectsOverviewScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/team',
                builder: (context, state) => const TeamMembersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/leave',
                builder: (context, state) => const LeaveRequestsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/calendar',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/analytics',
                builder: (context, state) => const AnalyticsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leader/notifications',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MemberShell(navigationShell: navigationShell),
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
});

/// Pure auth gate behind [routerProvider]'s `redirect`; `null` means stay.
String? authRedirect(AuthState auth, String location) {
  final atSplash = location == '/splash';
  final atAuthScreen = location == '/login' || location == '/register';

  switch (auth.status) {
    // Signed-in-but-unresolved (or about to be signed out): hold on the
    // splash so no dashboard — or login — flashes in the meantime.
    case AuthStatus.loading:
    case AuthStatus.profileMissing:
      return atSplash ? null : '/splash';

    case AuthStatus.unauthenticated:
      return atAuthScreen ? null : '/login';

    case AuthStatus.authenticated:
      final home = switch (auth.sessionRole!) {
        UserRole.leader => '/leader/projects',
        UserRole.member => '/member/tasks',
      };
      if (atAuthScreen || atSplash) return home;
      if (auth.sessionRole == UserRole.leader && location.startsWith('/member')) {
        return home;
      }
      if (auth.sessionRole == UserRole.member && location.startsWith('/leader')) {
        return home;
      }
      return null;
  }
}
