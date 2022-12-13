import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes.dart';

class Page_one extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;
  Page_one(this.notifier);
  @override
  State<StatefulWidget> createState() => _Page_one_state(notifier);
}
class _Page_one_state extends State<Page_one> {
  final ValueNotifier<ThemeMode> valueNotifier;
  final Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();
  ThemesEnum currentTheme = ThemesEnum.light;
  TextEditingController textController = TextEditingController();
  _Page_one_state(this.valueNotifier);

  Future<void> loadPrefs() async {
    final SharedPreferences sharedPreferences = await sharedPreference;
    String? text = sharedPreferences.getString('TEXT');
    int? theme = sharedPreferences.getInt('THEME');
    if (text != null && theme != null) {
      Map<String, dynamic> values = {'TEXT': text, 'THEME': theme};
      if (theme == ThemesEnum.light.index) {
        valueNotifier.value = ThemeMode.light;
      } else {
        valueNotifier.value = ThemeMode.dark;
      }
      Navigator.pushNamed(context, 'page_two', arguments: values);
    }
  }
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments;
    if (data != null) {
      Map<String, dynamic> values = data as Map<String, dynamic>;
      textController.text = values['TEXT'];
    }
    loadPrefs();
    return Scaffold(
      body:
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration( border: UnderlineInputBorder()),
                )),
          ),
          Container(
            width: 400,
            height: 40,
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              child: Text('Перейти к сохранению', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Map<String, dynamic> values = {
                  'TEXT': textController.text,
                  'THEME': currentTheme.index
                };
                Navigator.pushNamed(context, 'page_two', arguments: values);
              },
            ),
          )],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          valueNotifier.value = valueNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
          currentTheme = valueNotifier.value == ThemeMode.light
              ? ThemesEnum.light
              : ThemesEnum.dark,
        },
        child: Icon(valueNotifier.value == ThemeMode.light
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
      ),
    );
  }
}
