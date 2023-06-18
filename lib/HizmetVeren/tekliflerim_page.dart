import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../HizmetAlan/profil_page.dart';
import 'HV_HomePage.dart';
import 'favorilerim_page.dart';

class TekliflerimPage extends StatefulWidget {
  const TekliflerimPage({super.key});

  @override
  State<TekliflerimPage> createState() => _TekliflerimPageState();
}

class _TekliflerimPageState extends State<TekliflerimPage> {
  @override
  Widget build(BuildContext context) {
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
              
            ),
          )
        ],
      ),  
    );

  }
}