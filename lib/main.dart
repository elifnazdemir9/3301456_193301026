
import '/Screen/LoginPages/kayitpage.dart';
import '/Screen/ProfilPage.dart';
import '/Screen/Testler//MotivasyonTestPage.dart';
import '/Screen/Testler/KisilikTestPage.dart';
import '/Screen/Testler/TestSonucPage.dart';


import 'package:flutter/material.dart';
import 'Screen/IletisimPages/BaglantiWebPage.dart';
import 'Screen/IletisimPages/IletisimPage.dart';
import '/Screen/MenuPage.dart';
import 'Screen/PlanPages/PlanEklePage.dart';
import 'Screen/Testler/TestlerPage.dart';
import 'Screen/PlanPages/PlanDetayPage.dart';
import 'Screen/LoginPages/girispage.dart';
import 'Screen/PlanPages/PlanlarPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
      initialRoute: '/',
      routes: {
        '/':((context) => GirisPage()),
        '/profil':((context) => ProfilPage()),
        '/kayit':((context) => KayitPage()),
        '/menu':(context) => MenuPage2(),
        '/plan':(context) => Planlar(),
        '/plandetay':(context) => PlanDetayPage(),
        '/planekle':(context) => PlanEkle(),
        '/iletisim':(context) => IletisimPage(),
        '/baglantiweb':(context) => BaglantiWebPage(),
        '/test':(context) => TestlerPage(),
        '/motivasyontest':(context) => MotivasyonTest(),
        '/kisiliktest':(context) => KisilikTest(),
        '/testsonuc':(context) => TestSonuc(),
      },
    );





  }
}


