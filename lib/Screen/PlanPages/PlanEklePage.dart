import 'package:mobil/Services/todoservice.dart';

import '/Model/todolist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Variables/global.dart' as global;

class PlanEkle extends StatefulWidget {
  const PlanEkle({Key? key}) : super(key: key);

  @override
  State<PlanEkle> createState() => _PlanEkleState();
}

class _PlanEkleState extends State<PlanEkle> {

  TextEditingController planbaslikctr=TextEditingController();
 TextEditingController notctr=TextEditingController();
  TodoService service=TodoService();


  List<TextEditingController> _controllers = []; // controller listesi
  int _count = 0;

  void _addTextField() {
    setState(() {
      _count++;
      _controllers.add(TextEditingController()); // yeni bir controller eklendi
    });
  }
  void _deleteTextField() {
    setState(() {
      _count--;
      _controllers.removeLast();
    });
  }

  String dropdownvalue = 'Çok Acil';
  int dropdownvaluetemp = 3;
  var items = [
    'Çok Acil',
    'Acil',
    'Acil Değil'
  ];

  List<String> notuTextAl(List<TextEditingController> controllers) {
    List<String> notes=[];
    for(TextEditingController note in controllers){

      notes.add(note.text);
    }
    return notes;
    }
  List<bool> notuCheckAl(List<TextEditingController> controllers) {
    List<bool> checkNotes=[];
    for(TextEditingController note in controllers){

      checkNotes.add(false);
    }
    return checkNotes;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> textFields = []; // text field listesi
    for (int i = 0; i < _count; i++) {
      textFields.add(
        TextFormField(
          controller: _controllers[i], // her bir text field için ayrı controller kullanıldı
          decoration: InputDecoration(
            hintText: 'Not',
          ),
        ),
      );
    }
    return Scaffold(

      appBar: AppBar(centerTitle: true,leading: Text(''),title: Text('Plan Ekle'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                margin: EdgeInsets.only(left:5, right:5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purple.shade100,
                      border: Border.all(color: Colors.white,width: 1.5)
                  ),
                  child: TextField(
                    controller: planbaslikctr,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Plan Başlığı",
                      labelStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),

                  )
          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left:5, right:5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.purple.shade100,
                              border: Border.all(color: Colors.white,width: 1.5)
                          ),
                          child: Column(
                            children: [
                              // TextFormField(
                              //   controller: notctr, // her bir text field için ayrı controller kullan
                              //   decoration: InputDecoration(
                              //     hintText: 'Not',
                              //   ),
                              // ),
                              Text('Not eklemek için butona basınız.',style: TextStyle(color: Colors.black),),
                              ...textFields,
                            ],
                          )
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(onTap: _addTextField,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.note_add),
                            )
                        ),
                        SizedBox(height: 4,),
                        Visibility(visible: _count>0?true:false,
                            child: GestureDetector(onTap: _deleteTextField,
                                child: CircleAvatar(backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  child: Icon(Icons.delete_forever_sharp),
                                )
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 13),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purple.shade100,
                      border: Border.all(color: Colors.white,width: 1.5)
                  ),
                  child: Row(
                    children: [
                      Text('Aciliyeti: ',style: TextStyle(color: Colors.black),),
                      SizedBox(width: 150,),
                      DropdownButton(
                          style: TextStyle(color: Colors.black),
                          dropdownColor: Colors.white,
                          value: dropdownvalue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                                value: items, child: Text(items));
                          }).toList(),
                        onChanged: (String? newValue) {  setState(() {
                          dropdownvalue = newValue!;
                        }); },

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 15,top: 5),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple.shade800,
                  hoverColor: Colors.white,
                  elevation: 10,
                  onPressed: () async{

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.greenAccent,content: Text('Eklendi')));


                  var fToast=FToast();
                  fToast.init(context);
                  if(planbaslikctr.text.isNotEmpty){
                    await service.TodoEkle(planbaslikctr.text, notuTextAl(_controllers), notuCheckAl(_controllers),dropdownvalue.toString());;

                    PlanItem yeniPlan = PlanItem(
                      baslik: planbaslikctr.text,
                      not: [notctr.text],
                      checkNot: [false],
                      durum: dropdownvalue,
                    );
                    setState(() async{
                      if(_count>0){
                        for (int i = 0; i < _count; i++) {
                          // await service.TodoEkle(planbaslikctr.text,notctr.text,false,dropdownvalue.toString());

                          if(_controllers[i].text.isNotEmpty){
                            yeniPlan.not.add(_controllers[i].text);
                            yeniPlan.checkNot.add(false);
                          }
                          // await service.TodoEkle(planbaslikctr.text,yeniPlan.not,yeniPlan.checkNot,dropdownvalue.toString());

                        }
                      }
                      allPlan.planlar.add(yeniPlan);
                      fToast.showToast(
                          toastDuration: Duration(milliseconds: 1000),
                          gravity: ToastGravity.BOTTOM_RIGHT,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24,
                                vertical: 12),
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check),
                                SizedBox(width: 15,),
                                Text('Başarıyla Eklendi')
                              ],
                            ),
                          ));
                      for(int i=0;i<_count;i++){
                        _controllers.clear();
                      }
                      _count=0;
                    });
                    planbaslikctr.clear();
                    notctr.clear();

                  }
                  else{
                    fToast.showToast(
                        toastDuration: Duration(milliseconds: 1000),gravity: ToastGravity.BOTTOM_RIGHT,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24,
                              vertical: 12),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning),
                              SizedBox(width: 15,),
                              Text('Alanları Doldurunuz...')
                            ],
                          ),
                        ));
                  }

                },child: Icon(Icons.add),),
              )
            ],
          ),
        )
      ),
    );
  }
}


