import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SayfaA extends StatefulWidget {
  @override
  State<SayfaA> createState() => _SayfaAState();
}

class _SayfaAState extends State<SayfaA> {


  Future<void> veriOku() async{
    var sp = await SharedPreferences.getInstance();
    // get metodlarıyla okuyacağuz

    String adOku = sp.getString("ad") ?? "isim yok"; // buradaki soru işareti: burada keyde ki veriyi okumaya çalışırken, bir hata olursa soru işaretinden sonra yazmış olduğumuz veri adOku değişkenine atanacak
    int yasOku = sp.getInt("yas") ?? 99;
    double boyOku = sp.getDouble("boy") ?? 0.1;
    bool bekarOku = sp.getBool("bekarMi") ?? false;

    var arkadasListeOku = sp.getStringList("arkadasListe") ?? null;

    print("Ad: $adOku");
    print("Yas: $yasOku");
    print("Boyu: $boyOku");
    print("Bekar Mı?: $bekarOku");

    // listeyi döngüyle alacağız
    for(var a in arkadasListeOku!){
      print("Arkadaş: $a");
    }
  }

  Future<void> veriSil() async{
    var sp = await SharedPreferences.getInstance();
    // remove metodu ile sileceğiz
    sp.remove("ad");  // key siliyoruz
  }

  Future<void> veriGuncelle() async{
    var sp = await SharedPreferences.getInstance();
    // set metodu ile sileceğiz
    sp.setInt("yas", 100);  // key güncelleme
  }


  @override
  void initState() {
    // sayfa açıldığında çalışan metoddu
    super.initState();
    //veriSil();
    veriGuncelle();
    veriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sayfa A"),
      ),
      body: Center(),
    );
  }
}
