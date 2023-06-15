import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Variables/global.dart' as global;
class ThemesPage extends StatelessWidget {
  const ThemesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temalar'),
      //     leading: IconButton(onPressed: () {Navigator.pushNamed(context, '/menu');
      // }, icon: Icon(Icons.arrow_back))
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Açık'),
                  Radio(value: false, groupValue: Get.isDarkMode, onChanged: (value) {
                    Get.changeThemeMode(ThemeMode.light);
                    global.tema='acik';
                  },),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Koyu'),
                  Radio(value: true, groupValue: Get.isDarkMode, onChanged: (value) {
                    Get.changeThemeMode(ThemeMode.dark);
                    global.tema='koyu';
                  },),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
