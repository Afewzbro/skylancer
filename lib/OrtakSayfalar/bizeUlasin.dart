import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetAlan/HA_HomePage.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:skylancer/main.dart';



class bizeUlasinPage extends StatefulWidget {




  @override
  State<bizeUlasinPage> createState() => _bizeUlasinPageState();
}

class _bizeUlasinPageState extends State<bizeUlasinPage> {



  final ScrollController _scrollController = ScrollController();

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
                '\n  Bize Ulaşın                ',
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
                    Icons.question_answer_outlined, // Eklemek istediğimiz ikon
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
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Icon(
                        Icons.people, // Invisible Icon
                        color: Colors.green,
                        size: eGen/6,
                      ),
                      Text(
                        '  SkyLancer Yazılım',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Icon(
                        Icons.phone, // Invisible Icon
                        color: Colors.green,
                        size: eGen/6,
                      ),
                      Text(
                        '  0 (850) 000 000',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Icon(
                        Icons.mail, // Invisible Icon
                        color: Colors.green,
                        size: eGen/6,
                      ),
                      Text(
                        '  info@skylancer.com',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Icon(
                        Icons.location_on, // Invisible Icon
                        color: Colors.green,
                        size: eGen/6,
                      ),
                      Text(
                        '  Dalaman/Muğla\n  Cad. Sk. 13',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Text(
                        ' Bize Mesaj Gönderin',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/13,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: eGen/15,),
                          Container(
                            width: eGen / 1.12,
                            height: eYuk / 6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight, // Container'ı sağ alt köşeye hizalama
                                  child: TextFormField(
                                    maxLines: 7,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      setState(() {
                                        // Değişiklikleri işle
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 5,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Butona tıklandığında yapılacak işlemler
                                    },
                                    child: Text(
                                      "Gönder",
                                      style: GoogleFonts.getFont(
                                        'Balsamiq Sans',
                                        fontSize: eGen / 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}