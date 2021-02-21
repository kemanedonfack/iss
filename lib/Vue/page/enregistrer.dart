import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iai/Controller/EtudianController.dart';
import 'package:iai/Model/DeuxiemeTranche.dart';
import 'package:iai/Model/Etudiant.dart';
import 'package:iai/Model/Preinscription.dart';
import 'package:iai/Model/PremiereTranche.dart';
import 'package:iai/Model/QuatriemeTranche.dart';
import 'package:iai/Model/TroisiemeTranche.dart';
import 'package:iai/vue/utile/couleur.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


import 'generer.dart';

class Enregistrer extends StatefulWidget {
  @override
  _EnregistrerState createState() => _EnregistrerState();
}

class _EnregistrerState extends State<Enregistrer> {

  @override initState(){

    super.initState();
    _createTable();
    print("me");
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  int valeur = 1;
  
  int val=1558432747;
  String datePremiereTranche = "aucune date";
  String dateDeuxiemeTranche = "aucune date";
  String dateTroisiemeTranche = "aucune date";
  String dateQuatriemeTranche = "aucune date";
  String datePreinscription =  "aucune date";
  File _image;

  final formkey = GlobalKey();
  final scafoldkey = GlobalKey<ScaffoldState>();

  bool preinscription = false;
  bool premiereTranche = false;
  bool deuxiemeTranche = false;
  bool troisiemTranche = false;
  bool quatriemeTranche = false;

  String base64Image;
  File tmpFile;
  String cheminFichier="http://192.168.43.123/Test/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:InkWell(
          onTap: (){Navigator.pop(context);},
          child:  Icon(Icons.arrow_back_ios),
        ),
        title: Text("Créer un compte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        imagePath(),
                        Positioned(
                          child:InkWell(
                           onTap: (() => getImage(ImageSource.camera) ),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: primaire
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.camera_alt, color: Colors.white, size: 35,),
                                )
                            ),
                          ) ,
                          bottom: 30,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      child: TextFormField(
                        controller: nomController,
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0,),
                            child: Icon(Icons.person, color: primaire,),
                          ),
                          border: InputBorder.none,
                          hintText: "Nom & Prénom",
                        ),
                        validator: (value){
                          if(value.isNotEmpty){
                            return null;
                          }else{
                            return "Veillez entrer votre nom";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0,),
                            child: Icon(Icons.email, color: primaire,),
                          ),
                          border: InputBorder.none,
                          hintText: "Adresse email",
                        ),
                        validator: (value){
                          if(value.isNotEmpty){
                            RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if(!regex.hasMatch(value)){
                              return "votre Adresse email invalide";
                            }else{
                              return null;
                            }
                          }else{
                            return "Veillez entrer une adresse email";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Material(
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
                          hintText: "Téléphone",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      child: TextFormField(
                        controller: matriculeController,
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0,),
                            child: Icon(Icons.perm_identity, color: primaire,),
                          ),
                          border: InputBorder.none,
                          hintText: "Matricule",
                        ),
                        validator: (value){
                          if(value.isNotEmpty){
                            RegExp regex = new RegExp(r"^[A-Z]{2}.[0-9]{3}.[0-9]{5}.[0-9]{2}$");
                            if(!regex.hasMatch(value)){
                              return "votre maticule est invalide";
                            }else{
                              return null;
                            }
                          }else{
                            return "Veillez entrer votre matricule";
                          }
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      child: TextFormField(
                        controller: classeController,
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0,),
                            child: Icon(Icons.class_, color: primaire,),
                          ),
                          border: InputBorder.none,
                          hintText: "Classe",
                        ),
                        validator: (value){
                          if(value.isNotEmpty){
                            RegExp regex = new RegExp(r"^[A-Za-z]{2}[0-9]{1}[A-Za-z]{1}$");
                            if(!regex.hasMatch(value)){
                              return "votre classe est invalide";
                            }else{
                              return null;
                            }
                          }else{
                            return "Veillez entrer votre classe";
                          }
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        value: valeur,
                        items:[
                          DropdownMenuItem(
                            child:Text("Niveau 1"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child:Text("Niveau 2"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child:Text("Niveau 3"),
                            value: 3,
                          ),
                        ],
                        onChanged: (val){
                          setState(() {
                            valeur = val;
                          });
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: primaire,),),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text("Scolarité"),
                        ),
                        Expanded(child: Divider(color: primaire,),)
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pré-inscription"),
                      Switch(
                          value: preinscription,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.red,
                          onChanged: (val){
                            setState(() {
                              preinscription = !preinscription;
                            });
                          }
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        montrerPicker(0);
                      });
                      },
                    child: Row(
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(Icons.calendar_today),
                          ),
                        Text(datePreinscription),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Prémière tranche"),
                        Switch(
                            value: premiereTranche,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.red,
                            onChanged: (val){
                              setState(() {
                                premiereTranche = !premiereTranche;
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              montrerPicker(1);
                            });
                          },
                          child: Icon(Icons.calendar_today)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(datePremiereTranche),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Deuxième tranche"),
                        Switch(
                            value: deuxiemeTranche,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.red,
                            onChanged: (val){
                              setState(() {
                                deuxiemeTranche = !deuxiemeTranche;
                              });
                            }
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              montrerPicker(2);
                            });
                          },
                          child: Icon(Icons.calendar_today)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(dateDeuxiemeTranche),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Troisième tranche"),
                        Switch(
                            value: troisiemTranche,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.red,
                            onChanged: (val){
                              setState(() {
                                troisiemTranche = !troisiemTranche;
                              });
                            }
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              montrerPicker(3);
                            });
                          },
                          child: Icon(Icons.calendar_today)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(dateTroisiemeTranche),
                      ),
                    ],
                  ),

                  tranche(),

                  InkWell(
                  onTap: (){
                    generation();

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primaire ,
                        child: MaterialButton(
                          onPressed: (() => generation() ),
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("Créer un compte",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> montrerPicker(int val) async {
    DateTime choix = await  showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now(),
        initialDatePickerMode: DatePickerMode.year
    );
  
    var format = new DateFormat('yyyy-MM-dd');
    print(format.format(choix));
      // Text("${datePreinscription.toLocal()}".split(' ')[0]),
    if(val == 0){
      setState(() {
        datePreinscription = format.format(choix).toString();
      });
    }else if(val == 2){
      setState(() {
        dateDeuxiemeTranche = format.format(choix).toString();
      });
    }else if(val == 3){
      setState(() {
        dateTroisiemeTranche = format.format(choix).toString();
      });
    }else if(val == 4){
      setState(() {
        dateQuatriemeTranche = format.format(choix).toString();
      });
    }else if(val == 1){
      setState(() {
        datePremiereTranche = format.format(choix).toString();
      });
    }
  }

  Widget tranche(){
    if(valeur == 3){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quatrième tranche"),
                Switch(
                    value: quatriemeTranche,
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    onChanged: (val){
                      setState(() {
                        quatriemeTranche = !quatriemeTranche;
                      });
                    }
                )
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                  onTap: (){
                    setState(() {
                      montrerPicker(4);
                    });
                  },
                  child: Icon(Icons.calendar_today)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(dateQuatriemeTranche),
              ),
            ],
          ),
        ],
      );
    }else{
      return Text("");
    }
  }  

    Widget imagePath(){
    
      if(_image == null){
          return Container(
          margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.3,
            child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("images/avatar.jpg"),
          ),
        );
      }else{
          tmpFile = _image;
          base64Image = base64Encode(_image.readAsBytesSync());
          return Container(
          margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.3,
            child: CircleAvatar(
            radius: 100,
             backgroundImage: new FileImage(_image),
          ),
        );
      }
  }

  Future getImage(ImageSource source) async {
    var nouvelleImage = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = nouvelleImage;
    });
  }

   void generation () async{
    FormState formState = formkey.currentState;
    
    if(_image != null){
      startUpload();

        if(formState.validate()){
        formState.save();

        Preinscription preInscription = new Preinscription();
        preInscription.datedepayement = datePreinscription.toString() ;
        preInscription.paye =  (preinscription ? 1 : 0).toString() ;

        PremiereTranche premieretranche = new PremiereTranche();
        premieretranche.datedepayement = datePremiereTranche.toString();
        premieretranche.paye = (premiereTranche ? 1 : 0).toString();

        DeuxiemeTranche deuxiemetranche = new DeuxiemeTranche();
        deuxiemetranche.datedepayement = dateDeuxiemeTranche.toString();
        deuxiemetranche.paye = (deuxiemeTranche ? 1 : 0).toString();

        TroisiemeTranche troisiemetranche = new TroisiemeTranche();
        troisiemetranche.datedepayement = dateTroisiemeTranche.toString();
        troisiemetranche.paye = (troisiemTranche ? 1 : 0).toString();

        QuatriemeTranche quatriemetranche = new QuatriemeTranche();
        quatriemetranche.datedepayement = dateQuatriemeTranche.toString();
        quatriemetranche.paye = (quatriemeTranche ? 1 : 0).toString();

        Etudiant etudiant = new Etudiant();
        etudiant.nom = nomController.text.toString();
        etudiant.telephone = telController.text.toString();
        etudiant.photo = cheminFichier.toString();
        etudiant.niveau = valeur.toString();
        etudiant.matricule = matriculeController.text.toString();
        etudiant.email = emailController.text.toString();
        etudiant.classe = classeController.text.toString();

         EtudiantController etudiantController = EtudiantController();
         etudiantController.add(etudiant, preInscription, premieretranche, deuxiemetranche, troisiemetranche, quatriemetranche).then((value){
            if(value == "erreur"){
              connecter();   
            }else{      
              Navigator.push(context, MaterialPageRoute(builder: (context) => QRCode(matriculeController.text) ));
            }
         });
        //  etudiantController.addPreinscription(preInscription).then((result){
        //   if("success" == result){
        //       print(result);
        //     }
        // }) ;
        // etudiantController.addPremiereTranche(premieretranche).then((result){
        //   if("success" == result){
        //       print(result);
        //     }
        // }) ;
        // etudiantController.addDeuxiemeTranche(deuxiemetranche).then((result){
        //   if("success" == result){
        //       print(result);
        //     }
        // }) ;
        // etudiantController.addTroisiemeTranche(troisiemetranche).then((result){
        //   if("success" == result){
        //       print(result);
        //     }
        // }) ;

        // etudiantController.addQuatriemeTranche(quatriemetranche).then((result){
        //     if("success" == result){
        //         print(result);
        //       }
        //   });
        
        // etudiantController.addEtudiant(etudiant).then((result){
        //   if("success" == result){
        //       print(result);
        //     }
        // });
    }
    }else{
      alert();
    }

  }

    _createTable(){
    EtudiantController.createTable().then((result){
        if('success' == result){
          print("réussi");
        }
    });
  }
  
  Future<Null> alert(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veillez prendre une photo de l'étudiant"),
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

  startUpload() {
    String fileName = tmpFile.path.split('/').last;
    cheminFichier = cheminFichier+fileName;
    upload(fileName);
  }
 
  upload(String fileName) {
    http.post('http://192.168.43.123/Test/test.php', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      print("mesage");
    }).catchError((error) {
      print("erreur la");
    });
  }

  clean (){
    nomController.text="";
    telController.text="";
    matriculeController.text="";
    classeController.text="";
    _image = null;
    emailController.text="";
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

