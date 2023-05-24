import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';




class HizmetVerRegisterPage2 extends StatefulWidget {




  @override
  State<HizmetVerRegisterPage2> createState() => _HizmetVerRegisterPage2();
}



class _HizmetVerRegisterPage2 extends State<HizmetVerRegisterPage2> {

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;




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

        SizedBox(height: eYuk/13,),
        Row(
            children: [
              Container(width: eGen/30,),
              Text("Sizlere ulaşabilmemiz için",style: GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/13,
                fontWeight: FontWeight.bold,
                color: Colors.green,),),
              ]
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

                    value: isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
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

                    value: isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
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

                    value: isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked3 = value!;
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

              Container(height: eYuk/10,),

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


            ]
        ),

      ),

    );
  }
}