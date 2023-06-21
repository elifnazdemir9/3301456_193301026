import 'package:flutter/material.dart';
class Themes{
  final lightTheme=ThemeData.light().copyWith(
    primaryColor: Colors.purpleAccent[300],
    cardColor: Colors.purpleAccent[300],
    iconTheme: IconThemeData(color: Colors.deepPurple),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purpleAccent.shade100,
     // brightness: Brightness.light,
      //textTheme: TextTheme(
       // headline1: TextStyle(
        //  color: Colors.black,
      //  )
      ),

  //  buttonColor: Colors.pink,
  );
  final darkTheme=ThemeData.dark().copyWith(
    primaryColor: Colors.purpleAccent.shade700,
      cardColor: Colors.purple.shade700,
      iconTheme: IconThemeData(color: Colors.purpleAccent),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purpleAccent.shade700,
        //brightness: Brightness.dark,
     // textTheme: TextTheme(
     //   headline1: TextStyle(
     //     color: Colors.red
    //    )
    //  )
    ),
   // buttonColor: Colors.greenAccent
  );
}