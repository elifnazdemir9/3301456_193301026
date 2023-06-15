import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Variables/global.dart' as global;
class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/ayarlar');
          }, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/testsonuclar');
          }, icon: Icon(Icons.text_snippet)),
        ],
        centerTitle: true,
        leading: IconButton(onPressed: () {
            Navigator.pushNamed(context, "/giris");
        }, icon: Icon(Icons.logout)),

        backgroundColor: Colors.purple,
        title: const Text('Profil'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Kullanıcılar').doc(_auth.currentUser!.uid).get(),
        builder: (context,index) {
          if (index.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if(index.connectionState==ConnectionState.waiting){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Yükleniyor')
                ],
              ),
            );
          }
          if (!index.hasData) {
            return Center(child: Text("Document does not exist"));
          }

          else {

            return  ListView(
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: global.tema=='acik'?
                          [ Colors.purple,Colors.purple.shade800]:
                          [Colors.grey,Colors.grey.shade700],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.5, 0.9],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                              AssetImage('assets/single-person.png'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                index.data!.get('isim'),
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.pushNamed(context, '/profiledit');
                              }, icon: Icon(Icons.drive_file_rename_outline,color: Colors.white,))
                            ],
                          ),
                          Text(
                            'Psikolog',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                             index.data!.get('email'),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () async{
                              launch(
                                  'https://github.com/elifnazdemir9');
                            },
                            title: Text(
                              'GitHub',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'https://github.com/elifnazdemir9',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                );
          }
        },
      ),

    );
  }
}
