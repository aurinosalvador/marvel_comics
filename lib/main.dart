import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:marvel_comics/views/home.dart';

void main() async {
  await dot_env.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Comics',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.lightGreenAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
