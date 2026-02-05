import 'package:continuum_flutter/application/auth_service.dart';
import 'package:continuum_flutter/application/graph_service.dart';
import 'package:continuum_flutter/presentation/bookmarks_page.dart';
import 'package:continuum_flutter/presentation/force_directed_graph_page.dart';
import 'package:continuum_flutter/presentation/home_page.dart';
import 'package:continuum_flutter/presentation/sign_in_page.dart';
import 'package:continuum_flutter/presentation/unknown_page.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authService.authInfoListenable,
    redirect: (context, state) async {
      try {
        final isLoggedIn = authService.isAuthenticated;

        final isOnSignIn = state.matchedLocation == '/';
        final isProtectedRoute =
            state.matchedLocation == '/home' ||
            state.matchedLocation == '/graph' ||
            state.matchedLocation == '/bookmarks';

        debugPrint(
          'redirect → isLoggedIn=$isLoggedIn, route=${state.matchedLocation}',
        );

        if (!isLoggedIn && isProtectedRoute) {
          return '/';
        }

        if (isLoggedIn && isOnSignIn) {
          final graphService = ref.read(graphServiceProvider);
          final graphData = await graphService.getGraphData();
          if (graphData.graphWithGranularity.isNotEmpty) {
            return '/graph';
          }
          return '/home';
        }
      } catch (e) {
        debugPrint('Error in redirect: $e');
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => _buildPageWithAnimation(
          child: const SignInPage(),
          state: state,
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) {
          return _buildPageWithAnimation(
            child: ContinuumLayout(child: child),
            state: state,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: AppRoute.home.name,
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const HomePage(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/graph',
            name: AppRoute.graph.name,
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const ForceDirectedGraphPage(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/demo-graph',
            name: AppRoute.demoGraph.name,
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const ForceDirectedGraphPage(isDemo: true),
              state: state,
            ),
          ),
          GoRoute(
            path: '/bookmarks',
            name: AppRoute.bookmarks.name,
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const BookmarksPage(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/unknown',
            name: AppRoute.unknown.name,
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const UnknownPage(),
              state: state,
            ),
          ),
        ],
      ),
    ],
    onException: (context, state, error) {
      debugPrint('Error in router: $error');
    },
    debugLogDiagnostics: true,
  );
}

Page<dynamic> _buildPageWithAnimation({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

enum AppRoute {
  home,
  bookmarks,
  demoGraph,
  graph,
  signIn,
  unknown,
}
