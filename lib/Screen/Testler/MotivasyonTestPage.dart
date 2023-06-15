import 'package:flutter/material.dart';
import 'package:mobil/Services/dbhelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobil/Variables/global.dart' as global;
class MotivasyonTest extends StatefulWidget {
  @override
  _MotivasyonTestState createState() => _MotivasyonTestState();
}

class _MotivasyonTestState extends State<MotivasyonTest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String kullaniciAdi = '';
  var sorular = [
    {
      'soru': 'Başarılı olduğunuzda ne hissedersiniz?',
      'cevaplar': [
        'Kendimle gurur duyarım ve kendimi kutlarım.',
        'Başarıya rağmen biraz endişeli hissederim.',
        'Başarının geçici olduğunu düşünürüm.',
        'Başarının tesadüfen gerçekleştiğini düşünürüm.'
      ],
      'puanlar': [4, 3, 2, 1]
    },
    {
      'soru': 'Bir hedef belirlediğinizde, ne kadar sürede başaracağınızı düşünürsünüz?',
      'cevaplar': [
        'Ne kadar süreceğini düşünmem, sadece hedefe ulaşmak için çalışırım.',
        'Hedefe ne kadar sürede ulaşabileceğimi düşünürüm ve planımı buna göre yaparım.',
        'Hedefe ulaşmanın çok uzun zaman alacağını düşündüğüm için bazen başlamayı bile düşünmem.',
        'Hedefe ulaşmak için yeterli beceri ve kaynaklara sahip olmadığım için hedef koymam.'
      ],
      'puanlar': [4, 3, 2, 1]
    },
    {
      'soru': 'İşinizi seviyor musunuz?',
      'cevaplar': [
        'Evet, işimi gerçekten seviyorum.',
        'İşimde bazı şeyleri seviyorum, bazı şeyleri sevmiyorum.',
        'İşimde pek bir şey sevmiyorum, ama yapmam gerekiyor.',
        'İşimden nefret ediyorum.'
      ],
      'puanlar': [4, 3, 2, 1]
    },
    {
      'soru': 'Stresli bir durumla karşılaştığınızda nasıl tepki verirsiniz?',
      'cevaplar': [
        'Sakin kalırım ve sorunu çözmeye çalışırım.',
        'Endişelenirim ama yine de sorunu çözmeye çalışırım.',
        'Stresli durumlarla başa çıkmakta zorlandığım için yardım isterim.',
        'Paniklerim ve sorunu çözmek yerine kaçmaya çalışırım.'
      ],
      'puanlar': [4, 3, 2, 1]
    },
    {
      'soru': 'Başkalarının sizi takdir ettiğini hissettiğinizde, nasıl hissedersiniz?',
      'cevaplar': [
        'Çok mutlu ve motive olmuş hissederim.',
        'Biraz mutlu ve motive olmuş hissederim.',
        'Nötr hissederim, takdir edilmek benim için çok önemli değil.',
        'Hiç mutlu veya motive olmuş hissetmem.'
      ],
      'puanlar': [4, 3, 2, 1]
    }
  ];
  int mevcutSoru = 0;
  int puan = 0;
  String mevcutcevap = '';
  Future<void> _saveScore() async {
    final userDocRef = FirebaseFirestore.instance
        .collection('Kullanıcılar')
        .doc(_auth.currentUser!.uid);
    userDocRef.get().then((DocumentSnapshot documentSnapshot) async{
      if (documentSnapshot.exists) {
        // Belge mevcut olduğunda alanları alabilirsiniz.
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;;
        // Alanlara erişim için ilgili anahtarları kullanabilirsiniz.
        var username = data?['isim'];
        var email = data!['email'];
        final dbHelper = DatabaseHelper.instance;
        await dbHelper.insertScore(username+" -Motivasyon", puan);
        // ...
      }
    });

    print(puan);
    // Navigator.pop(context);
  }
  void BitireYolla() {
    //
    var data = [];
    data.add(kullaniciAdi);
    data.add(puan);
    data.add("motivasyon");
    print(puan);
    Navigator.pushNamed(context, "/testsonuc",arguments: data);
  }

  void kontrolEt() {

    if (mevcutSoru > sorular.length-1) {
      mevcutSoru = 0;
      BitireYolla();
      _saveScore();
    }
  }

  @override
  Widget build(BuildContext context) {

    late List<String> cevaplistesi;
    late List<int> puanlistesi;
    cevaplistesi = sorular[mevcutSoru]['cevaplar'] as List<String>;
    puanlistesi = sorular[mevcutSoru]['puanlar'] as List<int>;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

              colors: [Color(0xffc471f5),Color(0xfffa71cd)]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  sorular[mevcutSoru]['soru'].toString(),
                  style: TextStyle(fontSize: 36, color: Colors.white,),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(width: 3, color: Colors.black)),
                      primary: Colors.white,
                      minimumSize: Size(double.infinity, 70)),
                  onPressed: () {
                    setState(() {
                      mevcutcevap = cevaplistesi[0].toString();
                      puan=puan+puanlistesi[0];
                      mevcutSoru++;
                    });
                    kontrolEt();
                  },
                  child: Text(
                    cevaplistesi[0],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(width: 3, color: Colors.black)),
                      primary: Colors.white,
                      minimumSize: Size(double.infinity, 60)),
                  onPressed: () {
                    setState(() {
                      mevcutcevap = cevaplistesi[1].toString();
                      puan=puan+puanlistesi[1];
                      mevcutSoru++;

                    });
                    kontrolEt();
                  },
                  child: Text(
                    cevaplistesi[1],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(width: 3, color: Colors.black)),
                      primary: Colors.white,
                      minimumSize: Size(double.infinity, 60)),
                  onPressed: () {
                    setState(() {
                      mevcutcevap = cevaplistesi[2].toString();
                      puan=puan+puanlistesi[2];
                      mevcutSoru++;

                    });
                    kontrolEt();
                  },
                  child: Text(
                    cevaplistesi[2],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(width: 3, color: Colors.black)),
                      primary: Colors.white,
                      minimumSize: Size(double.infinity, 60)),
                  onPressed: () {
                    setState(() {
                      mevcutcevap = cevaplistesi[3].toString();
                      puan=puan+puanlistesi[3];
                      mevcutSoru++;

                    });
                    kontrolEt();
                  },
                  child: Text(
                    cevaplistesi[3],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}