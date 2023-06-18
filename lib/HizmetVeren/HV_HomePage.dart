import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HizmetAlan/profil_page.dart';
import 'favorilerim_page.dart';
import 'ilan_teklif_ver_page.dart';
import 'tekliflerim_page.dart';



class HV_HomePage extends StatefulWidget {




  @override
  State<HV_HomePage> createState() => _HV_HomePageState();
}

class _HV_HomePageState extends State<HV_HomePage> {

  List<String> ilanlar = [];

  void ilanEkle(String ilan){
    setState(() {
      ilanlar.add(ilan);
    });
  }
  @override
  void initState() {
    super.initState();
    // Add initial items to the ilanlar list
    ilanEkle('Item 1');
    ilanEkle('Item 2');
    ilanEkle('Item 3');
  }
  Future<void> removeUser() async {
    var sp = await SharedPreferences.getInstance();

    await sp.remove("mail");
    await sp.remove("sifre");
    await sp.remove("rol");
  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYukseklik = ekranBilgisi.size.height;
    final double ekranGenislik = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Ilaclam",
          style: 
            GoogleFonts.getFont('Balsamiq Sans',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TekliflerimPage();},),);
              }, 
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border,),
              onPressed: () {
              // Handle add button pressed
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FavorilerimPage();},),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.green,),
              onPressed: () {
              // Handle home button pressed
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HV_HomePage();},),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
              // Handle profile button pressed
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfilPage();},),);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children:<Widget> [
          Padding(padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListTile(
                    dense: true,
                    isThreeLine: true,
                    shape: const Border.symmetric(),
                    title: const Text("x",),
                    subtitle: const Text('xxxx'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const IlanTeklifVerPage();},),);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const IlanTeklifVerPage();},),);
                          },
                        ),

                      ],
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const IlanTeklifVerPage();},),);
                      }, 
                    ),
        
              ),
 
            ),
          )
        ],
      ),  
    );





  }
}