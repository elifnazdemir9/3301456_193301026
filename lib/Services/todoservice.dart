import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authservice.dart';
import '../Variables/global.dart' as global;

class TodoService{
  final FirebaseAuth auth=FirebaseAuth.instance;
  AuthService authService=AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int todoCount=0;
  int checkNotCount=0;
  int checkNotFalseCount=0;
 List<String> yapilanlar=[];
 List<String> yapilmayanlar=[];
  TodoEkle(String baslik,List<String> not,List<bool> checkNot,
      String durum)
  async{
    CollectionReference collectionReference1=
    FirebaseFirestore.instance.collection('Yapılacaklar');
    var documentRef=await collectionReference1.add(
        {'Baslik': '$baslik','Not': not,
          'CheckNot': checkNot,
          'Durum':'$durum'
        });
  }
  TodoGuncelle(dynamic docid,bool check,int i)async{
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('Yapılacaklar').doc(docid);
    docRef.get().then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> currentData = snapshot.data() as Map<String, dynamic>;
        List<dynamic> checkNotArray = currentData['CheckNot'];
        checkNotArray[i] = check;
        docRef.update({
          'CheckNot': checkNotArray,
        }).then((value) {
          print("Dizi indeksi başarıyla güncellendi!");
        }).catchError((error) {
          print("Hata oluştu: $error");
        });
      } else {
        print("Belge bulunamadı!");
      }
    }).catchError((error) {
      print("Hata oluştu: $error");
    });
  }
  TodoNotEkle(dynamic docid,bool check,String not){
    // Firestore referansını alın
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Belirli bir belgeye başvurun
    DocumentReference docRef = firestore.collection('Yapılacaklar').doc(docid);

    // Belgeyi alın
    docRef.get().then((snapshot) {
      if (snapshot.exists) {
        // Mevcut verileri alın
        Map<String, dynamic> currentData = snapshot.data() as Map<String, dynamic>;

        List<dynamic> checkNotArray = currentData['CheckNot'];
        List<dynamic> NotArray = currentData['Not'];

        // Yeni indeksi diziye ekleyin
        checkNotArray.add(check);
        NotArray.add(not);

        docRef.update({
          'CheckNot': checkNotArray,
          'Not': NotArray
          // Diğer alanları da ekleyebilirsiniz
        }).then((value) {
          print("Yeni indeks başarıyla eklendi!");
        }).catchError((error) {
          print("Hata oluştu: $error");
        });
      } else {
        print("Belge bulunamadı!");
      }
    }).catchError((error) {
      print("Hata oluştu: $error");
    });
  }

  TodoDurumGuncelle(dynamic docid,String state)async{
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('Yapılacaklar').doc(docid);
    docRef.get().then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> currentData = snapshot.data() as Map<String, dynamic>;
        String DurumArray = currentData['Durum'];
        DurumArray = state;
        docRef.update({
          'Durum': DurumArray,
        }).then((value) {
          print("Dizi indeksi başarıyla güncellendi!");
        }).catchError((error) {
          print("Hata oluştu: $error");
        });
      } else {
        print("Belge bulunamadı!");
      }
    }).catchError((error) {
      print("Hata oluştu: $error");
    });
  }

  TodoSil(dynamic docid){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = firestore.collection('Yapılacaklar').doc(docid);
    docRef.get().then((snapshot) {
      if (snapshot.exists) {
        docRef.delete().then((value) {
          print("Silindi!");
        }).catchError((error) {
          print("Hata oluştu: $error");
        });
      } else {
        print("Belge bulunamadı!");
      }
    }).catchError((error) {
      print("Hata oluştu: $error");
    });
  }

  Future todoSay() async{
    var todoRef=await _firestore.collection('Yapılacaklar').get();
    todoCount=todoRef.size;

    var querySnapshot =await _firestore.collection('Yapılacaklar').get();
    for(var docSnap in querySnapshot.docs){
      if(docSnap.exists){
        // global.checkNotCount=0;
        // global.checkNotFalseCount=0;
        final data = docSnap.data();
        final checknotList = data['CheckNot'] as List<dynamic>;
        for (var value in checknotList) {
          if (value == true) {
            checkNotCount++;
            print('yapılarnlar '+data['Baslik'].toString());
            // yapilanlar.add(data['Baslik'].toString());
            String baslik = data['Baslik'].toString();
            if (!yapilanlar.contains(baslik)) {
              yapilanlar.add(baslik);
            }
            // global.yapilanBaslik=data['Baslik'];
            // global.checkNotCount++;
          }
          else{
            checkNotFalseCount++;
            String baslik = data['Baslik'].toString();
            if (!yapilmayanlar.contains(baslik)) {
              yapilmayanlar.add(baslik);
            }
            // global.checkNotFalseCount++;
          }
        }
        global.checkNotCount=checkNotCount;
        global.checkNotFalseCount=checkNotFalseCount;

        global.yapilanBaslik=yapilanlar;
        global.yapilmayanBaslik=yapilmayanlar;

      }
    }
      print(todoCount.toString()+" "+checkNotCount.toString()+" "+checkNotFalseCount.toString());
  }

  LinkEkle(String baslik,String link)
  async{
    CollectionReference collectionReference1=
    FirebaseFirestore.instance.collection('Links');
    var documentRef=await collectionReference1.add(
        {'baslik': '$baslik','link': link
        });
  }
}