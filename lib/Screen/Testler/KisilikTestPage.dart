import 'package:flutter/material.dart';



class KisilikTest extends StatefulWidget {
  @override
  _KisilikTestState createState() => _KisilikTestState();
}

class _KisilikTestState extends State<KisilikTest> {
  String kullaniciAdi = '';
  var sorular = [
    {
      'soru': 'Sizce kendinizi nasıl tanımlarsınız?',
      'cevaplar': [
        'Hayalperest ve yaratıcıyım',
        'Pratik ve gerçekçiyim',
        'Disiplinli ve kararlıyım',
        'Empatik ve duygusalım'
      ],
      'puanlar': [3, 1, 4, 2]
    },
    {
      'soru': 'Stresli bir durumda ne yaparsınız?',
      'cevaplar': [
        'Duygularımı ifade ederim',
        'Sorunun kaynağını belirlerim ve çözüm ararım',
        'Kendimi motive etmek için şarkı söylerim veya yürüyüşe çıkarım',
        'Kendimle baş başa kalırım ve iç sesimi dinlerim'
      ],
      'puanlar': [2, 4, 3, 1]
    },
    {
      'soru': 'Yeni biriyle tanıştığınızda ne yapıyorsunuz?',
      'cevaplar': [
        'Konuşmaya başlamakta zorlanıyorum',
        'Konuşmaları başlatmakta hiç sorun yaşamam',
        'Kendimi açık bir şekilde ifade ederim',
        'Diğer kişinin ilgisini çekmek için şakalar yaparım'
      ],
      'puanlar': [2, 4, 3, 1]
    },
    {
      'soru': 'Sizce hayatta en önemli şey nedir?',
      'cevaplar': [
        'Mutluluk ',
        'Başarı ',
        'Aile',
        'Sağlık'
      ],
      'puanlar': [3, 4, 2, 1]
    },
    {
      'soru': 'Hangi aktivitelerden hoşlanırsınız?',
      'cevaplar': [
        'Sanat faaliyetleri (müze, tiyatro vb.) ',
        'Doğa yürüyüşleri ',
        'Spor veya egzersiz yapmak',
        'Kitap okumak veya film izlemek'
      ],
      'puanlar': [3, 1, 4, 2]
    },
  ];
  int mevcutSoru = 0;
  int puan = 0;
  String mevcutcevap = '';

  void BitireYolla() {
    var data = [];
    data.add(kullaniciAdi);
    data.add(puan);
    data.add("kisilik");
    Navigator.pushNamed(context, "/testsonuc",arguments: data);
  }

  void kontrolEt() {

    if (mevcutSoru > sorular.length-1) {
      mevcutSoru = 0;
      BitireYolla();
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
                      minimumSize: Size(250, 60)),
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
                    style: TextStyle(fontSize: 24, color: Colors.black),
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
                      minimumSize: Size(250, 60)),
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
                    style: TextStyle(fontSize: 24, color: Colors.black),
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
                      minimumSize: Size(250, 60)),
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
                    style: TextStyle(fontSize: 24, color: Colors.black),
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
                      minimumSize: Size(250, 60)),
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
                    style: TextStyle(fontSize: 24, color: Colors.black),
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