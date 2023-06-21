
import 'package:mobil/Screen/pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobil/Screen/weather_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Services/api_service.dart';
import '../Variables/global.dart' as global;
import 'dosyaEklePage.dart';
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
            print('hashim');
                Navigator.pushNamed(context, '/ayarlar');
          }, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/testsonuclar');
          }, icon: Icon(Icons.text_snippet)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DosyaEklePage()));
          }, icon: Icon(Icons.file_copy_outlined)),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Divider(),

                          ListTile(


                            onLongPress: () async{
                              print('long pressed');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SyncVisionPdfViewer()));
                              // SfPdfViewer.network(src)
                              // SyncVisionPdfViewer(
                              //   pdfUrl:
                              //   'https://firebasestorage.googleapis.com/v0/b/maarif-567b8.appspot.com/o/School%20Health%20Information%20Form.pdf?alt=media&token=3e23d985-79cd-4bf3-863d-69945257b082&_gl=1*1weoa31*_ga*Mjg1MTAxOTg3LjE2ODIyNDk0MzA.*_ga_CW55HF8NVT*MTY4NjY1MjM1Mi4zMS4xLjE2ODY2NTI0NDYuMC4wLjA.',
                              // );

                          // launch(
                              //   'https://github.com/elifnazdemir9');
                            },
                            title: Text(
                              'CV',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'cift tiklayarak erisebilirsiniz',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                           onHorizontalDragStart: (detail)async{
                              Position kullaniciKonumu=  await determinePosition();
                             String locationName=await getLocationName(kullaniciKonumu.latitude,kullaniciKonumu.longitude);

                                // buradan api'y' cagiracaz
                                ApiCall apiCall=ApiCall();
                              WeatherData? weatherData= await apiCall.getWeather(kullaniciKonumu);


                               Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage(weatherData:weatherData!, locationName: locationName,)));



                        },
                            child: ListTile(
                              onTap: () async{
                               //  // ilk kullanici konumu aliyoruz
                               //  Position kullaniciKonumu=  await determinePosition();
                               // String locationName=await getLocationName(kullaniciKonumu.latitude,kullaniciKonumu.longitude);
                               //
                               //    // buradan api'y' cagiracaz
                               //    ApiCall apiCall=ApiCall();
                               //  WeatherData? weatherData= await apiCall.getWeather(kullaniciKonumu);
                               //
                               //
                               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage(weatherData:weatherData!, locationName: locationName,)));
                               //
                               //
                               //
                               // // launch(
                               //   //   'https://github.com/elifnazdemir9');
                              },
                              title: Text(
                                'Weather',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'www.openweather.com',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
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
