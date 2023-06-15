import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobil/Services/authservice.dart';
import 'package:mobil/Services/todoservice.dart';

class AyarlarPage extends StatelessWidget {
  bool isNoti=false;
  bool isVoice=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Bildirimleri Aç/Kapat'),
            trailing: StatefulBuilder(
              builder: (context, setState) => Switch(
                value: isNoti,
                onChanged: (newValue) {
                  setState(()=>
                  isNoti=newValue
                  );
                  // Sesli hatırlatma ayarlarını güncelle
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Sesli Hatırlatma'),
            trailing: StatefulBuilder(
              builder: (context, setState) => Switch(
              value: isVoice,
              onChanged: (newValue) {
                setState(()=>
                    isVoice=newValue
                );
                // Sesli hatırlatma ayarlarını güncelle
              },
            ),
          ),
          ),
          ListTile(
            title: Text('Tema'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/temalar');
              // Tema ayarları sayfasını aç
            },
          ),
          ListTile(
            title: Text('Hesabı Sil'),
            trailing: Icon(Icons.delete),
            onTap: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  content: Text('Hesabınızı silmek istediğinize emin misiniz?'),
                  actions: [
                    CupertinoButton(onPressed: () {
                      AuthService().deleteAccount();
                      Navigator.pushNamed(context, '/giris');
                    },
                    child: Text('Evet',style: TextStyle(color: Colors.red),),),
                    CupertinoButton(onPressed: () {
                        Navigator.pop(context);
                    },
                      child: Text('İptal',style: TextStyle(color: Colors.greenAccent),),)
                  ],
                );
              });
            },
          ),
        ],
      ),
    );
  }
}