import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobil/Services/todoservice.dart';

class PlanDetayPage extends StatefulWidget {
  const PlanDetayPage({Key? key}) : super(key: key);

  @override
  State<PlanDetayPage> createState() => _PlanDetayPageState();
}

class _PlanDetayPageState extends State<PlanDetayPage> {
   String baslik="";
   String durum="";
   List<dynamic> not=[];
   List<dynamic> isDo=[];
   dynamic docid;
  TextEditingController notctr=TextEditingController();
  @override
  Widget build(BuildContext context) {

    late List<dynamic> data;
    data = ModalRoute.of(context)?.settings.arguments as List<dynamic>? ?? [];
    baslik = data[0] ;
    durum =  data[1];
    not = data[2];
    isDo =  data[3];
    docid=data[4];
    return Scaffold(
        appBar: AppBar(title: Text('Plan Detay')),
        body:
        SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Yapılacaklar').doc(docid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

              return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.purple,Colors.purple.shade800
                              ]
                          )
                      ),
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0 )),
                          Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 55,width: MediaQuery.of(context).size.width*.9,
                                        decoration: BoxDecoration(
                                          color:durum=="Çok Acil"? Colors.red:
                                          durum=="Acil"?Colors.orange:Colors.greenAccent,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(baslik,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w700),),
                                          height: 50,
                                          width: MediaQuery.of(context).size.width*.9,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.purple,Colors.purple.shade800]
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                  Stack(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width*.9,
                                        height: MediaQuery.of(context).size.height*.7,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: durum=="Çok Acil"? Colors.red:
                                          durum=="Acil"?Colors.orange:Colors.greenAccent,width: 2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Not:',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic)),
                                                Expanded(
                                                  child: ListView.builder(
                                                       itemCount: not.length,
                                                      itemBuilder: (context, index) {
                                                        return
                                                          Row(
                                                            children: [
                                                              IconButton(onPressed: () {
                                                                  setState(() {
                                                                    TodoService().TodoGuncelle(docid, !snapshot.data!['CheckNot'][index],index);
                                                                    isDo[index] = !isDo[index];
                                                                  });
                                                              }, icon: Icon(snapshot.data!['CheckNot'][index] == true
                                                                  ? Icons.check_box
                                                                  : Icons.check_box_outline_blank,
                                                              color: Colors.white,)),
                                                              Expanded(child: Text(snapshot.data!['Not'][index].toString(),style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic))),
                                                            ],
                                                          );
                                                      }),
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                      Positioned(
                                          bottom: 10,right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(context: context, builder: (context){
                                                return AlertDialog(
                                                  content: Container(
                                                    // height: MediaQuery.of(context).size.height*.5,
                                                    child: TextFormField(
                                                      controller: notctr,
                                                      decoration: InputDecoration(
                                                        labelText: 'Yeni Not Giriniz...',
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [GestureDetector(
                                                      onTap: () {
                                                        TodoService().TodoNotEkle(docid, false,notctr.text);

                                                        if(notctr.text.isNotEmpty){
                                                          setState(() {
                                                            not.add(notctr.text);
                                                            isDo.add(false);
                                                          });
                                                          Navigator.pop(context);
                                                          notctr.clear();
                                                        }
                                                      },
                                                      child: CircleAvatar(child: Text('Ekle'),))],
                                                );
                                              });
                                            },
                                            child: Container(
                                              width: 50,height: 50,
                                              child: Icon(Icons.add,color: Colors.white),
                                              decoration: BoxDecoration(color: durum=="Çok Acil"? Colors.red:
              durum=="Acil"?Colors.orange:Colors.greenAccent,borderRadius: BorderRadius.circular(100)),
                                            ),
                                          )
                                      )
                                    ],
                                  ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            }
          },
        ),

        ));
  }
}


