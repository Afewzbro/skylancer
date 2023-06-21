
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skylancer/HizmetVeren/HV_TeklifVerPage.dart';
import 'package:skylancer/main.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


import '../ilveIlce.dart';





class HV_HomePage extends StatefulWidget {




  @override
  State<HV_HomePage> createState() => _HV_HomePageState();
}

class _HV_HomePageState extends State<HV_HomePage> {


  String? ad;
  String? soyad;
  String? userID;
  int sayac = 0;
  //Aktif İlanlar backend

  String? getIl;
  String? getIlce;
  String? getDekar;
  String? getUrun;
  String? getHastalik;
  String? getAciklama;
  String? getIlanID;
  List<String> favoriIlanlar = [];


  Future<void> removeFavori(String ilanID, String userID) async {
    print("favori sildim");
    favoriIlanlar.removeWhere((id) => id == ilanID);
    print("$favoriIlanlar");
    print(ilanID);
    print(userID);
    await FirebaseFirestore.instance
        .collection('ilanlar')
        .doc(ilanID)
        .collection('favoriAlan')
        .where('mail', isEqualTo: userID)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        print("$snapshot");
        doc.reference.delete();
      }
    });
  }
  Future<void> addFavori(String ilanID, String userID) async {
    print("favori ekledim");
    print("$favoriIlanlar");
    await FirebaseFirestore.instance
        .collection('ilanlar')
        .doc(ilanID)
        .collection('favoriAlan')
        .doc(userID)
        .set({'mail': userID});
  }

  Future<List<DocumentSnapshot>> getIlanlar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ilanlar')
        .where('aktif', isEqualTo: 1)
        .get();



    for (DocumentSnapshot doc in querySnapshot.docs) {
      QuerySnapshot favoriDocs = await doc.reference
          .collection('favoriAlan')
          .where('mail', isEqualTo: userID)
          .get();

      if (favoriDocs.docs.isNotEmpty) {
        if (!favoriIlanlar.contains(doc.id)) {
          favoriIlanlar.add(doc.id);
          print("favori liste oluştururken ekledim");
        }

      }
    }


    var veri = querySnapshot.docs;
    for(var docu in veri){
      print(docu.data());
    }
    print("$userID");
    print(querySnapshot.size);
    return querySnapshot.docs;
  }

  Future<void> saveIlanID(String IlanID) async {
    var sp = await SharedPreferences.getInstance();

    await sp.setString("IlanID", "$IlanID");
    print("Kaydedildi $IlanID");


    Navigator.push( context, MaterialPageRoute(builder: (context) => HV_TeklifVerPage()),);


  }




  // Favori İlanlarım Backend

  Future<List<DocumentSnapshot>> getFavIlanlar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ilanlar')
        .where('aktif', isEqualTo: 1)
        .get();



    for (DocumentSnapshot doc in querySnapshot.docs) {
      QuerySnapshot favoriDocs = await doc.reference
          .collection('favoriAlan')
          .where('mail', isEqualTo: userID)
          .get();

      if (favoriDocs.docs.isNotEmpty) {
        if (!favoriIlanlar.contains(doc.id)) {
          favoriIlanlar.add(doc.id);
          print("favori liste oluştururken ekledim");
        }

      }
    }


    var veri = querySnapshot.docs;
    for(var docu in veri){
      print(docu.data());
    }
    print("$userID");
    print(querySnapshot.size);
    return querySnapshot.docs;
  }








  int? benzersiz;

  /* void ilanBasvur() async{
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

   */


  String? secilenIl;
  String? secilenIlce;
  List<String>? iller;
  List<String>? ilceler;



  @override
  void initState() {
    super.initState();
    iller = IlIlceVerileri.iller;
    // İlk ilin ilk ilçesini varsayılan ilçe olarak atayın
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
            '\n  Tekliflerim',
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
            '\n  Favori İlanlarım',
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
            '\n  Aktif İlanlar',
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
            TabItem(icon: Icons.list_sharp, title: 'Tekliflerim'),
            TabItem(icon: Icons.favorite, title: 'Favorilerim'),
            TabItem(icon: Icons.home, title: 'İlanlar'),
            TabItem(icon: Icons.person, title: 'Profilim'),
          ],
          onTap: (int i) => {
            setState(() {
              pageIndex = i;
            })
          }
      ),














      body: pageIndex ==0 ? // Tekliflerim ********

      SingleChildScrollView(
        child: Center(

        ),












      ) : pageIndex == 1 ?  // Favorilerim ********
      SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: getFavIlanlar(),
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
                    String? IlanID = data["ID"];
                    String _iconYapi = "unfav";
                    if(favoriIlanlar.contains(getIlanID)){
                      _iconYapi = "fav";
                    }else{
                      _iconYapi = "unfav";
                    }
                    void favla(){
                      setState(() {
                        _iconYapi = "fav";
                      });
                    }
                    void unfavla(){
                      setState(() {
                        _iconYapi ="unfav";
                      });
                    }






                if(_iconYapi=="fav"){
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
                                      color: Colors.black,

                                    ),),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            print("$IlanID");
                                            if(favoriIlanlar.contains(IlanID)){
                                              removeFavori("$IlanID", "$userID");
                                              unfavla();



                                            }else{
                                              addFavori("$IlanID", "$userID");
                                              favla();
                                              print("$IlanID");


                                            }
                                          },
                                          icon: Icon(
                                            _iconYapi=="fav" ? Icons.favorite : Icons.favorite_border,
                                            size: 35,
                                            color: _iconYapi=="fav" ? Colors.red : Colors.black,

                                          ),
                                        ),
                                      ),
                                    ),
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
                                SizedBox(height: eYuk/35,),

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
                                            saveIlanID("$IlanID");




                                          },
                                          child: Text("Teklif Ver",style: GoogleFonts.getFont('Balsamiq Sans',
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
                              color: Colors.white,
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
                }else{
                  return Container();
                }

                  }).toList(),
                );
              }
            },
          ),
        ),













      ) : pageIndex == 2 ? // Aktif İlanlar ********
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
                    String? IlanID = data["ID"];
                    String _iconYapi = "unfav";
                    if(favoriIlanlar.contains(getIlanID)){
                      _iconYapi = "fav";
                    }else{
                      _iconYapi = "unfav";
                    }
                    void favla(){
                      setState(() {
                        _iconYapi = "fav";
                      });
                    }
                    void unfavla(){
                      setState(() {
                        _iconYapi ="unfav";
                      });
                    }







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
                                          color: Colors.black,

                                      ),),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              print("$IlanID");
                                              if(favoriIlanlar.contains(IlanID)){
                                                removeFavori("$IlanID", "$userID");
                                                unfavla();



                                              }else{
                                                addFavori("$IlanID", "$userID");
                                                favla();
                                                print("$IlanID");


                                              }
                                            },
                                            icon: Icon(
                                              _iconYapi=="fav" ? Icons.favorite : Icons.favorite_border,
                                              size: 35,
                                              color: _iconYapi=="fav" ? Colors.red : Colors.black,

                                            ),
                                          ),
                                        ),
                                      ),
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
                                  SizedBox(height: eYuk/35,),

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
                                              saveIlanID("$IlanID");




                                            },
                                            child: Text("Teklif Ver",style: GoogleFonts.getFont('Balsamiq Sans',
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
                                color: Colors.white,
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





      ) : pageIndex == 3 ? // Profilim ********
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
                        'Hizmet Alan Hesaba Geç   ',
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