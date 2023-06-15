import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/dbhelper.dart';
import '../../Variables/global.dart' as global;
class TestSonuc extends StatefulWidget {
  @override
  _TestSonucState createState() => _TestSonucState(); }
class _TestSonucState extends State<TestSonuc> {

  late String kullaniciAdi;
  late int puan;
  late String hangiTest;
  late String sonuc;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    late List<dynamic> data1;
    data1 = ModalRoute.of(context)?.settings.arguments as List<dynamic>? ?? [];
    kullaniciAdi=data1[0];
    puan=data1[1];
    hangiTest=data1[2];
    if(puan>=16){
      if(hangiTest=="motivasyon"){
        sonuc="Yüksek motivasyona sahipsiniz! Başarılarınızın tadını çıkarır ve hedeflerinize ulaşmak için kararlı bir şekilde çalışırsınız.";
      }else{
        sonuc="Maceracı ve keşfetmeye açık bir kişiliğiniz var. Yeni deneyimler ve aktiviteler keşfetmekten hoşlanıyorsunuz ve yaratıcılığınızı serbest bırakmak için fırsatlar arıyorsunuz.";
      }
    }
    else if(puan>=12 && puan<16){
      if(hangiTest=="motivasyon"){
        sonuc="Orta derecede motivasyona sahipsiniz. Hedeflerinize ulaşmak için çaba sarf ediyor olsanız da, zaman zaman kendinizi motivasyonsuz hissedebilirsiniz.";
      }else{
        sonuc="Disiplinli ve odaklanmış bir kişiliğiniz var. Hedeflerinize ulaşmak için planlı ve disiplinli bir şekilde çalışırsınız.";
      }
    }
    else if(puan>=8 && puan<12){
      if(hangiTest=="motivasyon"){
        sonuc="Düşük motivasyona sahipsiniz. Başarınızı yeterince takdir etmiyor ve hedeflerinize ulaşmak için yeterli çabayı sarf etmiyor olabilirsiniz. Kendinizi daha fazla motive etmek için çalışmanız gerekebilir.";
      }else{
        sonuc="Girişken ve sosyal bir kişiliğiniz var. Başkalarıyla kolayca iletişim kuruyor ve onları etkilemek için çaba sarf ediyorsunuz.";
      }
    }
    else{
      if(hangiTest=="motivasyon"){
        sonuc="Çok düşük motivasyona sahipsiniz. Kendinizi motive etmek için ciddi bir çaba sarf etmeniz gerekebilir. Başarılarınızı takdir etmeyi öğrenmeli ve hedeflerinize ulaşmak için daha fazla çaba göstermelisiniz.";
      }else{
        sonuc="Duygusal bir kişiliğiniz var. Duygularınızı açıkça ifade etmeyi seviyorsunuz ve diğer insanların duygularına kolayca empati kuruyorsunuz.";
      }
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Kullanıcılar').doc(_auth.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
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
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Sonuç'),
              leading: Text(''),
              actions:[
                IconButton(
                icon: Icon(Icons.text_snippet),
                onPressed: () {
                  Navigator.pushNamed(context, '/testsonuclar');
                },
              ),]
            ),
            body: Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                    colors: [Color(0xffc471f5),Color(0xfffa71cd)]
                ),
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text( "Sayın "+snapshot.data!.get('isim'),style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center),
                  Text(sonuc,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center),
                  Padding(padding: EdgeInsets.all(10)),

                  SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/menu");
                      },
                      child: Container(height: 50,width: 50,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),color: Colors.white
                      ),child: Icon(Icons.home),),
                    )


                ],
              ),
            ),
          );
        }
      ),
    ); } }