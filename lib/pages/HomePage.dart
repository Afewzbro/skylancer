import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



class HomePage extends StatefulWidget {




  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYukseklik = ekranBilgisi.size.height;
    final double ekranGenislik = ekranBilgisi.size.width;







    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Uluslararası Tarım ve Gıda Konfederasyonu\n"),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(

            children: [
              SizedBox(
                width: 1,
                height: ekranYukseklik/22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  SizedBox(
                    width: ekranYukseklik/8,
                    height: 1,
                  ),
                  SizedBox(
                    width: ekranGenislik/2.4,


                    child: Image.asset("resimler/tkom.png"),
                  ),
                  SizedBox(
                    width: ekranYukseklik/30,
                    height: 1,
                  ),

                  Column(
                    children: [

                      SizedBox(
                        width: 1,
                        height: ekranYukseklik/12,
                      ),
                    ],
                  ),

                ],
              ),

              SizedBox(
                height: ekranYukseklik/9,
              ),

              Text("Kullanıcı ID:"),
              Text("Ad: "),
              Text("Soyad"),
              Text("Mail"),
              Text("Telefon"),
              Text("Sifre"),



              SizedBox(
                height: ekranYukseklik/9,
              ),




              SizedBox(
                width: ekranGenislik/1.4,
                height: ekranYukseklik/8,


                child: ElevatedButton(

                  child: Text("Çıkış Yap",style: TextStyle(fontSize: ekranGenislik/10),),
                  onPressed: (){






                  },

                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    onPrimary: Colors.black,


                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.5,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),


                  ),
                ),

              ),

              SizedBox(
                width: ekranGenislik/3,
                height: ekranYukseklik/25,
              ),



              SizedBox(
                width: ekranGenislik/3,
                height: ekranYukseklik/5,
              ),













            ],


          ),


        ),
      ),
    );
  }
}