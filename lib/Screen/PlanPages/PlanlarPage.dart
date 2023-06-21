import 'package:mobil/Screen/Grafik/grafikpage.dart';
import 'package:mobil/Screen/reportpage.dart';
import 'package:mobil/Services/todoservice.dart';

import '../../Themes/themes.dart';
import '/Model/todolist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Variables/global.dart' as global;


class Planlar extends StatefulWidget {
  const Planlar({Key? key}) : super(key: key);

  @override
  State<Planlar> createState() => _PlanlarState();
}

class _PlanlarState extends State<Planlar> {
  String dropdownvalue = '';
  var items = [
    'Çok Acil',
    'Acil',
    'Acil Değil'
  ];
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Yapılacaklar').snapshots(),
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
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(leading: Text(''),centerTitle: true,title: GestureDetector(
            onTap: () {
              print('hi');
                        var data=[];
              data.add(snapshot.data?.size);
              data.add(snapshot.data?.docs);
              Navigator.pushNamed(context, '/grafik',arguments: data);
            },
            child: Text(
              "YAPILACAKLAR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
            ),
          ),),
          body:Column(
            children: [
              TabBar(
                  tabs: [
                Tab(
                  icon: Icon(Icons.today_outlined,color: Colors.deepPurple,),
                ),
                Tab(icon: Icon(Icons.pie_chart_outline,color: Colors.deepPurple,)),
                Tab(icon: Icon(Icons.insert_drive_file_outlined,color: Colors.deepPurple,))
              ]),
              Expanded(
                child: TabBarView(
                    children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors:
                            global.tema=='acik'?
                            [ Colors.purple,Colors.purple.shade800]:
                            [Colors.grey,Colors.grey.shade700]
                        )
                    ),
                    child:
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            return
                              Card(elevation: 8,
                                shadowColor:snapshot.data!.docs[index]['Durum']=="Çok Acil"? Colors.red:
                                snapshot.data!.docs[index]['Durum']=="Acil"?Colors.orange:
                                Colors.greenAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                // color: Colors.purple.shade50,
                                child: Dismissible(
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Silmek istediğine emin misin'),
                                          actions: [
                                            ElevatedButton(onPressed: () {
                                              print('hello there');
                                                        TodoService().TodoSil(snapshot.data!.docs[index].id);
                                              Navigator.pop(context);
                                            }, child: Text('Sil')),
                                            ElevatedButton(onPressed: () {
                                              Navigator.pop(context);
                                            }, child: Text('İptal'))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  background: Container(color: Colors.red,child: Align(
                                      alignment: Alignment.centerRight
                                      ,child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Sil',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ))),

                                  key: Key(snapshot.data!.docs[index].id),
                                  child: ListTile(
                                    title: Text(snapshot.data!.docs[index]['Baslik'],style: TextStyle(fontWeight: FontWeight.bold),),

                                    subtitle: Text(snapshot.data!.docs[index]['Durum']),

                                    leading: GestureDetector(
                                      onDoubleTap: () {
                                        showDialog(context: context, builder: (BuildContext buildcontext) {
                                          return AlertDialog(title: Center(child: Text('Durum')),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                            content: Container(
                                              height: 90,
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.add_alert_rounded,color: snapshot.data!.docs[index]['Durum']=="Çok Acil"? Colors.red:
                                                  snapshot.data!.docs[index]['Durum']=="Acil"?Colors.orange:
                                                  Colors.greenAccent,
                                                  ),
                                                  DropdownButton(

                                                    // dropdownColor: Colors.white,
                                                    value: snapshot.data!.docs[index]['Durum'].toString(),
                                                    items: items.map((String items) {
                                                      return DropdownMenuItem(
                                                          value: items, child: Text(items));
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      print(newValue);
                                                      setState(() {
                                                        TodoService().TodoDurumGuncelle(
                                                            snapshot.data!.docs[index].id,
                                                            newValue!
                                                        );
                                                      });
                                                      Navigator.pop(context);
                                                    },

                                                  ),
                                                ],
                                              ),
                                            ),);
                                        });
                                      },
                                      child: Icon(
                                        Icons.add_alert_rounded,color: snapshot.data!.docs[index]['Durum']=="Çok Acil"? Colors.red:
                                      snapshot.data!.docs[index]['Durum']=="Acil"?Colors.orange:
                                      Colors.greenAccent,
                                      ),
                                    ),

                                    onTap: () {
                                      print(snapshot.data!.docs[index]['Not']);
                                      var data=[];
                                      data.add(snapshot.data!.docs[index]['Baslik']);
                                      data.add(snapshot.data!.docs[index]['Durum']);
                                      data.add(snapshot.data!.docs[index]['Not']);
                                      data.add(snapshot.data!.docs[index]['CheckNot']);
                                      data.add(snapshot.data!.docs[index].id);
                                      Navigator.pushNamed(context, "/plandetay",arguments: data);
                                    },
                                    onLongPress: () {
                                      List<dynamic> notlar=snapshot.data!.docs[index]['Not'];
                                      showDialog(context: context, builder: (BuildContext buildcontext) {
                                        return AlertDialog(title: Center(child: Text(snapshot.data!.docs[index]['Baslik'])),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          content: Container(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: notlar.length,
                                                itemBuilder: (context,i){
                                                  return ListTile(
                                                    title: Text(snapshot.data!.docs[index]['Not'][i].toString()),
                                                    trailing: Icon(snapshot.data!.docs[index]['CheckNot'][i] == true
                                                        ? Icons.check_box
                                                        : Icons.check_box_outline_blank,
                                                    ),
                                                  );
                                                }),
                                          ),);
                                      });
                                    },
                                  ),
                                ),
                              );
                          }),
                    ),


                    // child: ListView.builder(
                    //   itemCount: allPlan.planlar.length,
                    //   itemBuilder: (context, index) {
                    //     return  Card(
                    //       elevation: 8,
                    //       shadowColor:allPlan.planlar[index].durum=="Çok Acil"? Colors.red:
                    //       allPlan.planlar[index].durum=="Acil"?Colors.orange:
                    //       Colors.greenAccent,
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    //       color: Colors.purple.shade50,
                    //       child: ListTile(
                    //         title: Text(allPlan.planlar[index].baslik,style: TextStyle(fontWeight: FontWeight.bold),),
                    //
                    //         subtitle: Text(allPlan.planlar[index].durum),
                    //
                    //         leading: Icon(
                    //           Icons.add_alert_rounded,color: allPlan.planlar[index].durum=="Çok Acil"? Colors.red:
                    //         allPlan.planlar[index].durum=="Acil"?Colors.orange:
                    //         Colors.greenAccent,
                    //         ),
                    //
                    //         onTap: () {
                    //           var data=[];
                    //           data.add(allPlan.planlar[index].baslik);
                    //           data.add(allPlan.planlar[index].durum);
                    //           data.add(allPlan.planlar[index].not);
                    //           data.add(allPlan.planlar[index].checkNot);
                    //           Navigator.pushNamed(context, "/plandetay",arguments: data);
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                  GrafikPage(),
                  ReportPage()
                ]),
              )
            ],
          )

        ),
      );
  }});
}}


