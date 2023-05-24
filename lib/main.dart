import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancerafew/pages/HizmetAlRegisterPage.dart';
import 'package:skylancerafew/pages/HizmetVerRegisterPage1.dart';
import 'package:skylancerafew/pages/HizmetVerRegisterPage2.dart';
import 'package:skylancerafew/pages/loginpage.dart';
import 'constants/routes.dart';
import 'pages/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/RegisterPage1.dart';

import 'package:flutter_svg/flutter_svg.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sky Lancer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
      routes: {
        loginRoute : (context) => const LoginPage(),
        registerPage1Route : (context) => RegisterPage1(),
        hizmetAlRegisterRoute : (context) => HizmetAlRegisterPage(),
        hizmetVerRegister1Route : (context) => HizmetVerRegisterPage1(),
        hizmetVerRegister2Route : (context) => HizmetVerRegisterPage2(),
        verifyEmailRoute :(context) => const VerifyEmailPage(),
      },
      // FutureBuilder<bool>(
      //   future: keepUser(),
      //   builder: (context,snapshot){
      //     if(snapshot.hasData){
      //       bool? gecisIzni = snapshot.data;
      //       if(gecisIzni != null){
      //         return gecisIzni ? HomePage() : MyHomePage(title: "null");
      //         }
      //       return Container();
      //       }else{
      //       return Container();
      //     }
      //   }
      // ),
    ),
  );
}

// class MyApp extends StatelessWidget {

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<bool> keepUser() async{
//     var sp = await SharedPreferences.getInstance();

//     String userID = sp.getString("userID") ?? "";
//     String sifreID = sp.getString("sifreID") ?? "";

//     if(userID.isNotEmpty && sifreID.isNotEmpty){
//       return true;
//     }else{
//       return false;
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return ;// MaterialApp(
//     //   debugShowCheckedModeBanner: false,
//     //   title: 'Flutter Demo',
//     //   theme: ThemeData(

//     //     primarySwatch: Colors.blue,
//     //   ),
//     //   home: FutureBuilder<bool>(
//     //     future: keepUser(),
//     //     builder: (context,snapshot){
//     //       if(snapshot.hasData){
//     //         bool? gecisIzni = snapshot.data;
//     //         if(gecisIzni != null){
//     //           return gecisIzni ? HomePage() : MyHomePage(title: "null");
//     //           }
//     //         return Container();
//     //         }else{
//     //         return Container();
//     //       }
//     //     }
//     //   )
//     // );
//   }
// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;


//   void veritabanitest() async{
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     setState(() {

//       _counter++;
//     });
//     await firestore.collection("test").doc("$_counter").set({
//       'topla': "${_counter+_counter}"
//     });

//   }

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage() ));
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
