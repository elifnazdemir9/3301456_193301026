

class PlanItem {
  final String baslik;
  final List<String> not;
  final List<bool> checkNot;
  final String durum;

  PlanItem({
    required this.baslik,
    required this.not,
    required this.checkNot,
    required this.durum,
  });


}
PlanListe allPlan=PlanListe(
  planlar: [
      PlanItem(baslik: "Yks Başvuru",durum: "Acil",not:["başvuru için para ayarlanacak","asfsaf"],checkNot: [false,true] ),
      PlanItem(baslik: "Akbank Staj Başvuru",durum: "Çok Acil",not:["başvuru için sağlık evrakları düzenlenecek"] ,checkNot: [false]),
      PlanItem(baslik: "Trendyol Kargo İade",durum: "Acil Değil",not:["iade kodu kontrol edilecek"],checkNot: [false] ),
      PlanItem(baslik: "İş Yer Eğitimi Proje Teslimi",durum: "Çok Acil",not:["sorumlu kişiye hemen teslim edilmesi gerekiyor"],checkNot: [false] ),
      PlanItem(baslik: "Robotik Proje Teslimi",durum: "Acil",not:["teslim zamanı 1 hafta kaldı"],checkNot: [false] ),
  ]
);

class PlanListe{
  List<PlanItem> planlar;

  PlanListe({required this.planlar});
}