import '/Model/baglantilar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Variables/global.dart' as global;
import 'package:gradient_floating_button/gradient_floating_button.dart';
class IletisimPage extends StatefulWidget {
  const IletisimPage({Key? key}) : super(key: key);

  @override
  State<IletisimPage> createState() => _IletisimPageState();
}

class _IletisimPageState extends State<IletisimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Bağlantılar'),
          leading: Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GradientFloatingButton().withLinearGradient(
              buttonHeight: 32,buttonWidth: 32,
                onTap: () {
                  Navigator.pushNamed(context, '/linkekle');
                },
                iconWidget: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                alignmentEnd: Alignment.topRight,
                alignmentBegin: Alignment.bottomLeft,
                colors:  global.tema=='acik'?
            [ Colors.purple,Colors.purple.shade800]:
                [Colors.grey,Colors.grey.shade700]
            ),
          ),
        ],

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: global.tema=='acik'?
                [Colors.purple,Colors.purple.shade800]:
                [Colors.grey,Colors.grey.shade700]
            )
        ),
        child:  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Links').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
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
            if (!snapshot.hasData) {
              return Center(child: Text("Document does not exist"));
            }

            else {

              return  Expanded(
                child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){

                      return
                        Card(
                          // color: Colors.purple.shade50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

                          child: ListTile(
                            title:Text(snapshot.data!.docs[index]['baslik']),
                            subtitle: Text(snapshot.data!.docs[index]['link'],style: TextStyle(
                                   fontStyle: FontStyle.italic,
                                   color: Colors.blue,
                                 )),
                            onTap: () {
                              var data=[];
                              data.add(snapshot.data!.docs[index]['baslik']);
                              data.add(snapshot.data!.docs[index]['link']);
                              Navigator.pushNamed(context, "/baglantiweb",arguments: data);
                            },
                          ),
                        );
                    }),
              );
            }
          },
        ),

      ),
    );
  }
}
