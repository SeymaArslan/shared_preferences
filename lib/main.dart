import 'package:flutter/material.dart';
import 'package:shared_preferences_kullanimi/SayfaA.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  * Shared Preferences key-value ilişkisi ile basit verileri kalıcı olarak depolayabiliriz
  * kullanılan veri türleri : String,int,double,bool,List<String>
  * Uygulama silindiğinde kayıt edilen veriler de silinir
  * Veritabanı üzerindeki gibi detaylı verileri kayıt etmeyeceksek hızlı bir çözüm olarak kullanılabilir
  *
  * kullanabilmek için pubspeck dosyası dev_dependencies: altına flutter hizsında shared_preferences: ^2.0.11 kütüphanesini ekliyoruz
  */
  // gerek veritabanı gerek hafıza kaydı işlemleri olsun performanslı çalışmamız önemli, bu yüzden future yapısı kullancağız

  Future<void> veriKaydi() async{
    // kayıt işlemini burada yapacağız, önce shared preferences tan yetki almamız lazım
    var sp = await SharedPreferences.getInstance();  // await sayesinde buradaki tanımlamanın çalışması bittikten sonra sp çalışc
    // cak anlamında kullanılıyor, await ten sonraki kodlama ise diyorki sharedpreferene ı oluştururken işi bitene kadar bekle ondan sonra devam et
    //eğer demezsek sp oluşmadan belki kayıt yapmaya çalışır ve hata alırıız, sp nesnesi ile kayıt işlemi yaptık await ile shared bittikten sonra sp yi kullanacağız
    // veri kaydında problem yaşamamak için

    sp.setString("ad", "sema");
    sp.setInt("yas", 18);
    sp.setDouble("boy", 1.7);
    sp.setBool("bekarMi", true);

    //  bu yapıda string türünde br liste kaydedip tutabiliyoruz, önce liste tanımlaması yapmamız gerek
    var arkadasListe = <String>[];
    arkadasListe.add("Ece");
    arkadasListe.add("Ali");

    sp.setStringList("arkadasListe", arkadasListe);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: (){
                  veriKaydi();
                  // veri kaydı metodunu butona bastığım an önce veri kaydo sonra sayfa geçişi gelecek, sayfaA da veri kaydını okumaya çalışacağız
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SayfaA()));
                },
                child: Text("Geçiş Yap"),
            ),
          ],
        ),
      ),

    );
  }
}
