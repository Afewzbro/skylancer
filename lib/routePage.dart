import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetAlan/HA_HomePage.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:skylancer/main.dart';



class routePage extends StatefulWidget {




  @override
  State<routePage> createState() => _routePageState();
}

class _routePageState extends State<routePage> {

  String? rolID = "";
  void keepUser() async {
    var sp = await SharedPreferences.getInstance();

    String userID = sp.getString("mail") ?? "";
    String sifreID = sp.getString("sifre") ?? "";
    String rolID = await sp.getString("rol") ?? "";
    print("$userID , SIFREM : $sifreID BENIM ROLUM $rolID ************");
  }

  void yonlendir() async{
    // int sayac = 2;
    var sp = await SharedPreferences.getInstance();
    String rolID = await sp.getString("rol") ?? "";
    print("ROLID: $rolID");
    if(rolID=="1"){
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => HA_HomePage()),);
    }else if(rolID=="2"){
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => HV_HomePage()),);
    }else{
      print("****YONLENDIRME HATASI****");
      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage(title: "")),);
    }

  }



  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYukseklik = ekranBilgisi.size.height;
    final double ekranGenislik = ekranBilgisi.size.width;
    int sayac = 1;
    keepUser();
    if(sayac<2){
    yonlendir();
    }









    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
        ),
      ),
    );
  }
}