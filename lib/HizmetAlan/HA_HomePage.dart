import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/OrtakSayfalar/bizeUlasin.dart';
import 'package:skylancer/OrtakSayfalar/hesapAyarlar.dart';
import 'package:skylancer/OrtakSayfalar/hizmetOdemelerim.dart';
import 'package:skylancer/main.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

import '../ilveIlce.dart';





class HA_HomePage extends StatefulWidget {




  @override
  State<HA_HomePage> createState() => _HA_HomePageState();
}

class _HA_HomePageState extends State<HA_HomePage> {


  String? ad;
  String? soyad;
  String? userID;
  int sayac = 0;
  //ilanlarım backend

  String? getIl;
  String? getIlce;
  String? getDekar;
  String? getUrun;
  String? getHastalik;
  String? getAciklama;
  String? getIlanID;

  Future<List<DocumentSnapshot>> getIlanlar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ilanlar')
        .where('ilanSahibi', isEqualTo: "$userID")
        .where('aktif', isEqualTo: 1)
        .get();
    var veri = querySnapshot.docs;
    for(var docu in veri){
      print(docu.data());
    }
    print("$userID");
    print(querySnapshot.size);
    return querySnapshot.docs;
  }
  Future<void> deleteIlan(String ilanID) async {
    await FirebaseFirestore.instance.collection('ilanlar').doc("$ilanID").update({
      'aktif': 0,
    });
    setState(() {

    });
  }




  //ilan ekle backend
  String? il;
  String? ilce;
  String? urun;
  String? hastalik;
  String? aciklama;
  int? dekar;
  String? ilanID;


  int? benzersiz;

  void ilanEkle() async{
    if(il==null || ilce==null || dekar==null || urun==null || hastalik==null|| aciklama==null ||
        il!.isEmpty || ilce!.isEmpty || dekar==0 || urun!.isEmpty || hastalik!.isEmpty || aciklama!.isEmpty){
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Lütfen İlan Bilgilerinizi Tamamlayınız",
        message: "",
        duration: 5,
        onCloseEvent: () {},
      );
    }else{
      CollectionReference ilanlarRef = FirebaseFirestore.instance.collection('ilanlar');
      QuerySnapshot snapshot = await ilanlarRef.get();
      benzersiz = snapshot.size;
      print('İlan sayısı: $benzersiz');
      benzersiz = benzersiz! + 1001;
      FirebaseFirestore.instance.collection('ilanlar').doc("$benzersiz").set({
        "ID" : "$benzersiz",
        "il" : "$il",
        "ilce": "$ilce",
        "urun": "$urun",
        "hastalik": "$hastalik",
        "aciklama": "$aciklama",
        "dekar" : "$dekar",
        "ilanSahibi" : "$userID",
        "aktif": 1,

      });


    }
    print(userID);
    print("il: $il ilce: $ilce dekar: $dekar urun: $urun hastalik: $hastalik");
    print("$aciklama");
  }


  String? secilenIl;
  String? secilenIlce;
  List<String>? iller;
  List<String>? ilceler;



  @override
  void initState() {
    super.initState();
    iller = IlIlceVerileri.iller;
    secilenIlce = IlIlceVerileri.ilceler(iller![0])?[0];
  }
  void ilSecildi(String il) {
    setState(() {
      secilenIl = il;
      ilceler = IlIlceVerileri.ilceler(il);
      secilenIlce = IlIlceVerileri.ilceler(iller![0])?[0];
    });
  }
  void ilceSecildi(String ilce) {
    setState(() {
      secilenIlce = ilce;
    });
  }





  // profilim backend
  Future<void> removeUser() async {
    var sp = await SharedPreferences.getInstance();

    await sp.remove("mail");
    await sp.remove("sifre");
    await sp.remove("rol");
    await sp.remove("ad");
    await sp.remove("soyad");
    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage(title: "title")),);
  }
  Future<void> GetUserData() async {
    var sp = await SharedPreferences.getInstance();

    ad = sp.getString("ad");
    soyad = sp.getString("soyad");
    userID = sp.getString("mail");
    print("userdata geldi");
  }

  int pageIndex = 2;




  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double eYuk = ekranBilgisi.size.height;
    final double eGen = ekranBilgisi.size.width;



    if(sayac<1){
      GetUserData();
      print("$ad");
      print("$soyad");
      sayac = 5;
    }



    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: pageIndex ==0 ?
      PreferredSize(
        preferredSize: Size.fromHeight(eYuk/10),
        child: AppBar(
          title: Text(
            '\n  İlanlarım',
            style:  GoogleFonts.getFont('Balsamiq Sans',
          fontSize: eGen/13,
          fontWeight: FontWeight.bold,
          color: Colors.white),
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
      ) : pageIndex ==1 ?
      PreferredSize(
        preferredSize: Size.fromHeight(eYuk/10),
        child: AppBar(
          title: Text(
            '\n  İlan Ekle',
            style:  GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/13,
                fontWeight: FontWeight.bold,
                color: Colors.white),
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
      ) : pageIndex ==2 ?
      PreferredSize(
        preferredSize: Size.fromHeight(eYuk/10),
        child: AppBar(
          title: Text(
            '\n  İlan Tekliflerim',
            style:  GoogleFonts.getFont('Balsamiq Sans',
                fontSize: eGen/13,
                fontWeight: FontWeight.bold,
                color: Colors.white),
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
      ) :
      PreferredSize(
        preferredSize: Size.fromHeight(1),

        child: AppBar(



          centerTitle: false,
          backgroundColor: Colors.green,
          elevation: 0,

          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 0),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 2,
        activeColor: Colors.green,
        backgroundColor: Colors.white,
        color: Colors.black54,
        items: [
          TabItem(icon: Icons.list_sharp, title: 'İlanlarım'),
          TabItem(icon: Icons.add, title: 'İlan Ekle'),
          TabItem(icon: Icons.home, title: 'Tekliflerim'),
          TabItem(icon: Icons.person, title: 'Profilim'),
        ],
        onTap: (int i) => {
        setState(() {
        pageIndex = i;
        })
      }
      ),














      body: pageIndex ==0 ? // İlanlarım **********************

      SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: getIlanlar(),
            builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              } else {
                return Column(
                  children: snapshot.data!.map((document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    getIl = data['il'];
                    getIlce = data["ilce"];
                    getDekar = data["dekar"];
                    getUrun = data["urun"];
                    getHastalik = data["hastalik"];
                    getIlanID = data["ID"];

                    return Container(
                      child: Column(
                        children: [
                          SizedBox(height: eYuk/40,),
                          Container(
                            width: eGen/1.1,
                            height: eYuk/4,
                            child: Column(
                              children: [
                                SizedBox(height: eYuk/100,),
                                Row(
                                  children: [
                                    SizedBox(width: eGen/40,),
                                    Text("$getIl - $getIlce",style: GoogleFonts.getFont('Balsamiq Sans',
                                        fontSize: eGen/20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black

                                    ),),
                                  ],
                                ),
                                SizedBox(height: eYuk/70,),

                                Row(
                                  children: [
                                    SizedBox(width: eGen/40,),
                                    Text("$getDekar Dönüm $getUrun",style: GoogleFonts.getFont('Balsamiq Sans',
                                        fontSize: eGen/25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black

                                    ),),
                                  ],
                                ),
                                SizedBox(height: eYuk/70,),

                                Row(
                                  children: [
                                    SizedBox(width: eGen/40,),
                                    Text("$getHastalik İlaçlaması",style: GoogleFonts.getFont('Balsamiq Sans',
                                        fontSize: eGen/25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black

                                    ),),
                                  ],
                                ),
                                SizedBox(height: eYuk/15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SizedBox(height: eYuk/20, width: eGen/3,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // iptal et
                                            deleteIlan(getIlanID!);



                                          },
                                          child: Text("İptal Et",style: GoogleFonts.getFont('Balsamiq Sans',
                                            fontSize: eGen/20,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Kenarların oval yapısı
                                            ),


                                          ),
                                        ),),
                                    ),
                                    SizedBox(width: eGen/40,),


                                  ],
                                )

                              ],
                            ),

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Çerçevenin rengini belirleyin
                                width: 2, // Çerçevenin kalınlığını belirleyin
                              ),
                              borderRadius: BorderRadius.circular(15), // Kenarları oval yapın
                            ),
                          ),



                        ],
                      )
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ) : pageIndex == 1 ?  // İlan Ekle **********************
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: eYuk/25,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text("İl : ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                  Container(
                    width: eGen/3.5, height: eYuk/25,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),


                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return iller!.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        }).toList();
                      },
                      onSelected: (String selected) {
                        secilenIl = selected;
                        ilSecildi("$secilenIl");
                        il = selected;
                      },
                      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,

                          onChanged: (String newValue) {
                            setState(() {
                              secilenIl = newValue;
                              ilSecildi("$secilenIl");
                              il = secilenIl;
                            });
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

                        );
                      },
                      optionsViewBuilder: (BuildContext context, Function(String) onSelected, Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Container(
                              height: 200.0,
                              width: eGen/2.5,
                              child: ListView.builder(
                                padding: EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text("   İlçe : ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                  Container(
                    width: eGen/2.7, height: eYuk/25,
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return ilceler != null
                            ? ilceler!.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        }).toList()
                            : [];
                      },
                      onSelected: (String selected) {
                        ilce = selected;
                      },
                      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,

                          onChanged: (String newValue) {
                            setState(() {
                              ilce = newValue;
                            });
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
                        );
                      },
                      optionsViewBuilder: (BuildContext context, Function(String) onSelected, Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Container(
                              height: 200.0,
                              width: eGen/2.5,
                              child: ListView.builder(
                                padding: EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: eYuk/30,),
              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text("Tarla Alanı(Dekar) :  ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                  SizedBox(
                    width: eGen/2.35, height: 20,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value ) {
                        setState(() {
                          if(value.isEmpty || value==null){
                            dekar = 0;
                          }
                          dekar = int.parse(value);

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

                ],
              ),
              SizedBox(height: eYuk/30,),


              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text("İlaçlanacak Ürün Cinsi :  ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                  SizedBox(
                    width: eGen/3.1, height: 20,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          urun = value;
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
              SizedBox(height: eYuk/30,),




              Row(
                children: [
                  SizedBox(width: eGen/15,),
                  Text("Üründeki Hastalık Cinsi :  ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                  SizedBox(
                    width: eGen/3.3, height: 20,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          hastalik = value;
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
              SizedBox(height: eYuk/30,),

              Row(
                children: [
                  SizedBox(width: eGen/15,),

                  Text("İlan Açıklaması :  ",style: GoogleFonts.getFont('Balsamiq Sans',
                      fontSize: eGen/20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                  ),),
                ],
              ),
              SizedBox(height: eYuk/60,),
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
                        TextFormField(
                          maxLines: 7,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            setState(() {
                              aciklama = value;

                            });
                          },

                          decoration: InputDecoration(
                            border: InputBorder.none, // Çizgiyi kaldırmak için InputBorder.none kullanın
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: eYuk/15,),


              SizedBox(height: eYuk/12, width: eGen/1.2,
                child: ElevatedButton(
                  onPressed: () {
                    ilanEkle();












                  },
                  child: Text("Tamamla",style: GoogleFonts.getFont('Balsamiq Sans',
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



















        ),
      ) : pageIndex == 2 ? // İlan Tekliflerim **********************
      SingleChildScrollView(
        child: Center(
          child: Column(

            children: [
             SizedBox(height: eYuk/15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    ' Henüz ilanlarına\n bir teklif gelmedi.',
                    style:  GoogleFonts.getFont('Balsamiq Sans',
                        fontSize: eGen/15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                  ),
                  ),
                ]
              ),






            ],


          ),


        ),



















      ) : pageIndex == 3 ? // Profilim **********************
      SingleChildScrollView(
        child: Center(
          child: Column(

            children: [

              Row(


                children: [
                  Container(width: eGen,height: eYuk/3,
                    child: Column(
                      children: [
                        SizedBox(height: eYuk/60,),
                        Row(
                          children: [
                            SizedBox(width: eGen/20,),
                            Column(
                              children: [

                                Text(
                                  '0 Tamamlanan İş    ',
                                  style:  GoogleFonts.getFont('Balsamiq Sans',
                                      fontSize: eGen/20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star,color: Colors.amberAccent,),
                                    Text(
                                      '0.0 (0)     ',
                                      style:  GoogleFonts.getFont('Balsamiq Sans',
                                          fontSize: eGen/20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: eGen/30,),
                            Container(width: eGen/2.4,height: eGen/2.4,
                              



                              child: Row(
                                children: [
                                  SizedBox(width: eGen/3.5,),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () {
                                        // Foto ekleme islemleri
                                      },
                                      child: Container(
                                        width: eGen / 10,
                                        height: eGen / 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(Icons.camera_alt),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,),
                            ),

                            ),
                          ],
                        ),
                        SizedBox(height: eYuk/40,),
                        Text(
                          '$ad $soyad',
                          style:  GoogleFonts.getFont('Balsamiq Sans',
                              fontSize: eGen/15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),

                      ],
                    ),


                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,),
                    ),

                  ),


                ],
              ),
              // profil sayfası fake appbar sonu
              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => hizmetOdemelerimPage()),);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.credit_card,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Hizmet Ödemelerim',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),


              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => hesapAyarlarPage()),);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.settings,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Hesap Ayarları         ',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),

              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Butona tıklama olayını buraya ekleyin
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.handshake_outlined,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Drone&Ekipman Satışı ',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),


              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => bizeUlasinPage()),);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.question_answer_outlined,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Bize Ulaşın               ',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),

              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Butona tıklama olayını buraya ekleyin
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.rotate_left,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Hizmet Veren Hesaba Geç ',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),
              SizedBox(height: eYuk/150,),
              SizedBox(
                width: eGen, height: eYuk/12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    removeUser();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Row(

                    children: [
                      Icon(Icons.logout_outlined,color: Colors.black,size: eGen/10,),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Text(
                        'Çıkış Yap                   ',
                        style:  GoogleFonts.getFont('Balsamiq Sans',
                            fontSize: eGen/15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(width: 8), // İkona istediğiniz genişlikte bir boşluk ekleyebilirsiniz
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                    ],
                  ),
                  label: SizedBox.shrink(),
                ),
              ),







            ],

          ),


        ),
      ) :
          Row(
            children: [

            ],
          ),











    );
  }
}