import "package:flutter/material.dart";

import "package:color_sort/models.dart";
import "package:color_sort/pages.dart";
import "package:color_sort/services.dart";
import "package:flutter/services.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await services.init();
  await models.init();
  runApp(const ColorSortApp());
}

/// The main app widget.
class ColorSortApp extends StatelessWidget {
  /// A const constructor.
  const ColorSortApp();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: "Flutter Demo",
    theme: ThemeData(
      useMaterial3: true,
    ),
    darkTheme: ThemeData.dark(useMaterial3: true),
    routerConfig: router,
  );
}
