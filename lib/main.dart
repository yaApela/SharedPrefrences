import 'package:flutter/material.dart';
import 'package:prakticheskay5/Page_one.dart';
import 'package:prakticheskay5/Page_two.dart';
import 'package:prakticheskay5/themes.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ValueNotifier<ThemeMode> valueNotifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      builder: ((context, themeMode, child) => MaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: themeMode,
        initialRoute: 'page_one',
        routes: {
          'page_one': (context) => Page_one(valueNotifier),
          'page_two': (context) => Page_two(),
        },
      )),
      valueListenable: valueNotifier,
    );
  }
}
