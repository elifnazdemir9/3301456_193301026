import 'dart:async';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushNamed(context, '/giris');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent.shade700,
      body: Center(
        child: CircleAvatar(backgroundColor: Colors.white,
          minRadius: 5,
          child: Text('Yapılacaklar Uygulaması',
              style: TextStyle(fontSize: 40,color: Colors.purpleAccent.shade700,fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}