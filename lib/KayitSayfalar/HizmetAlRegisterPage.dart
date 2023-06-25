import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:skylancer/main.dart';





class HizmetAlRegisterPage extends StatefulWidget {




  @override
  State<HizmetAlRegisterPage> createState() => _HizmetAlRegisterPage();
}



class _HizmetAlRegisterPage extends State<HizmetAlRegisterPage> {


  final _formKey = GlobalKey<FormState>();
  bool ButonKontrol = true;

  String? ad;
  String? soyad;
  String? telNo;
  String? mail;
  String? sifre;
  String? sifreOnay;
  bool SMSizni = false;
  bool Telefonizni = false;
  bool Mailizni = false;

  void kontrol() async{

    if (ad == null || soyad == null || telNo == null || mail == null || sifre == null || sifreOnay == null ||
      ad!.isEmpty || soyad!.isEmpty || telNo!.isEmpty || mail!.isEmpty || sifre!.isEmpty || sifreOnay!.isEmpty) {
      // boş girdi alındı hata mesajı gönder.
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Bazı bilgilerinizi girmeyi unuttunuz gibi görünüyor.",
        message: "İşlem yapabilmem için bilgilerinizi belirtir misiniz?",
        duration: 5,
        onCloseEvent: () {},
      );
      }else{
      //girdiler tamam kontrol edelim.
        if(ad!.length<3 || soyad!.length<3){
          FancySnackbar.showSnackbar(
            context,
            snackBarType: FancySnackBarType.error,
            title: "Adın ve soyadın havada kaybolacak kadar kısa!",
            message: "Lütfen adını ve soyadını 3 karakterden daha uzun şekilde gir.",
            duration: 5,
            onCloseEvent: () {},
          );
        }else{
          if(telNo!.length!=10 || !telNo!.startsWith("5")){
            FancySnackbar.showSnackbar(
              context,
              snackBarType: FancySnackBarType.error,
              title: "İletişim kurabilmek için doğru bir numara girmelisin!",
              message: "Numara 10 haneli olmalı ve 5 ile başlamalı.",
              duration: 5,
              onCloseEvent: () {},
            );

          }else{
            if(!mail!.contains('@')){
              FancySnackbar.showSnackbar(
                context,
                snackBarType: FancySnackBarType.error,
                title: "Geçerli bir e-posta adresi girmeniz gerekiyor.",
                message: "Lütfen doğru bir e-posta adresi girin.",
                duration: 5,
                onCloseEvent: () {},
              );
            }else{
              if(sifre!.length<6){
                FancySnackbar.showSnackbar(
                  context,
                  snackBarType: FancySnackBarType.error,
                  title: "Şifre güvenliği önemli!",
                  message: "Lütfen en az 6 karakterden oluşan bir şifre seçin.",
                  duration: 5,
                  onCloseEvent: () {},
                );
              }else{
                if(sifre!=sifreOnay){
                  FancySnackbar.showSnackbar(
                      context,
                      snackBarType: FancySnackBarType.error,
                      title: "Şifreler uyumsuz!",
                      message: "Girilen şifrelerin aynı olduğundan emin olun.",
                      duration: 5,
                      onCloseEvent: () {},
                  );
                }else {
                  if(SMSizni==false || Telefonizni==false || Mailizni==false){
                    FancySnackbar.showSnackbar(
                      context,
                      snackBarType: FancySnackBarType.error,
                      title: "İletişim izinlerini kabul etmelisiniz.",
                      message: "Kaydınızı tamamlamak için iletişim izinlerini işaretleyin.",
                      duration: 5,
                      onCloseEvent: () {},
                    );
                  }else{
                    addUser();
                  }

                }// 6. else Kullanıcıyı ekle
              }// 5. else sifre onay kontrolü
            }//4. else şifre kontrolü
          }// 3. else mail kontrolü
        }// 2. else tel no kontrolü
    } // 1. else ad soyad kontrolü




  }

  void addUser() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection("users").doc("$mail").set({
      "ad": "$ad",
      "soyad": "$soyad",
      "telNo": "$telNo",
      "mail": "$mail",
      "sifre": "$sifre",
      "rol": 1,
      "tip": "sahis"

    }).then((_) {
      print("sayac");
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.waiting,
        title: "Lütfen bekleyin...",
        message: "Kayıt olma işleminiz tamamlanıyor.",
        duration: 3,
        onCloseEvent: () {
          FancySnackbar.showSnackbar(
            context,
            snackBarType: FancySnackBarType.success,
            title: "Kayıt olma işlemi başarılı.",
            message: "Giriş sayfasına yönlendiriliyorsunuz.",
            duration: 3,
            onCloseEvent: () {
               Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage(title: "")),);
            },
          );
          },
      );
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

      body: Form(
        key: _formKey,
        child: Center(


          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(height: eYuk/14,),


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
              // Ad Texformfield
              Container(height: eYuk/100,),
              Row(
                children: [
                  Container(width: eGen/9,),
                  Container(




                    width: eGen/1.3, height: eYuk/30,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          ad = value;
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

              // Soyad Texformfield
              Row(
                children: [
                  Container(width: eGen/9),
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
                      validator: (value) {

                        if (value!.isEmpty) {


                          return "Hata";
                        }else if(value!.length < 3){
                          return "karakter hatası";
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
                  Text("Telefon Numaranız",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                ],
              ),
              // Telefon Texformfield
              Container(height: eYuk/100,),
              Row(
                children: [
                  Container(width: eGen/9,),
                  SizedBox(
                    width: eGen/1.3, height: 20,
                    child: TextFormField(
                      maxLength: 10,

                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          telNo = value;
                        });
                      },validator: (value) {

                      if (value!.isEmpty) {


                        return "Hata";
                      }else if (value.length != 10) {
                        return 'Telefon numarası 10 haneli olmalıdır';
                      } else if (!value.startsWith("5")) {
                        return 'Telefon numarası 5 ile başlamalıdır';
                      }
                      return null;
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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          mail = value;
                        });
                      },

                      validator: (value) {

                        if (value!.isEmpty) {


                          return "Hata";
                        }else if (!value.contains('@')) {
                          return 'Geçerli bir e-posta adresi girin';
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

              // Sifre TextFormField
              Row(
                children: [
                  Container(width: eGen/9,),
                  SizedBox(
                    width: eGen/1.3, height: 20,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          sifre = value;
                        });
                      },

                      validator: (value) {

                        if (value!.isEmpty) {


                          return "Hata";
                        }else if(value!.length<6){
                          return "Hata";
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
                  Text("Şifrenizi Onaylayın",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                ],
              ),
              Container(height: eYuk/100,),

              // Sifreyi Onayla TextFormField
              Row(
                children: [
                  Container(width: eGen/9,),
                  SizedBox(
                    width: eGen/1.3, height: 20,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          sifreOnay = value;
                        });
                      },



                      validator: (value) {

                        if (value!.isEmpty) {


                          return "Hata";
                        }else if(sifre!=sifreOnay){
                          return "Sifreler eslesmedi";
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

              SizedBox(height: eYuk/12, width: eGen/1.2,
                child: ElevatedButton(
                  onPressed: () {
                      kontrol();

                      if (_formKey.currentState!.validate()) {
                        // Form doğrulandığında addUser() metodu çağrılır
                        // addUser();
                        print("AddUser calisti");
                      }








                  },
                  child: Text("Tamamla",style: GoogleFonts.getFont('Balsamiq Sans',
                    fontSize: eGen/12,
                    fontWeight: FontWeight.bold,
                  ),),
                  style: ElevatedButton.styleFrom(
                    primary: ButonKontrol ? Colors.green : Colors.grey, // Butonun rengi
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
      ),
    );
  }
}