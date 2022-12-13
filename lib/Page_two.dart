import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Page_two extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page_two_state();
}
class _Page_two_state extends State<Page_two> {
  final Future<SharedPreferences> futurePreferences = SharedPreferences.getInstance();
  late final SharedPreferences sharedPreferences;
  late String text = '';
  late int currentTheme;
  Future<void> PreferencLoading() async {
  sharedPreferences = await futurePreferences;
  }
  @override
  Widget build(BuildContext context) {
    PreferencLoading();
    var data = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic> values = data as Map<String, dynamic>;
    if (data != null) {
      text = data['TEXT'];
      currentTheme = data['THEME'] as int;
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Данные:  $text',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 40,
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: () {
                  sharedPreferences.setString('TEXT', text);
                  sharedPreferences.setInt('THEME', currentTheme);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Успех'),
                    ),
                  );
                },
                child: Text('Сохранить',style: TextStyle(color: Colors.black),)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 40,
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: () {
                  if (
                  sharedPreferences.getString('TEXT') != null &&
                  sharedPreferences.getInt('THEME') != null) {
                  sharedPreferences.remove('TEXT');
                  sharedPreferences.remove('THEME');
                  Navigator.pushNamed(context, 'page_one');
                  } else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Данные для удаления отсутсвуют'),
                      ),
                    );
                  }
                },
                child: Text('Очистить данные',style: TextStyle(color: Colors.black),)),
          ),
          SizedBox(height: 20,),
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: () {
                 exit(0);
                },
                child: Text('Выйти',style: TextStyle(color: Colors.black),)),
          ),
        ],
      )),
    );
  }
}
