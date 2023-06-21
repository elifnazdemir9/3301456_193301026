import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Services/authservice.dart';
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
  bool _isSifreAnimated = true;
  bool _isMailAnimated = true;

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
                      Expanded(child: SizedBox(height: 40,)),
                      Container(
                        width: MediaQuery.of(context).size.width*.95,

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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isMailAnimated = !_isMailAnimated;
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 500),
                                // width: _isAnimated ? 200.0 : 100.0,
                                // height: _isAnimated ? 50.0 : 100.0,
                                color: _isMailAnimated ? Colors.purple.shade700 : Colors.purple.shade100,
                                child: Container(
                                  margin: EdgeInsets.only(right: 5,left: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.purple))
                                  ),
                                  child: _isMailAnimated ?Text('Email: ${mailctr.text}',style: TextStyle(color: Colors.white),):TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: mailctr,
                                    decoration: InputDecoration(
                                        hintText: "Email",

                                        hintStyle: TextStyle(color: Colors.black),
                                        border: InputBorder.none
                                    ),
                                    onSubmitted: (value) {
                                      setState(() {
                                        _isMailAnimated=true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSifreAnimated = !_isSifreAnimated;
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 500),
                                // width: _isAnimated ? 200.0 : 100.0,
                                // height: _isAnimated ? 50.0 : 100.0,
                                color: _isSifreAnimated ? Colors.purple.shade700 : Colors.purple.shade100,
                                child: Container(
                                  margin: EdgeInsets.only(right: 5,left: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.purple))
                                  ),
                                  child: _isSifreAnimated ?Text('Şifre: ${passctr.text}',style: TextStyle(color: Colors.white),):TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: passctr,
                                    decoration: InputDecoration(
                                        hintText: "Şifre",

                                        hintStyle: TextStyle(color: Colors.black),
                                        border: InputBorder.none
                                    ),
                                    onSubmitted: (value) {
                                      setState(() {
                                        _isSifreAnimated=true;
                                      });
                                    },
                                  ),
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
                                _authService.signIn(
                                    email: mailctr.text, password: passctr.text)
                                    .then((value) {
                                  if(value=="Hosgeldin"){
                                    Navigator.pushNamed(context, '/menu');
                                  }else{

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
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
                            Text('Hesabınız yoksa',style: TextStyle(color: Colors.black),),
                            SizedBox(height: 5,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/kayit");
                                },
                                child: Text('Kayıt Ol',style: TextStyle(color: Colors.black))),
                          ],
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

