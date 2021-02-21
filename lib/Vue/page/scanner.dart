import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:iai/Vue/page/etudiantPage.dart';
import 'package:iai/vue/utile/couleur.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  String matricule = "Aucun matricule";
  var donnee;
  bool trouver = false;

    @override
    void initState() {
      super.initState();
    resultat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), 
            onPressed: (() => Navigator.pop(context) ),
          ),
          title: Text("Scanner un QRcode"),
          centerTitle: true,
        ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // Flexible(
                  //   child: Text(
                  //     "Résultat:  ${(matricule)}",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                ],
              ),

              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  color: primaire ,
                  child: MaterialButton(
                    onPressed: () async {
                      var options = ScanOptions(
                        autoEnableFlash: false,
                      );
                      var data = await BarcodeScanner.scan(options: options);
                      setState(() {
                        matricule = data.rawContent.toString();
                        print(matricule);
                        trouver = true;
                         if(trouver == true){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EtudiantPage(matricule) ));
                        }else{
                          print("non trouvé");
                        }
                      });
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text("Scanner",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resultat (){
    print("ici");
    if(trouver == true){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EtudiantPage(matricule) ));
    }else{
      print("non trouvé");
    }
  }
}
