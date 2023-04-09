import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Screen/MenuPage.dart';
import '../../Variables/global.dart' as global;
import '../PlanPages/PlanDetayPage.dart';
import 'package:fluttertoast/fluttertoast.dart';




class GirisPage extends StatefulWidget {
  @override
  _GirisPageState createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {
  TextEditingController mailctr=TextEditingController();
  TextEditingController passctr=TextEditingController();
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
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      SizedBox(height: 30,),
                      Center(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if(mailctr.text.isNotEmpty){
                                global.kullanicimail=mailctr.text;
                                global.kullaniciadi=mailctr.text.substring(0,mailctr.text.length-(mailctr.text.length/2).toInt());
                                Navigator.pushNamed(context, "/menu");
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
                                          Text('Email Alanını Doldurunuz..')
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
                                  child: const Text('Giriş',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                          ),
                          ),
                        ),
                      SizedBox(height: 10,),
                      Container(height: 50,
                        child: Column(
                          children: [
                            Text('Hesabınız yoksa'),
                            SizedBox(height: 5,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/kayit");
                                },
                                child: Text('Kayıt Ol')),
                          ],
                        ),
                      )


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

