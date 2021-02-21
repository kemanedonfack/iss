import 'package:flutter/material.dart';
import 'package:iai/Controller/EtudianController.dart';
import 'package:iai/vue/page/connexion.dart';
import 'package:iai/vue/page/scanner.dart';
import 'package:iai/vue/utile/couleur.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    double space = MediaQuery.of(context).size.height * 0.04;
    double space2 = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.5
                  ,
                    child: Center(
                      child: Text("ISS",
                        style: TextStyle(color: primaire, fontWeight: FontWeight.bold, fontSize: 50.0),),
                    ),
                ),
                Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(15.0),
                      color: primaire ,
                      child: MaterialButton(
                        onPressed: (() => reseau()  ),
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text("Scanner un QRcode",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: space)),
                    Material(
                      borderRadius: BorderRadius.circular(15.0),
                      color: primaire ,
                      child: MaterialButton(
                        onPressed: (() => Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()))  ),
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text("Se connecter",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: space2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text("Seul l'administrateur à le droit de se connecter", textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }

    Future<Null> reseau() async{
      
    EtudiantController.reseau().then((resultat){

        if(resultat == "connecter"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
        }else if(resultat == "erreur"){
            connecter();
        }
      }
    );
    
  }

   Future<Null> connecter() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuillez vous connecter au réseau"),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
              )
            ],
          );
        }
    );
  }
}
