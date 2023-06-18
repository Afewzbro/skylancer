
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skylancer/KayitSayfalar/RegisterPage1.dart';
import 'package:skylancer/routePage.dart';
import 'package:skylancer/sifre_unuttum.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> keepUser() async{
    var sp = await SharedPreferences.getInstance();
    String userID = sp.getString("mail") ?? "";
    String sifreID = sp.getString("sifre") ?? "";
    String rolID = sp.getString("rol") ?? "";
    print("$userID , SIFREM : $sifreID BENIM ROLUM $rolID ************");

    if(userID.isNotEmpty && sifreID.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }






  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
          future: keepUser(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              bool? gecisIzni = snapshot.data;
              if (gecisIzni != null) {
                return gecisIzni ? routePage() : MyHomePage(title: "null");
              }
              return Container();
            }else{
              return Container();
            }
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int? rol;
  String? aMail;
  String? aSifre;
  String? deneme;
  var _mailcontroller = TextEditingController();
  var _sifrecontroller = TextEditingController();



  void login(String mail) async {
    // Firestore veritabanına bağlan
    FirebaseFirestore firestore = FirebaseFirestore.instance;


    // Kullanıcının girilen mailine göre sorgu yap
    var user = await firestore.collection("users").where("mail", isEqualTo: aMail).get();

    // Eğer sorgu sonucunda bir kullanıcı dönerse
    if (user.size == 1) {

      for (var user in user.docs) {

        // Kullanıcının TC numarası doğrulandı
        print("TC numarası doğrulandı : $aMail");
        // Kullanıcının şifresini al

        var sifre = user.data()["sifre"];
        rol = user.data()["rol"];
        // Kullanıcının girilen şifresiyle saklanan şifreyi karşılaştır
        if (sifre != null && sifre == aSifre) {
          // Şifreler eşleşirse kullanıcı giriş yaptı
          print("Giriş yaptı");
          // girisKontrol();
          girisSPkayit();
          FancySnackbar.showSnackbar(
            context,
            snackBarType: FancySnackBarType.success,
            title: "Giriş Başarılı!",
            message: "",
            duration: 3,
            onCloseEvent: () {
              Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => routePage()),);
            },
          );



          break;
        } else {
          // Şifreler eşleşmezse hata mesajı göster
          print("Hatalı şifre");
          if(aMail==null || aMail!.isEmpty){
            FancySnackbar.showSnackbar(
              context,
              snackBarType: FancySnackBarType.error,
              title: "Lütfen bir mail adresi giriniz.",
              message: " ",
              duration: 4,
              onCloseEvent: () {

              },



            );}
          else{
            FancySnackbar.showSnackbar(
              context,
              snackBarType: FancySnackBarType.error,
              title: "Kullanıcı bilgileri hatalı.",
              message: "Lütfen bilgilerinizi tekrar giriniz.",
              duration: 4,
              onCloseEvent: () {

              },
            );}
        }
      }
    } else {
      // Eğer sorgu sonucunda kullanıcı bulunamazsa hata mesajı göster
      print("mail adresi bulunamadı");
      if(mail.isEmpty){
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Lütfen bir mail adresi giriniz.",
          message: "",
          duration: 4,
          onCloseEvent: () {

          },
        );}
      else{
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Kullanıcı bilgileri hatalı.",
          message: "Lütfen bilgilerinizi tekrar giriniz.",
          duration: 4,
          onCloseEvent: () {

          },
        );
      }
    }
  }

  void girisSPkayit() async{
    // var userID = aMail;
    // var sifreID = aSifre;

    var sp = await SharedPreferences.getInstance();
    sp.setString("mail", "$aMail");
    sp.setString("sifre", "$aSifre");
    sp.setString("rol", "$rol");
    sp.setBool("giris", true);
  }



  void veritabanitest() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {

      _counter++;
    });
    await firestore.collection("test").doc("$_counter").set({
      'topla': "${_counter+_counter}"
    });

  }

  @override
  Widget build(BuildContext context) {

    var ekranBilgi = MediaQuery.of(context);
    final double eYuk = ekranBilgi.size.height;
    final double eGen = ekranBilgi.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(
       // title: Text(widget.title),),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(height: eYuk/30,),
            Container(width: eYuk/3.7,height: eYuk/3.7,
            child: Image.asset("resimler/tkom.png"),),
            Container(height: eYuk/35,),
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Giriş Yap",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green

                ),),
              ],
            ),
            Container(height: eYuk/20,),
            
            // Email Texformfield
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Email",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black

                ),),
              ],
            ),
            Container(height: eYuk/100,),
            Row(
              children: [
                Container(width: eGen/9,),
                SizedBox(
                  width: eGen/1.3, height: 20,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _mailcontroller,
                    onChanged: (alinanMail) {
                      setState(() {
                        aMail = alinanMail;
                      });
                    },

                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.black,

                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0, // İstediğiniz kalınlığı buraya girin
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0, // İstediğiniz kalınlığı buraya girin
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Şifre TextField
            Container(height: eYuk/25,),
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Şifre",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black

                ),),
              ],
            ),
            Container(height: eYuk/100,),
            Row(
              children: [
                Container(width: eGen/9,),
                SizedBox(
                  width: eGen/1.3, height: 20,
                  child: TextFormField(
                    obscureText: true,
                    controller: _sifrecontroller,
                    onChanged: (alinanSifre) {
                      setState(() {
                         aSifre = alinanSifre;
                      });
                    },

                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.black,

                          )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0, // İstediğiniz kalınlığı buraya girin
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0, // İstediğiniz kalınlığı buraya girin
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            

            // Şifremi Unuttum
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SifreUnuttum();},),);
                  print('sifre destegi');
                },
                child: Text("Şifremi Unuttum",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.green,


                ),),),

                Container(width: eGen/9,)
              ],
            ),
            // Giriş Yap Butonu
            SizedBox(height: eYuk/12, width: eGen/1.1,
            child: ElevatedButton(
              onPressed: () {
                // Butona basıldığında gerçekleşecek işlemler
                aSifre = _sifrecontroller.text;
                aMail = _mailcontroller.text;
                print("Mail : $aMail  Sifre : $aSifre");
                login("$aMail");

                print('Giriş Yap butonuna basıldı');
              },
                child: Text("Giriş Yap",style: GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/12,
                fontWeight: FontWeight.bold,
                ),),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Butonun rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Kenarların oval yapısı
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ), // Butonun etrafındaki dolgu (padding)
                textStyle: TextStyle(
                  fontSize: 18, // Font büyüklüğü
                ),
              ),
            ),),
            Container(height: eYuk/50,),
            // Google İle Giriş Yap Butonu
            SizedBox(height: eYuk/12, width: eGen/1.1,
              child: ElevatedButton(
                onPressed: () {
                  // Butona basıldığında gerçekleşecek işlemler
                  print('Google ile Giriş Yap Butonuna basıldı');


                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: eYuk/24,
                child: Image.asset("resimler/GLogo.png")),
                    SizedBox(width: eGen/40,),
                    Text("Google ile Giriş Yap",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),),
                  ],
                ),

              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Butonun rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Kenarların oval yapısı
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ), // Butonun etrafındaki dolgu (padding)
                textStyle: TextStyle(
                  fontSize: 18, // Font büyüklüğü
                ),
              ),
              ),),
            SizedBox(height: eYuk/200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Henüz bir hesabın yok mu?",style: GoogleFonts.getFont('Balsamiq Sans',
              fontSize: eGen/24,
              fontWeight: FontWeight.bold,
              color: Colors.black,


            ),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage1() ));
                },
                  child: Text("Kaydol",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.green,


                  ),),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
