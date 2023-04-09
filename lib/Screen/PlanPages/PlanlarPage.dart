import '/Model/todolist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Planlar extends StatefulWidget {
  const Planlar({Key? key}) : super(key: key);

  @override
  State<Planlar> createState() => _PlanlarState();
}

class _PlanlarState extends State<Planlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: Text(''),centerTitle: true,title: Text(
          "YAPILACAKLAR",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color:Colors.white),
        ),),
        body:
        Container(
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
            itemCount: allPlan.planlar.length,
            itemBuilder: (context, index) {
              return  Card(
                elevation: 8,
                shadowColor:allPlan.planlar[index].durum=="Çok Acil"? Colors.red:
                allPlan.planlar[index].durum=="Acil"?Colors.orange:
                Colors.greenAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.purple.shade50,
                child: ListTile(
                  title: Text(allPlan.planlar[index].baslik,style: TextStyle(fontWeight: FontWeight.bold),),

                  subtitle: Text(allPlan.planlar[index].durum),
                  leading: Icon(Icons.add_alert_rounded,color: allPlan.planlar[index].durum=="Çok Acil"? Colors.red:
                  allPlan.planlar[index].durum=="Acil"?Colors.orange:
                  Colors.greenAccent,),
                  onTap: () {
                    var data=[];
                    data.add(allPlan.planlar[index].baslik);
                    data.add(allPlan.planlar[index].durum);
                    data.add(allPlan.planlar[index].not);
                    data.add(allPlan.planlar[index].checkNot);
                    Navigator.pushNamed(context, "/plandetay",arguments: data);
                  },
                ),
              );
            },
          ),
        ));
  }
}


