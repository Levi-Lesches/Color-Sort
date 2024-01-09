import "package:go_router/go_router.dart";
export "package:go_router/go_router.dart";

import "src/pages/game.dart";

/// Contains all the routes for this app.
class Routes {
  /// The route for the home page.
  static const home = "/";
}

/// The router for the app.
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      builder: (_, __) => GamePage(),
    ),
  ],
);
