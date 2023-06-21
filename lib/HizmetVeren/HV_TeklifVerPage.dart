

import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetVeren/HV_HomePage.dart';
import 'package:google_fonts/google_fonts.dart';







class HV_TeklifVerPage extends StatefulWidget {




  @override
  State<HV_TeklifVerPage> createState() => _HV_TeklifVerPageState();
}



class _HV_TeklifVerPageState extends State<HV_TeklifVerPage> {
  TextEditingController _controller = TextEditingController();
  late Future<DocumentSnapshot> futureIlanlar; // Future saklanacak bir değişken



  @override
  void initState() {
    super.initState();
    futureIlanlar = getIlanlar(); // getIlanlar initState'de çağrılıyor.
  }


  String? ad;
  String? soyad;
  String? userID;
  String? IlanID;
  int sayac = 0;
  int TRY = 0;

  Future<void> GetUserData() async {



  }

  Future<DocumentSnapshot> getIlanlar() async {
    var sp = await SharedPreferences.getInstance();

    ad = sp.getString("ad");
    soyad = sp.getString("soyad");
    userID = sp.getString("mail");
    IlanID = await sp.getString("IlanID");

    String? il = "";
    String? ilce;
    String? dekar;
    String? hastalik;
    String? urun;
    String? aciklama;



    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('ilanlar')
        .doc('$IlanID')
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      aciklama = data['aciklama'];
      dekar = data['dekar'];
      hastalik = data['hastalik'];
      il = data['il'];
      ilce = data['ilce'];
      urun = data['urun'];
    } else {
      print('The document does not exist!');
    }

    return documentSnapshot;
  }

  void teklifVer() {
    if(TRY==0){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Lütfen teklif giriniz.",
        message: "",
        duration: 3,
        onCloseEvent: () {

        },
      );
    }else{
      //ilan kayit islemleri
      FirebaseFirestore.instance.collection('ilanlar').doc("$IlanID").collection('teklifVeren').doc("$userID").set({

        "ilanID" : "$IlanID",
        "teklifSahibi" : "$userID",
        "teklif" : "$TRY",



      });
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.success,
        title: "Teklif işlemi başarılı.",
        message: "İlanlarım sayfasına yönlendiriliyorsunuz.",
        duration: 3,
        onCloseEvent: () {
          Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => HV_HomePage()),);
        },
      );

    }
  }


  @override
  Widget build(BuildContext context) {

    if(sayac<1){
      GetUserData();
      getIlanlar();

      sayac = 5;
    }

    var ekranBilgi = MediaQuery.of(context);
    final double eYuk = ekranBilgi.size.height;
    final double eGen = ekranBilgi.size.width;







    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(eYuk / 10),
        child: FutureBuilder<DocumentSnapshot>(
          future: futureIlanlar,
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

              return AppBar(
                automaticallyImplyLeading: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      '\n  ${data['il']} - ${data['ilce']}',
                      style: GoogleFonts.getFont('Balsamiq Sans',
                          fontSize: eGen / 17, fontWeight: FontWeight.bold, color: Colors.white),
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
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return AppBar(
                title: Text("Loading..."),
                centerTitle: false,
                backgroundColor: Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              );
            } else {
              return AppBar(
                title: Text("Error: ${snapshot.error}"),
                centerTitle: false,
                backgroundColor: Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: futureIlanlar,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Center(

              child: Column(
                children: [

                  SizedBox(height: eYuk / 20,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Text(
                        '${data['dekar']} Dekar ${data['urun']}',
                        style: GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen / 23, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk / 70,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Text(
                        '${data['hastalik']} İlaçlaması',
                        style: GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen / 23, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk / 35,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Container(width: eGen/1.2, height: eYuk/4,
                        child: Text(
                          'İlan Açıklaması : \n${data['aciklama']}',
                          style: GoogleFonts.getFont('Balsamiq Sans',
                              fontSize: eGen / 23, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/20,),
                  Row(
                    children: [
                      SizedBox(width: eGen/15,),
                      Text(
                        'Teklif Ver(Dekar): ',
                        style: GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen / 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: eGen/7, height: 20,
                        child: TextFormField(
                          controller: _controller,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          onChanged: (value ) {
                            setState(() {
                              if(value.isEmpty){
                                TRY = 0;
                              }
                              TRY = int.parse(value);

                            });
                          },

                          validator: (value) {

                            if (value!.isEmpty) {



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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5), // alt çizginin metinden biraz uzağında olması için
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,  // çizginin rengi
                              width: 2.0,  // çizginin kalınlığı
                            ),
                          ),
                        ),
                        child: Text(
                          'TRY',
                          style: GoogleFonts.getFont('Balsamiq Sans',
                              fontSize: eGen / 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: eYuk/30,),
                  Container(width: eGen/1.1,
                    child: Text(
                      'İlan sahibi teklifinizi kabul ettikten sonra iletişim bilgileri çift taraflı paylaşılacaktır. ',
                      style: GoogleFonts.getFont('Balsamiq Sans',
                          fontSize: eGen / 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: eYuk/30,),

                  SizedBox(height: eYuk/12, width: eGen/1.2,
                    child: ElevatedButton(
                      onPressed: () {
                        teklifVer();













                      },
                      child: Text("Teklif Ver",style: GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/12,
                        fontWeight: FontWeight.bold,
                      ),),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
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
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());  // Veriler yüklenirken bir dönen çember göster
          } else {
            return Center(child: Text("Error: ${snapshot.error}"));  // Hata oluşursa hatayı göster
          }
        },
      ),
    );
  }


}