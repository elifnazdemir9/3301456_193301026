import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'file_utils.dart';

class DosyaEklePage extends StatefulWidget {
  const DosyaEklePage({Key? key}) : super(key: key);

  final String title = "İş Dosyası Ekle";

  @override
  State<DosyaEklePage> createState() => _DosyaEklePageState();
}

class _DosyaEklePageState extends State<DosyaEklePage> {
  String fileContents = "Veri Yok";
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myController,
            ),
          ),
          ElevatedButton(
            child: Text("Dosyaya Kaydet"),
            onPressed: () async {
            File file=await  FileUtils.saveToFile(myController.text);
           if( file.path.isNotEmpty){
             Fluttertoast.showToast(msg: 'Dosya Kaydedildi',
             gravity: ToastGravity.TOP_LEFT,
             backgroundColor: Colors.green,
             textColor: Colors.white);
           }
           else{
             Fluttertoast.showToast(msg: 'Hata oluştu; tekrar deneyiniz');
           }

            },
          ),
          ElevatedButton(
            child: Text("Dosyadan Oku"),
            onPressed: () {
              FileUtils.readFromFile().then((contents) {
                setState(() {
                  fileContents = contents;
                });
              });
            },
          ),
          Text(fileContents),
        ],
      ),

    );
  }
}