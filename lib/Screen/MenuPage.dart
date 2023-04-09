import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import '/Screen/ProfilPage.dart';

import 'PlanPages/PlanEklePage.dart';
import 'PlanPages/PlanlarPage.dart';
import 'package:flutter/material.dart';
import 'IletisimPages/IletisimPage.dart';
import 'Testler/TestlerPage.dart';
import '../Screen/ProfilPage.dart';


import 'PlanPages/PlanDetayPage.dart';

class MenuPage2 extends StatefulWidget {


  @override
  _MenuPage2State createState() => _MenuPage2State();
}

class _MenuPage2State extends State<MenuPage2> {
  int _currentIndex = 0;
  int selectedIndex=0;

  int maxCount = 5;
  final _pageController = PageController(initialPage: 0);
  final List<Widget> bottomBarPages = [
    const Planlar(),
    const PlanEkle(),
    const IletisimPage(),
    const TestlerPage(),
    const ProfilPage(),
  ];
  ///BottomBar'daki butonlara tiklandığinda gösterilecek ekranlar.
  List<Widget> _widgetOptions=<Widget>[

    //FirstPage(),
    Planlar(),
    PlanEkle(),
    IletisimPage(),
    TestlerPage(),
    ProfilPage()
    //  ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
          extendBody: true,
          bottomNavigationBar: (bottomBarPages.length <= maxCount)
              ? AnimatedNotchBottomBar(
            pageController: _pageController,
            color: Colors.white,
            showLabel: false,
            notchColor: Colors.purple,
            bottomBarItems: [
              const BottomBarItem(
                inActiveItem: Icon(
                  Icons.access_time_filled_outlined,
                  color: Colors.blueGrey,
                ),
                activeItem: Icon(
                  Icons.access_time_filled_outlined,
                  color: Colors.white,
                ),

              ),
              const BottomBarItem(
                inActiveItem: Icon(
                  Icons.add_alert,
                  color: Colors.blueGrey,
                ),
                activeItem: Icon(
                  Icons.add_alert,
                  color: Colors.white,
                ),

              ),


              BottomBarItem(
                inActiveItem: Icon(
                  Icons.link,
                  color: Colors.blueGrey,
                ),
                activeItem: Icon(
                  Icons.link,
                  color: Colors.white,
                ),

              ),
              const BottomBarItem(
                inActiveItem: Icon(
                  Icons.list_alt,
                  color: Colors.blueGrey,
                ),
                activeItem: Icon(
                  Icons.list_alt,
                  color: Colors.white,
                ),

              ),
              const BottomBarItem(
                inActiveItem: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
                activeItem: Icon(
                  Icons.person,
                  color: Colors.white,
                ),

              ),
            ],
            onTap: (index) {
              /// control your animation using page controller
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          )
              : null,
        ),
      );
    }
  }

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(

      textTheme: _buildShrineTextTheme(base.textTheme),
    );
  }

  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
      caption: base.caption?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,

      ),
      button: base.button?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,

      ),
    )
        .apply(
      fontFamily: 'Rubik',

    );
  }







