import 'package:mobil/Screen/Grafik/grafikpage.dart';
import 'package:mobil/Screen/IletisimPages/LinkEklePage.dart';
import 'package:mobil/Screen/ProfilEditPage.dart';
import 'package:mobil/Screen/Testler/TestSonuclarPage.dart';
import 'package:mobil/Screen/ThemesPage.dart';
import 'package:mobil/Screen/SplashPage.dart';
import 'package:mobil/Screen/reportpage.dart';
import 'package:mobil/Themes/themes.dart';

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
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'Screen/SettingsPage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      initialRoute: '/',
      routes: {
        '/':((context) => SplashScreen()),
        '/giris':((context) => GirisPage()),
        '/profil':((context) => ProfilPage()),
        '/profiledit':((context) => ProfileEditPage()),
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
        '/testsonuclar':(context) => ScoresPage(),
        '/grafik':(context) => GrafikPage(),
        '/ayarlar':(context) => AyarlarPage(),
        '/temalar':(context) => ThemesPage(),
        '/report':(context) => ReportPage(),
        '/linkekle':(context) => LinkEklePage(),

      },
    );





  }
}


