import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/KayitSayfalar/HizmetVerRegisterPage2.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';




class HizmetVerRegisterPage1 extends StatefulWidget {




  @override
  State<HizmetVerRegisterPage1> createState() => _HizmetVerRegisterPage1();
}



class _HizmetVerRegisterPage1 extends State<HizmetVerRegisterPage1> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController controlleradsahis = TextEditingController();
  TextEditingController controllersoyadsahis = TextEditingController();
  TextEditingController controllerilsahis = TextEditingController();
  TextEditingController controlleradsirket = TextEditingController();
  TextEditingController controllerilsirket = TextEditingController();
  TextEditingController controllerhizmetalan = TextEditingController();




  String _hizmetverenTipi = "";
  //----------------------------//
  String? adSahis ;
  String? soyadSahis ;
  String? konumSahis ;
  String? hizmetalanlariSahis = "";
  //----------------------------//
  String? adSirket ;
  String? konumSirket ;
  String? hizmetalanlariSirket = "";


  void hizmetVerentipiSahis() {
    controllerilsahis.clear();
    controlleradsahis.clear();
    controllersoyadsahis.clear();
    controllerhizmetalan.clear();
    controlleradsirket.clear();
    controllerilsirket.clear();
    controllerhizmetalan.clear();
    adSahis = null;
    soyadSahis = null;
    konumSahis = null;
    adSirket = null;
    konumSirket = null;
    setState(() {
      _hizmetverenTipi = "sahis";
    });
  }

  void hizmetVerenTipiSirket() {
    controllerilsahis.clear();
    controlleradsahis.clear();
    controllersoyadsahis.clear();
    controllerhizmetalan.clear();
    controlleradsirket.clear();
    controllerilsirket.clear();
    controllerhizmetalan.clear();
    adSahis = null;
    soyadSahis = null;
    konumSahis = null;
    adSirket = null;
    konumSirket = null;
    setState(() {
      _hizmetverenTipi = "sirket";
    });
  }

  void kontrolSahis(){

    if( adSahis == null || konumSahis == null || konumSahis == null || soyadSahis!.isEmpty || adSahis!.isEmpty || konumSahis!.isEmpty ){
      FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Bazı bilgilerinizi girmeyi unuttunuz gibi görünüyor.",
          message: "İşlem yapabilmem için bilgilerinizi belirtir misiniz?",
          duration: 5,
          onCloseEvent: () {},
      );
    }else if(adSahis!.length<3){
      FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Adın havada kaybolacak kadar kısa!",
          message: "Lütfen adını 3 karakterden daha uzun şekilde gir.",
          duration: 5,
          onCloseEvent: () {},
      );
    }else if(soyadSahis!.length<3){
      FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Soyadın havada kaybolacak kadar kısa!",
          message: "Lütfen Soyadını 3 karakterden daha uzun şekilde gir.",
          duration: 5,
          onCloseEvent: () {},
      );
    }else if(konumSahis!.length<3){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Lütfen bulunduğunuz ili tam olarak belirtin. ",
        message: "En az 3 karakter içeren geçerli bir il giriniz.",
        duration: 5,
        onCloseEvent: () {},
      );
      }else{
      keepData();
      // Shared Prefences kayıt işlemleri
    }
  }

  void kontrolSirket(){
    if( adSirket == null || konumSirket == null || adSirket!.isEmpty || konumSirket!.isEmpty ){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Bazı bilgilerinizi girmeyi unuttunuz gibi görünüyor.",
        message: "İşlem yapabilmem için bilgilerinizi belirtir misiniz?",
        duration: 5,
        onCloseEvent: () {},
      );
    }else if(adSirket!.length<3){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Şirket adı havada kaybolacak kadar kısa!",
        message: "Lütfen şirket adını 3 karakterden daha uzun şekilde gir.",
        duration: 5,
        onCloseEvent: () {},
      );
    }else if(konumSirket!.length<3){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Lütfen bulunduğunuz ili tam olarak belirtin. ",
        message: "En az 3 karakter içeren geçerli bir il giriniz.",
        duration: 5,
        onCloseEvent: () {},
      );
    }else{
      keepData();
      // Shared Prefences kayıt işlemleri
    }

  }

  Future keepData() async{
    var sp = await SharedPreferences.getInstance();
    if(_hizmetverenTipi=="sahis"){
      sp.setString("ad", adSahis!);
      sp.setString("soyad", soyadSahis!);
      sp.setString("konum", konumSahis!);
      sp.setString("rol", _hizmetverenTipi);
      print("Sahis verileri kaydedildi : 1($adSahis) 2($soyadSahis) 3($konumSahis");
      yonlendir();
    }else if(_hizmetverenTipi=="sirket"){
      sp.setString("ad", adSirket!);
      sp.setString("soyad", "");
      sp.setString("konum", konumSirket!);
      sp.setString("rol", _hizmetverenTipi);
      print("Sirket verileri kaydedildi : 1($adSirket) 2($konumSirket) 3test($adSahis)");
      yonlendir();
    }else{
      print("Shared Prefences kaydederken hata ****");
    }


  }

  void yonlendir(){
    FancySnackbar.showSnackbar(
      context,
      snackBarType: FancySnackBarType.waiting,
      title: "Lütfen bekleyin.",
      message: "Devam sayfasına yönlendiriliyorsunuz.",
      duration: 4,
      onCloseEvent: () {
        Navigator.push( context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage2()),);
      },
    );
  }


















  @override
  Widget build(BuildContext context) {

    var ekranBilgi = MediaQuery.of(context);
    final double eYuk = ekranBilgi.size.height;
    final double eGen = ekranBilgi.size.width;







    return Scaffold(

      resizeToAvoidBottomInset: true,
      //appBar: AppBar(
      // title: Text(widget.title),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
        child: Center(

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
                  // sirket adi container
                  Row(
                    children: [
                      Container(width: eGen/9,),
                      SizedBox(
                        width: eGen/1.3, height: 20,
                        child: TextFormField(
                          controller: controlleradsirket,
                          onChanged: (value) {
                            setState(() {
                              adSirket = value;
                              print("ad: $value");
                            });
                          },
                          validator: (value) {

                            if (value!.isEmpty) {


                              return "Hata";
                            }else if(value!.length < 3){
                              return "Karakter az";
                            }
                            return null;
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
                          controller: controllerilsirket,
                          onChanged: (value) {
                            setState(() {
                              konumSirket = value;
                            });
                          },
                          validator: (value) {

                            if (value!.isEmpty) {


                              return "Hata";
                            }else if(value!.length < 3){
                              return "Karakter az";
                            }
                            return null;
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


                  Container(height: eYuk/3,),

                  SizedBox(height: eYuk/12, width: eGen/1.2,
                    child: ElevatedButton(
                      onPressed: () {
                        kontrolSirket();
                        if (_formKey.currentState!.validate()) {
                          // sirket if blogundaki textformfieldin kontrol işlemleri
                          // basariliysa next page yönlendir
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage2() ));
                          print("Sayfa yönlendirme : Sirket");
                        }



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
                      Text("Adınız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                          controller: controlleradsahis,
                          onChanged: (value) {
                          setState(() {
                            adSahis = value;
                            print("ad: $value");
                          });
                        },
                          validator: (value) {

                            if (value!.isEmpty) {


                              return "Hata";
                            }else if(value!.length < 3){
                              return "Karakter az";
                            }
                            return null;
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

                  Container(height: eYuk/30,),
                  Row(
                    children: [
                      Container(width: eGen/9,),
                      Text("Soyadınız",style: GoogleFonts.getFont('Balsamiq Sans',
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
                          controller: controllersoyadsahis,
                          onChanged: (value) {
                          setState(() {
                            soyadSahis = value;
                            print("ad: $value");
                          });
                        },
                          validator: (value) {

                            if (value!.isEmpty) {


                              return "Hata";
                            }else if(value!.length < 3){
                              return "Karakter az";
                            }
                            return null;
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
                          controller: controllerilsahis,
                          onChanged: (value) {
                          setState(() {
                            konumSahis = value;
                            print("ad: $value");
                          });
                        },
                          validator: (value) {

                            if (value!.isEmpty) {


                              return "Hata";
                            }else if(value!.length < 3){
                              return "Karakter az";
                            }
                            return null;
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

                  Container(height: eYuk/4.3,),

                  SizedBox(height: eYuk/12, width: eGen/1.2,
                    child: ElevatedButton(
                      onPressed: () {
                        kontrolSahis();
                        if (_formKey.currentState!.validate()) {
                          // sahis if blogundaki textformfieldin kontrol işlemleri
                          // basariliysa next page yönlendir
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => HizmetVerRegisterPage2() ));
                          // spkayit();
                          print("Sayfa yönlendirme : Sahis");
                        }





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

    ),
      )
    );
  }
}