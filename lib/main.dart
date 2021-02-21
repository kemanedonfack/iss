import 'package:flutter/material.dart';
import 'package:iai/Vue/page/splash.dart';
import 'package:iai/Vue/utile/couleur.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}