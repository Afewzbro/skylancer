import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SifreUnuttum extends StatefulWidget {
  const SifreUnuttum({Key? key}) : super(key: key);


  @override
  State<SifreUnuttum> createState() => _SifreUnuttumState();
}

class _SifreUnuttumState extends State<SifreUnuttum> {
  String? aMail;
  final _mailcontroller = TextEditingController();
  @override
  void dispose(){
    _mailcontroller.dispose();
    super.dispose();
  }

  Future sifreYenile(String mail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email : mail);
    } catch (e) {
      FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Kullanıcı bilgileri hatalı.",
          message: e.toString(),
          duration: 4,
          onCloseEvent: () {

          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgi = MediaQuery.of(context);
    final double eYuk = ekranBilgi.size.height;
    final double eGen = ekranBilgi.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget>[
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
                  ),
                ),
              ],
            ),
            Container(height: eYuk/20,),
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
            Container(height: eYuk/20,),
            // Giriş Yap Butonu
            SizedBox(height: eYuk/12, width: eGen/1.1,
            child: ElevatedButton(
              onPressed: (){
                aMail = _mailcontroller.text;
                sifreYenile("$aMail");
              },
                child: Text("Şifreyi yenile",style: GoogleFonts.getFont('Balsamiq Sans',
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
          ]
        ),
      )
    );
  }
}