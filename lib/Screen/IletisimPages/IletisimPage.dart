import '/Model/baglantilar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IletisimPage extends StatefulWidget {
  const IletisimPage({Key? key}) : super(key: key);

  @override
  State<IletisimPage> createState() => _IletisimPageState();
}

class _IletisimPageState extends State<IletisimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Bağlantılar'),leading: Text('')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.purple,Colors.purple.shade800
                ]
            )
        ),
        child: ListView.builder(
          itemCount: allBaglanti.baglantilar.length,
          itemBuilder: (context, index) {
              return Card(
                color: Colors.purple.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text(allBaglanti.baglantilar[index].baslik),
                  trailing: CircleAvatar(backgroundColor: Colors.purple,child: Icon(Icons.chevron_right)),
                  subtitle: Text(allBaglanti.baglantilar[index].link,style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),),
                  onTap: () {
                    var data=[];
                    data.add(allBaglanti.baglantilar[index].baslik);
                    data.add(allBaglanti.baglantilar[index].link);
                    Navigator.pushNamed(context, "/baglantiweb",arguments: data);
                  },
                ),
              );
        },),
      ),
    );
  }
}
