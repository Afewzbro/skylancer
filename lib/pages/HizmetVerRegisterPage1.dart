import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetVerRegisterPage2.dart';
import 'package:skylancer/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';




class HizmetVerRegisterPage1 extends StatefulWidget {




  @override
  State<HizmetVerRegisterPage1> createState() => _HizmetVerRegisterPage1();
}



class _HizmetVerRegisterPage1 extends State<HizmetVerRegisterPage1> {


  String _hizmetverenTipi = "";

  void hizmetVerentipiSahis() {
    setState(() {
      _hizmetverenTipi = "sahis";
    });
  }

  void hizmetVerenTipiSirket() {
    setState(() {
      _hizmetverenTipi = "sirket";
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

        SizedBox(height: eYuk/13,),
        Row(
          children: [
            Container(width: eGen/30,),
            Text("Vermek istediğim   ",style: GoogleFonts.getFont('Balsamiq Sans',
              fontSize: eGen/13,
              fontWeight: FontWeight.bold,
              color: Colors.black,),),

          ],
        ),
        Row(
          children: [
            Container(width: eGen/30,),
            Text("hizmeti ",style: GoogleFonts.getFont('Balsamiq Sans',
              fontSize: eGen/13,
              fontWeight: FontWeight.bold,
              color: Colors.black,),),


            Container(width: eGen/3.6,height: eGen/10.5,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      _hizmetverenTipi == "sahis" ? Colors.green : Colors.white
                  ),
                  foregroundColor: MaterialStateProperty.all(
                      _hizmetverenTipi == "sahis" ? Colors.white : Colors.black
                  ),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      )
                  ),
                ),
                onPressed: hizmetVerentipiSahis,
                child: Text("Şahıs",style: GoogleFonts.getFont('Balsamiq Sans',
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
                      _hizmetverenTipi == "sirket" ? Colors.green : Colors.white
                  ),
                  foregroundColor: MaterialStateProperty.all(
                      _hizmetverenTipi == "sirket" ? Colors.white : Colors.black
                  ),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      )
                  ),
                ),
                onPressed: hizmetVerenTipiSirket,
                child: Text("Şirket",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/18,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),



          ],
        ),
            Row(
              children: [
                Container(width: eGen/30,),
                Text("olarak vermek istiyorum. ",style: GoogleFonts.getFont('Balsamiq Sans',
                  fontSize: eGen/13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,),),
              ],
            ),
            Container(height: eYuk/30,),

        Column(
            children: [
              // ----------- Şirket Butonu if -----------
              if (_hizmetverenTipi == 'sirket') ...[
                Row(
                  children: [
                    Container(width: eGen/9,),
                    Text("Şirket Bilgileriniz ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,),),
                  ],
                ),
                Container(height: eYuk/30,),
                Row(
                  children: [
                    Container(width: eGen/9,),
                    Text("Şirket Adı",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    Text("Bulunduğu İl",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    Text("Hizmet Alanları",style: GoogleFonts.getFont('Balsamiq Sans',
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
                Container(height: eYuk/5,),

                SizedBox(height: eYuk/12, width: eGen/1.2,
                  child: ElevatedButton(
                    onPressed: () {
                      // sirket if blogundaki textformfieldin kontrol işlemleri
                      // basariliysa next page yönlendir
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage2() ));




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
              // -------------- Hizmet tipi Sahis if -----------
              if (_hizmetverenTipi == 'sahis') ...[
                Row(
                  children: [
                    Container(width: eGen/9,),
                    Text("Sizin Bilgileriniz ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,),),
                  ],
                ),
                Container(height: eYuk/30,),
                Row(
                  children: [
                    Container(width: eGen/9,),
                    Text("Adınız ve Soyadınız",style: GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,

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
                    Text("Bulunduğunuz İl",style: GoogleFonts.getFont('Balsamiq Sans',
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
                    Text("Hizmet Alanlarınız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                Container(height: eYuk/5,),

                SizedBox(height: eYuk/12, width: eGen/1.2,
                  child: ElevatedButton(
                    onPressed: () {
                      // sahis if blogundaki textformfieldin kontrol işlemleri
                      // basariliysa next page yönlendir
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage2() ));




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

    ]),

        ]
      ),

    ),

    );
  }
}