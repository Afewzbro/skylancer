import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetAlan/HA_HomePage.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:skylancer/main.dart';



class hizmetOdemelerimPage extends StatefulWidget {




  @override
  State<hizmetOdemelerimPage > createState() => _hizmetOdemelerimPageState();
}

class _hizmetOdemelerimPageState extends State<hizmetOdemelerimPage > {





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
                '\n  Hizmet Ödemelerim  ',
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
                    Icons.credit_card, // Eklemek istediğimiz ikon
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
              SizedBox(height: eYuk/15,),

            ],
          ),
        ),
      ),
    );
  }
}