import 'dart:collection';

import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/KayitSayfalar/HizmetVerRegisterPage1.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HizmetAlRegisterPage.dart';




class RegisterPage1 extends StatefulWidget {




  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}



class _RegisterPage1State extends State<RegisterPage1> {

  String _hizmetSecim = "empty";

  void _hizmetVermek() {
    setState(() {
      _hizmetSecim = "hizmetVer";
    });
  }

  void _hizmetAlmak() {
    setState(() {
      _hizmetSecim = "hizmetAl";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: eGen/40,),
                Text("Hoşgeldiniz!",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green

                ),),
                Container(width: eGen/12,),
                Container(width: eYuk/6,height: eYuk/6,
                  child: Image.asset("resimler/tkom.png"),),

              ],
            ),
            Container(height: eYuk/33,),
            Row(
              children: [
                Container(width: eGen/30,),
                Text("Sizleri aramızda görmekten çok \nmemnun olacağız!",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black

                ),),
              ],
            ),
            Container(height: eYuk/10,),
            Row(
              children: [
                Container(width: eGen/30,),
                Text("Lütfen kayıt işleminizi\ntamamlamak için adımları takip\nediniz.",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),),
              ],
            ),
          SizedBox(height: eYuk/13,),
          Row(
            children: [
              Container(width: eGen/30,),
              Text("Hizmet  ",style: GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/16,
                fontWeight: FontWeight.bold,
                color: Colors.black,),),
              Container(width: eGen/3.6,height: eGen/10.5,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        _hizmetSecim == "hizmetVer" ? Colors.green : Colors.white
                    ),
                    foregroundColor: MaterialStateProperty.all(
                        _hizmetSecim == "hizmetVer" ? Colors.white : Colors.black
                    ),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        )
                    ),
                  ),
                  onPressed: _hizmetVermek,
                  child: Text("Vermek",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/18,
                    fontWeight: FontWeight.bold,
                    ),),
                  ),
                  ),
              Text(" / ",style: GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/13,
                fontWeight: FontWeight.bold,
                color: Colors.black,),),
            Container(width: eGen/3.6,height: eGen/10.5,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      _hizmetSecim == "hizmetAl" ? Colors.green : Colors.white
                  ),
                  foregroundColor: MaterialStateProperty.all(
                      _hizmetSecim == "hizmetAl" ? Colors.white : Colors.black
                  ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
                ),
                onPressed: _hizmetAlmak,
                child: Text("Almak",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/18,
                  fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ),
            ],
          ),
            Row(
              children: [
                Container(width: eGen/30,),
                Text("istiyorum.",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,),),
              ],
            ),
            SizedBox(height: eYuk/9,),
            SizedBox(height: eYuk/12, width: eGen/1.2,
              child: ElevatedButton(
                onPressed: () {

                  if(_hizmetSecim=="hizmetAl"){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HizmetAlRegisterPage() ));
                  }
                  if(_hizmetSecim=="hizmetVer"){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage1() ));
                  }
                  if(_hizmetSecim=="empty"){
                    FancySnackbar.showSnackbar(
                      context,
                      snackBarType: FancySnackBarType.error,
                      title: "Lütfen bir seçim yapınız.",
                      message: "",
                      duration: 3,
                      onCloseEvent: () {},
                    );



                  }
                  else{
                    print("Uygulama hatası");
                  }
                  // Butona basıldığında gerçekleşecek işlemler



                },
                child: Text("Devam Et",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/12,
                  fontWeight: FontWeight.bold,
                ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Butonun rengi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Kenarların oval yapısı
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


          ],
        ),
      ),
    );
  }
}