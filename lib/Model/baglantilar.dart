

class BaglantiItem {
  final String baslik;
  final String link;

  BaglantiItem({
    required this.baslik,
    required this.link,
  });


}
BaglantiListe allBaglanti=BaglantiListe(
    baglantilar: [
      BaglantiItem(baslik: "Yks Başvuru", link: "https://ais.osym.gov.tr"),
      BaglantiItem(baslik: "Trendyol Kargo İade",link: "https://trendyolexpress.com" ),
      BaglantiItem(baslik: "İş Yer Eğitimi Proje Teslimi",link: "https://iye.selcuk.edu.tr"),
      BaglantiItem(baslik: "Google",link: "https://www.google.com"),
    ]
);

class BaglantiListe{
  List<BaglantiItem> baglantilar;

  BaglantiListe({required this.baglantilar});
}