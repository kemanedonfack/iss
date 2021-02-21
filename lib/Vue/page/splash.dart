import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iai/Vue/page/home.dart';
import 'package:iai/Vue/utile/couleur.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Text("ISS", style: TextStyle(color: primaire, fontSize: 50, fontWeight: FontWeight.bold),),
      ),
    );
  }

   startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home() ));
  }

}