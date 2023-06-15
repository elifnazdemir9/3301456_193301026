import 'package:flutter/material.dart';
import 'package:mobil/Services/todoservice.dart';
import '../Variables/global.dart' as global;
class ReportPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TodoService().todoSay(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Expanded(flex: 2,
                  child: GridView.count(

                    crossAxisCount: 2, // İki sütunlu bir ızgara
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.green ,
                          child: Column(
                            children: [
                              Text('Notları Yapılan Başlıklar',style: TextStyle(fontWeight: FontWeight.bold)),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: global.yapilanBaslik.length,
                                    itemBuilder: (context,index){
                                      return Text(global.yapilanBaslik[index]);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.orange,
                          child: Column(
                            children: [
                              Text('Notları Yapılmayan Başlıklar',style: TextStyle(fontWeight: FontWeight.bold),),
                              Expanded(
                                child: ListView.builder(shrinkWrap: true,
                                    itemCount: global.yapilmayanBaslik.length,
                                    itemBuilder: (context,index){
                                      return Text(global.yapilmayanBaslik[index]);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                ),

                Expanded(flex: 3,
                  child: Column(
                    children: [
                      Text(
                        'Tamamlanan Görevler: ${global.checkNotCount}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      SizedBox(height: 5),
                      Text(
                        'Tamamlanmayan Görevler: ${global.checkNotFalseCount}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      }
    );
  }


}