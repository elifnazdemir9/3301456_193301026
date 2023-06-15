import 'package:flutter/material.dart';
import 'package:mobil/Services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController mailctr=TextEditingController();
  TextEditingController isimctr=TextEditingController();
  bool _isNameAnimated = true;
  bool _isMailAnimated = true;
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Kullanıcılar').doc(_auth.currentUser!.uid).get(),
      builder: (context, snapshot) {
        isimctr.text=snapshot.data!.get('isim');
        mailctr.text=snapshot.data!.get('email');
        if(snapshot.connectionState==ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Yükleniyor')
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Profil Düzenleme'),),
          body: Container(
            width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isNameAnimated = !_isNameAnimated;
                    });
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _isNameAnimated ? Colors.purple.shade700 : Colors.purple.shade100,

                    ),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 800),
                     width: _isNameAnimated ? MediaQuery.of(context).size.width*0.8 : MediaQuery.of(context).size.width,
                    // height: _isAnimated ? 50.0 : 100.0,
                    child: Container(
                      margin: EdgeInsets.only(right: 5,left: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.purple))
                      ),
                      child: _isNameAnimated ?Text('İsim: ${isimctr.text}',style: TextStyle(color: Colors.white),):TextField(
                        style: TextStyle(color: Colors.black),
                        controller: isimctr,
                        decoration: InputDecoration(
                            hintText: "İsim",

                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _isNameAnimated=true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMailAnimated = !_isMailAnimated;
                    });
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _isMailAnimated ? Colors.purple.shade700 : Colors.purple.shade100,
                    ),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 800),
                     width: _isMailAnimated ? MediaQuery.of(context).size.width*0.8 : MediaQuery.of(context).size.width,
                    // height: _isAnimated ? 50.0 : 100.0,
                    child: Container(
                      margin: EdgeInsets.only(right: 5,left: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.purple))
                      ),
                      child: _isMailAnimated ?Text('Mail: ${mailctr.text}',style: TextStyle(color: Colors.white),):TextField(
                        style: TextStyle(color: Colors.black),
                        controller: mailctr,
                        decoration: InputDecoration(
                            hintText: "Mail",

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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                    onPressed: () {
                  AuthService().mailUpdate(mailctr.text, isimctr.text);
                  Navigator.pushNamed(context, '/menu');
                }, child: Text('Güncelle'))
              ],
            ),
          ),
        );
      }
    );
  }
}

