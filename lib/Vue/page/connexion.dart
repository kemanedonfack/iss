import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:iai/Controller/EtudianController.dart';
import 'package:iai/vue/utile/couleur.dart';


import 'admin.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formkey = GlobalKey();
  bool masquerMdp= true;

  @override
  Widget build(BuildContext context) {

    double space = MediaQuery.of(context).size.height * 0.01;
    double space1 = MediaQuery.of(context).size.height * 0.03;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (() => Navigator.pop(context) ),
            child: Icon(Icons.arrow_back_ios, color: Colors.black,)
        ),
        title: Text("Connectez-vous", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formkey,
              child: Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(child: Text("Se connecter", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),)),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.withOpacity(0.2),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: telController,
                    decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 8.0,),
                        child: Icon(Icons.phone, color: primaire,),
                      ),
                      border: InputBorder.none,
                      hintText: "Numéro de téléphone",
                    ),
                    validator: (value){
                      if(value.isNotEmpty){
                          RegExp regex = new RegExp(r"^6[957][0-9]{7}$");
                          if(!regex.hasMatch(value)){
                            return "votre numéro est invalide";
                          }else{
                            return null;
                          }
                        }else{
                          return "Veillez entrer un numéro";
                        }
                      },
                    ),
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: space)),

                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.withOpacity(0.2),
                  child: TextFormField(
                    controller: passController,
                    obscureText: masquerMdp,
                    decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 8.0,),
                        child: Icon(Icons.lock, color: primaire,),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                         setState(() {
                            masquerMdp = !masquerMdp;
                          });
                        },
                        child: masquerMdp ? Icon(Icons.visibility_off, color: primaire, ) : Icon(Icons.visibility, color: primaire, ),
                      ),
                      border: InputBorder.none,
                      hintText: "Mot de passe",
                    ),
                    validator: (value){
                      if(value.isNotEmpty){
                        return null;
                      }else{
                        return "veillez votre mot de passe";
                      }
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: space1)),

                Material(
                  borderRadius: BorderRadius.circular(15.0),
                  color: primaire ,
                  child: MaterialButton(
                    onPressed: (() =>  connexion() ),
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text("Se connecter",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Future<Null> connexion() async {
    var bytes = utf8.encode(passController.text);
    String password = sha256.convert(bytes).toString();
    
    // print("Password : $digest");
    FormState formState = formkey.currentState;
    if(formState.validate()){
        formState.save();        
        await EtudiantController.connexion(telController.text, password).then((result) async {
          if("success" == result){
              // print("connexion réussie");
             await  clean();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
            }else if("erreur" == result) {
             alert();
            }else{
              connecter();
            }
        }) ;
    }
  }

    Future<Null> alert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Mot de passe ou numéro incorrect"),
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

  Future<Null> connecter(){
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

  clean(){
    passController.text = "";
    telController.text = "";
  }

}
