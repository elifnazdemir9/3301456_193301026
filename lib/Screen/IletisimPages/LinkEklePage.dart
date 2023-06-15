import 'package:flutter/material.dart';
import 'package:mobil/Services/todoservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LinkEklePage extends StatefulWidget {
  const LinkEklePage({Key? key}) : super(key: key);

  @override
  State<LinkEklePage> createState() => _LinkEklePageState();
}

class _LinkEklePageState extends State<LinkEklePage> {
  TextEditingController titlectr=TextEditingController();
  TextEditingController linkctr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link Ekleme'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.purple))
              ),
              child: TextField(
                // style: TextStyle(color: Colors.white),
                controller: titlectr,
                decoration: InputDecoration(
                    hintText: "Başlık",
                    // hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.purple))
              ),
              child: TextField(
                // style: TextStyle(color: Colors.white),
                controller: linkctr,
                decoration: InputDecoration(
                    hintText: "Link",
                    // hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none
                ),
              ),
            ),
            OutlinedButton(onPressed: () {
              if(titlectr.text.isNotEmpty&&linkctr.text.isNotEmpty){
                TodoService().LinkEkle(titlectr.text, linkctr.text);
                Navigator.pop(context);
              }else{
                var fToast=FToast();
                fToast.init(context);
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
                          Text('Alanları Doldurunuz..')
                        ],
                      ),
                    ));
              }

            }, child: Text('Ekle'))
          ],
        ),
      ),
    );
  }
}
