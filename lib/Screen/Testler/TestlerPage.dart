import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestlerPage extends StatefulWidget {
  const TestlerPage({Key? key}) : super(key: key);

  @override
  State<TestlerPage> createState() => _TestlerPageState();
}

class _TestlerPageState extends State<TestlerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Text(''),centerTitle: true,title:Text('Testler')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.purple,Colors.purple.shade800
                ]
            )
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 25,),
              Text('Kendinizi test etmek istediğiniz konuyu seçiniz...',style: TextStyle(fontSize: 24,color: Colors.white)),
              SizedBox(height: 8,),
              Wrap(
                runSpacing: 10,runAlignment: WrapAlignment.center,spacing: 25,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/motivasyontest");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xffc471f5),Color(0xfffa71cd)]),
                        border: Border.all(color: Colors.purple.shade50,width: 1.5),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Motivasyon Test Uygula',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/kisiliktest");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xffc471f5),Color(0xfffa71cd)]),
                          border: Border.all(color: Colors.purple.shade50,width: 1.5),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Kisilik Test Uygula',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
