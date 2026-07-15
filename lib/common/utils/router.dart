import 'package:go_router/go_router.dart';

import '../../pages/pages.dart';
import '../values/route_paths.dart';
import '../widgets/widgets.dart';

/// Whether the welcome screen has been shown before.
var _welcomeShown = false;

/// Marks the welcome screen as shown, so it won't appear on future launches.
void markWelcomeShown() => _welcomeShown = true;

/// The application's root [GoRouter] configuration.
///
/// Route structure:
/// - [RoutePaths.welcome]    -- standalone welcome screen (entry point)
/// - [RoutePaths.voice]      -- tab 0 inside stateful shell
/// - [RoutePaths.todo]       -- tab 1 inside stateful shell
/// - [RoutePaths.schedule]   -- tab 2 inside stateful shell
/// - [RoutePaths.focus]      -- tab 3 inside stateful shell
final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: _welcomeShown ? RoutePaths.voice : RoutePaths.welcome,
  redirect: (context, state) {
    // Redirect bare '/' to welcome page.
    if (state.matchedLocation == RoutePaths.root) {
      return _welcomeShown ? RoutePaths.voice : RoutePaths.welcome;
    }
    // Skip welcome page on subsequent launches.
    if (state.matchedLocation == RoutePaths.welcome && _welcomeShown) {
      return RoutePaths.voice;
    }
    return null;
  },
  routes: [
    // Welcome page — no bottom navigation bar.
    GoRoute(
      path: RoutePaths.welcome,
      name: RoutePaths.welcomeName,
      builder: (context, state) => const WelcomePage(),
    ),

    // Main app shell with bottom navigation and stateful tab preservation.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.voice,
              name: RoutePaths.voiceName,
              builder: (context, state) => const VoicePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.todo,
              name: RoutePaths.todoName,
              builder: (context, state) => const TodoPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.schedule,
              name: RoutePaths.scheduleName,
              builder: (context, state) => const SchedulePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.focus,
              name: RoutePaths.focusName,
              builder: (context, state) => const FocusPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
