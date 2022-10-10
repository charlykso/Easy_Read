import 'package:easy_read/models/user.dart';
import 'package:easy_read/providers/user_state.dart';
import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';
import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:easy_read/screens/auth/verification/verification_screen.dart';
import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = AsyncRouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true, // For debug purposes
    refreshListenable: router, // This notifiies `GoRouter` for refresh events
    redirect: router._redirect, // All the logic is centralized here
    routes: router._routes, // All the routes can be found there
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );
});

class AsyncRouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// Auth asynchronous redirects.
  AsyncRouterNotifier(this._ref) {
    _ref.listen<User?>(
      userProvider,
      (_, __) => notifyListeners(),
    );
  }

  // redirect to the login page if the user is not logged in
  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final user = _ref.read(userProvider);
    final loggingIn = state.subloc == state.namedLocation('onboarding') ||
        state.subloc == state.namedLocation('login') ||
        state.subloc == state.namedLocation('register') ||
        state.subloc == state.namedLocation('verification');
    final homeLocation = state.namedLocation('home');

    if (user == null) {
      // The user is not logged in, they need to login
      // No redirect needed if we need to insert credentials.
      if (loggingIn) {
        return null;
      }

      // Here, we're not seeing the login page, but we're not authenticated yet.
      try {
        // Therefore we can still try to recover some auth state from our local
        await _ref.read(userProvider.notifier).loginWithToken();

        // If the attempts succeeds, the current page can be shown
        return null;
      } on UnauthorizedException catch (_) {
        // Token has expired, redirect to login.

        // bundle the location the user is coming from into a query parameter
        final fromLocation = state.subloc == homeLocation ? '' : state.location;

        return state.namedLocation(
          'login',
          queryParams: {if (fromLocation.isNotEmpty) 'from': fromLocation},
        );
      } on LogoutException catch (_) {
        // This means that no attempt has been made: we've logged out!
        // Redirect to the onboarding screen..

        return state.namedLocation('onboarding');
      }
    }

    // The user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    if (loggingIn) {
      return state.queryParams['from'] ?? homeLocation;
    }

    // There's no need for a redirect at this point.
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: "home",
          path: '/',
          builder: (context, state) => HomeScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: "onboarding",
          path: '/onboard',
          builder: (context, state) => OnboardingScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: "login",
          path: '/login',
          builder: (context, state) => SignInScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: "register",
          path: '/register',
          builder: (context, state) => SignUpScreen(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              name: "verification",
              path: 'verify',
              builder: (context, state) => VerificationScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
      ];
}
