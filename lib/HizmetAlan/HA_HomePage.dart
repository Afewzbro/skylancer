import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/main.dart';

import 'aktif_ilanlar_page.dart';
import 'ilan_ekle_page.dart';
import 'profil_page.dart';



class HA_HomePage extends StatefulWidget {




  @override
  State<HA_HomePage> createState() => _HA_HomePageState();
}

class _HA_HomePageState extends State<HA_HomePage> {
  List<String> ilanlar = [];

  void ilanEkle(String ilan){
    setState(() {
      ilanlar.add(ilan);
    });
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
          "ilan Tekliflerim",
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
                    return const AktifIlanlarPage();},),);
              }, 
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
              // Handle add button pressed
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const IlanEklePage();},),);
              },
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.green,),
              onPressed: () {
              // Handle home button pressed
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HA_HomePage();},),);
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
      body: ElevatedButton(
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          // Navigate to the login or home screen after successful logout
          // You can replace the route with your desired screen
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } catch (e) {
          // Handle logout error, if any
          print('Logout error: $e');
        }
      },
      child: Text('Logout'),
    )
      
    );
  }
}