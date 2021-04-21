import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:marvel_comics/controllers/cart_controller.dart';
import 'package:marvel_comics/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await dot_env.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartController>.value(value: CartController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marvel Comics',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.lightGreenAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: ChangeNotifierProvider<CartController>(
        //   create: (_) => CartController(),
        //   child: Home(),
        // ),
        home: Home(),
      ),
    );
  }
}
