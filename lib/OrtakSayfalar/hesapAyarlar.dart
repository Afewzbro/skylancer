import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetAlan/HA_HomePage.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:skylancer/main.dart';



class hesapAyarlarPage extends StatefulWidget {




  @override
  State<hesapAyarlarPage> createState() => _hesapAyarlarPageState();
}

class _hesapAyarlarPageState extends State<hesapAyarlarPage> {





  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double eYuk = ekranBilgisi.size.height;
    final double eGen = ekranBilgisi.size.width;










    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(eYuk/10),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                '\n  Hesap Ayarlarım    ',
                style:  GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Column(
                children: [
                  Icon(
                    Icons.add, // Invisible Icon
                    color: Colors.green,
                    size: eGen/15,
                  ),
                  Icon(
                    Icons.settings, // Eklemek istediğimiz ikon
                    color: Colors.white,
                    size: eGen/9,
                  ),
                ],
              ),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.green,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 0.1),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: eYuk/30,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Telefon Numaranı Değiştir',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Yeni Telefon Numaranızı Girin:',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/16,),
                  SizedBox(
                    width: eGen/1.5, height: 20,
                    child: TextFormField(
                      maxLength: 10,

                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {

                        });
                      },


                      decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("+90"),
                        ),
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

                        errorStyle: TextStyle(
                          fontSize: 0.001,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red,
                            )
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/40,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Şifrenizi Girin:',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/16,),
                  SizedBox(
                    width: eGen/1.5, height: 20,
                    child: TextFormField(
                      obscureText: true,



                      onChanged: (value) {
                        setState(() {

                        });
                      },


                      decoration: InputDecoration(
                        counterText: "",

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

                        errorStyle: TextStyle(
                          fontSize: 0.001,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red,
                            )
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/40,),
              Row(
                children: [
                  SizedBox(width: eGen/1.5,),
                  ElevatedButton(
                    onPressed: () {



                    },
                    child: Text("Güncelle",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Kenarların oval yapısı
                      ),


                    ),
                  ),
                ],
              ),




              SizedBox(height: eYuk/30,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Şifreni Değiştir',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Mevcut Şifrenizi Girin:',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/16,),
                  SizedBox(
                    width: eGen/1.5, height: 20,
                    child: TextFormField(
                      obscureText: true,
                      maxLength: 10,


                      onChanged: (value) {
                        setState(() {

                        });
                      },


                      decoration: InputDecoration(
                        counterText: "",

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

                        errorStyle: TextStyle(
                          fontSize: 0.001,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red,
                            )
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/40,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Yeni Şifrenizi Girin:',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/16,),
                  SizedBox(
                    width: eGen/1.5, height: 20,
                    child: TextFormField(
                      obscureText: true,



                      onChanged: (value) {
                        setState(() {

                        });
                      },


                      decoration: InputDecoration(
                        counterText: "",

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

                        errorStyle: TextStyle(
                          fontSize: 0.001,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red,
                            )
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/40,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text(
                    'Yeni Şifrenizi Onaylayın:',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: eYuk/60,),
              Row(
                children: [
                  SizedBox(width: eGen/16,),
                  SizedBox(
                    width: eGen/1.5, height: 20,
                    child: TextFormField(
                      obscureText: true,



                      onChanged: (value) {
                        setState(() {

                        });
                      },


                      decoration: InputDecoration(
                        counterText: "",

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

                        errorStyle: TextStyle(
                          fontSize: 0.001,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red,
                            )
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/40,),
              Row(
                children: [
                  SizedBox(width: eGen/1.5,),
                  ElevatedButton(
                    onPressed: () {



                    },
                    child: Text("Güncelle",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Kenarların oval yapısı
                      ),


                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}