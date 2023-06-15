import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Services/authservice.dart';
import '/Screen/MenuPage.dart';
import '../../Variables/global.dart' as global;
import '../PlanPages/PlanDetayPage.dart';




class KayitPage extends StatefulWidget {
  @override
  _KayitPageState createState() => _KayitPageState();
}

class _KayitPageState extends State<KayitPage> {
  TextEditingController mailctr=TextEditingController();
  TextEditingController passctr=TextEditingController();
  TextEditingController usernamectr=TextEditingController();
  AuthService _authService=AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.purple,
                  Colors.pink,
                  Colors.blue
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            SizedBox(height: 60,),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.purple.shade700,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.purple))
                              ),
                              child: TextField(
controller: mailctr,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.purple))
                              ),
                              child: TextField(

                                style: TextStyle(color: Colors.white),
controller: passctr,
                                decoration: InputDecoration(
                                    hintText: "Şifre",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.purple))
                              ),
                              child: TextField(

                                style: TextStyle(color: Colors.white),
controller: usernamectr,
                                decoration: InputDecoration(
                                    hintText: "Kullanıcı Adı",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      SizedBox(height: 30,),
                      Center(
                        child: InkWell(
                          onTap: () {


                            if(mailctr.text.isNotEmpty&&passctr.text.isNotEmpty&&usernamectr.text.isNotEmpty){
                              _authService
                                  .signUp(
                                  name: usernamectr.text,
                                  email: mailctr.text,
                                  password: passctr.text)
                                  .then((value) {
                                if (value == 'Olusturuldu') {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                  Timer(Duration(seconds: 1),(){
                                    Navigator.pushNamed(context, '/menu');
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(value)));
                                }
                              });
                            }else{
                              var fToast=FToast();
                              fToast.init(context);
                              fToast.showToast(
                                  toastDuration: Duration(milliseconds: 1000),gravity: ToastGravity.BOTTOM_RIGHT,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 24,
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.warning),
                                        SizedBox(width: 15,),
                                        Text('Alanları Doldurunuz..')
                                      ],
                                    ),
                                  ));


                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.purple[900]
                            ),
                            child: Center(
                              child: const Text('Kayıt Ol',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

