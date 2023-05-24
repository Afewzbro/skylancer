import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skylancerafew/pages/RegisterPage1.dart';

import '../constants/routes.dart';
import '../services/auth/auth_excepitions.dart';
import '../services/auth/auth_service.dart';
import '../utilities/dialogs/error_dialog.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //testi
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  //testi
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                Text(
                  "Email",
                  style: GoogleFonts.getFont('Balsamiq Sans',
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
                    //testi
                    controller: _email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    //testi
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
                    controller: _password,
                    autocorrect: false,
                    obscureText: true,
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
              onPressed: () async {
                // Butona basıldığında gerçekleşecek işlemler
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage() ));
                final email = _email.text;
                final password = _password.text;
                try{
                  await AuthService.firebase().logIn(
                    email:email,
                    password : password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if(user?.isEmailVerified ?? false){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false);
                    print('Giriş Yap butonuna basıldı');
                  }else{
                    Navigator.of(context).pushNamedAndRemoveUntil(
                            verifyEmailRoute,
                            (route) => false);
                  }
                }on UserNotFoundAuthException {
                          await showErrorDialog(
                            context,
                            'Kullanıcı bulunamadı',);
                        } on WrongPasswordAuthException {
                          await showErrorDialog(
                              context, 
                              'Yanlış kimlik bilgileri',
                              );
                        } on GenericAuthException {
                          await showErrorDialog(
                            context, 
                            'Doğrulama hatası',); 
                        }},
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage1() ));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerPage1Route, 
                    (route) => false,
                    );
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