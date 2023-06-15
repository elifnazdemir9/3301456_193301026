import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobil/Services/todoservice.dart';
import 'indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Variables/global.dart' as global;
class GrafikPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // late List<dynamic> data;
    // data = ModalRoute.of(context)?.settings.arguments as List<dynamic>? ?? [];
    // todoSize = data[0] ;
    // docments = data[1] ;

    return Scaffold(
      body: FutureBuilder(
          // future: FirebaseFirestore.instance.collection('Yapılacaklar').get(),
          future: TodoService().todoSay(),
          builder: (BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              //return Center(child: CircularProgressIndicator());
              return Container(
                  alignment: Alignment.center,
                  color: Colors.grey.shade100,child: Text('Yükleniyor..')
              );
            }

            return
              Container(alignment: Alignment.center,color: Colors.purpleAccent.shade700,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: Card(
                      color: Colors.purple.shade100,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections()),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[
                              Text('Kategori',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(textColor: Colors.black,
                                color: Colors.green,
                                text: 'Yapılanlar: ${global.checkNotCount}',
                                isSquare: false,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(textColor: Colors.black,
                                color: Colors.orange,
                                text: 'Yapılmayanlar: ${global.checkNotFalseCount}',
                                isSquare: false,
                              ),
                              SizedBox(
                                height: 4,
                              ),

                              SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ); }
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:  Colors.green,
            value: double.parse(global.checkNotCount.toString())  ,
            title: 'Yapılanlar',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: double.parse(global.checkNotFalseCount.toString()),
            title: 'Yapılmayanlar',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );

        default:
          throw Error();
      }
    });
  }
}