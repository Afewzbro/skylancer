import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants/routes.dart';
import '../services/auth/auth_service.dart';
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgi = MediaQuery.of(context);
    final double eYuk = ekranBilgi.size.height;
    final double eGen = ekranBilgi.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(height: eYuk/30,),
            Container(width: eYuk/3.7,height: eYuk/3.7,
            child: Image.asset("resimler/tkom.png"),),
            Container(height: eYuk/35,),
            Text("size bir doğrulama e-postası gönderdik. Hesabınızı doğrulamak için lütfen açın",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.green,),),
            Text("Henüz bir doğrulama e-postası almadıysanız, yeniden göndermek için düğmeye basın",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.green,),),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: Text('E-posta doğrulaması gönder',),
              ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerPage1Route,
                  (route) => false,);
              },
              child:  Text('Kaydol',style: GoogleFonts.getFont('Balsamiq Sans',
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
            ),
            Container(height: eYuk/50,),
            // Google İle Giriş Yap Butonu
            SizedBox(height: eYuk/12, width: eGen/1.1,),],)
      ),
    );
  }
}

