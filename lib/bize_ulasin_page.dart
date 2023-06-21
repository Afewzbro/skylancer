import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BizeUlasinPage extends StatefulWidget {
  const BizeUlasinPage({super.key});

  @override
  State<BizeUlasinPage> createState() => _BizeUlasinPageState();
}

class _BizeUlasinPageState extends State<BizeUlasinPage> {

  final String phoneNumber = '+1234567890';
  final String emailAddress = 'info@tarimkon.org';
  final String websiteUrl = 'https://www.example.com';

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double eYuk = ekranBilgisi.size.height;
    final double eGen = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Feedback',
          style:  TextStyle(
            color: Colors.white,
            fontFamily: 'BalsamiqSans',
            fontSize: 24.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:  Icon(Icons.group,color: Colors.green,size: eGen/10,),
              title:  Text('Uluslararasi Tarim ve Gida Konfederasyon',style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
              onTap: () => _launchUrl(websiteUrl),
            ),
            ListTile(
              leading:  Icon(Icons.phone,color: Colors.green,size: eGen/10,),
              title:  Text(phoneNumber.toString(),style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
              onTap: () => _launchUrl('tel:$phoneNumber'),
            ),
            ListTile(
              leading: Icon(Icons.mail,color: Colors.black,size: eGen/10,),
              title:  Text(emailAddress.toString(),style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
              onTap: () => _launchUrl('mailto:$emailAddress'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.black,size: eGen/10,),
              title:  Text('Adres ....',style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
              onTap: () => _launchUrl('https://www.google.com/maps'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Bize Mesaj Gonderin:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Mesajiniz burda giriniz...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Handle send feedback action
                },
                backgroundColor:Colors.green,
                child: Icon(Icons.send,size: eGen/10,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}