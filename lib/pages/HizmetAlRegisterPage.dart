import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'package:google_fonts/google_fonts.dart';





class HizmetAlRegisterPage extends StatefulWidget {




  @override
  State<HizmetAlRegisterPage> createState() => _HizmetAlRegisterPage();
}



class _HizmetAlRegisterPage extends State<HizmetAlRegisterPage> {

  String? ad;
  String? soyad;
  String? telNo;
  String? mail;
  String? sifre;
  bool SMSizni = false;
  bool Telefonizni = false;
  bool Mailizni = false;



  void addUser() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("HizmetALanKullanıcı").doc("$mail").set({
      "ad": "$ad",
      "soyad": "$soyad",
      "telNo": "$telNo",
      "mail": "$mail",
      "sifre": "$sifre",
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

            Container(height: eYuk/14,),

            // Email Texformfield
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Adınız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    onChanged: (value) {
                      setState(() {
                        ad = value;
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

            Container(height: eYuk/30,),

            // Email Texformfield
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Soyadınız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    onChanged: (value) {
                      setState(() {
                        soyad = value;
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


            Container(height: eYuk/30,),

            // Email Texformfield
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Telefon Numaranız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    onChanged: (value) {
                      setState(() {
                        telNo = value;
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

            Row(
              children: [
                Container(width: eGen/14,),
                    Checkbox(

                      value: SMSizni,
                      onChanged: (bool? value) {
                        setState(() {
                          SMSizni = value!;
                        });
                      },
                      activeColor: Colors.green,
                    ),

                Text("Gerekli SMS izinleri example",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/25,

                    color: Colors.black

                ),),

                      ],
                    ),

            Row(
              children: [
                Container(width: eGen/14,),
                Checkbox(

                  value: Telefonizni,
                  onChanged: (bool? value) {
                    setState(() {
                      Telefonizni = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),

                Text("Gerekli iletişim izinleri example",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/25,

                    color: Colors.black

                ),),


              ],
            ),

            Container(height: eYuk/30,),

            // Email Texformfield
            Row(
              children: [
                Container(width: eGen/9,),
                Text("Email Adresiniz",style: GoogleFonts.getFont('Balsamiq Sans',
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
            Row(
              children: [
                Container(width: eGen/14,),
                Checkbox(

                  value: Mailizni,
                  onChanged: (bool? value) {
                    setState(() {
                      Mailizni = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),

                Text("Gerekli mail izinleri example",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/25,

                    color: Colors.black

                ),),



              ],
            ),

            Container(height: eYuk/30,),

            Row(
              children: [
                Container(width: eGen/9,),
                Text("Şifrenizi Belirleyin",style: GoogleFonts.getFont('Balsamiq Sans',
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

            Container(height: eYuk/30,),

            Row(
              children: [
                Container(width: eGen/9,),
                Text("Şifrenizi Onaylayın",style: GoogleFonts.getFont('Balsamiq Sans',
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

            Container(height: eYuk/30,),

            SizedBox(height: eYuk/12, width: eGen/1.2,
              child: ElevatedButton(
                onPressed: () {

                  // işlemler





                },
                child: Text("Tamamla",style: GoogleFonts.getFont('Balsamiq Sans',
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