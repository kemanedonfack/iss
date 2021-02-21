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


class Modifier extends StatefulWidget {

  final matricule;

  Modifier(this.matricule);
  
  @override
  _ModifierState createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {

  
  TextEditingController emailController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  int valeur = 1;
  String datePremiereTranche = "aucune date";
  String dateDeuxiemeTranche = "aucune date";
  String dateTroisiemeTranche = "aucune date";
  String dateQuatriemeTranche = "aucune date";
  String datePreinscription =  "aucune date";

  final formkey = GlobalKey();
  final scafoldkey = GlobalKey<ScaffoldState>();

  bool preinscription = false;
  bool premiereTranche = false;
  bool deuxiemeTranche = false;
  bool troisiemTranche = false;
  bool quatriemeTranche = false;

  List<Etudiant> _etudiant;

  // id
  String idPreinscription;
  String idPremiereTranche;
  String idDeuxiemeTranche;
  String idTroisiemeTranche;
  String idQuatriemeTranche;
  String cheminImage="http:";

  @override
  void initState(){
    
    super.initState();
    recupererDonnee();
  } 

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
        title: Text("Modifier les informations"),
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
                        enabled: false,
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
                  Row(
                    children: [
                        InkWell(
                          onTap: (){
                           setState(() {
                             montrerPicker(0);
                           });
                          },
                            child: Icon(Icons.calendar_today)
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(datePreinscription),
                      ),
                    ],
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
                        )
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
                    

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primaire ,
                        child: MaterialButton(
                          onPressed: (() => modifier() ),
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("Enregistrer",
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
    
          return Container(
          margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.3,
            child: CircleAvatar(
            radius: 100,
            backgroundImage: new NetworkImage(cheminImage),
          ),
        );
  }

  Future getImage(ImageSource source) async {
    // var nouvelleImage = await ImagePicker.pickImage(source: source);
    // setState(() {
    //   _image = nouvelleImage;
    // });
  }

  void recupererDonnee() async {
    await EtudiantController.getEtudiant(widget.matricule).then((etudiant){

        setState(() {
           _etudiant = etudiant;
             etudiant.forEach((element) {
             emailController.text = element.email;
             nomController.text = element.nom;
             telController.text = element.telephone;
             matriculeController.text = element.matricule;
             classeController.text = element.classe;
             cheminImage = element.photo;
             preinscription = (element.preInscription == "1") ? true : false;
             premiereTranche = (element.un == "1") ? true : false;
             deuxiemeTranche = (element.deux == "1") ? true : false;
             troisiemTranche = (element.trois == "1") ? true : false;
             quatriemeTranche = (element.quatre == "1") ? true : false;
             if(element.niveau =="1"){ valeur =1; }else if(element.niveau =="2"){valeur = 2;}else{valeur = 3;}
             datePremiereTranche = element.unDate;
             datePreinscription = element.preinscriptionDate;
             dateDeuxiemeTranche = element.deuxDate;
             dateTroisiemeTranche = element.troisDate;
             dateQuatriemeTranche = element.quatreDate;
             idPreinscription = element.idPreinscription;
             idPremiereTranche = element.idPremiereTranche;
             idDeuxiemeTranche = element.idDeuxiemeTranche;
             idTroisiemeTranche = element.idTroisiemeTranche;
             idQuatriemeTranche = element.idQuatriemeTranche;

           });
        });
    }); 
  }

  void modifier(){
    FormState formState = formkey.currentState;
    print("ici");
    if(formState.validate()){
      formState.save();

      Etudiant etudiant = new Etudiant();
      Preinscription preInscription = new Preinscription();
      PremiereTranche premiereTRanche = new PremiereTranche();
      DeuxiemeTranche deuxiemeTRanche = new DeuxiemeTranche();
      TroisiemeTranche troisiemeTRanche = new TroisiemeTranche();
      QuatriemeTranche quatriemeTRanche = new QuatriemeTranche();

      etudiant.nom = nomController.text;
      etudiant.email = emailController.text;
      etudiant.telephone = telController.text;
      etudiant.classe = classeController.text;
      etudiant.niveau = valeur.toString();
      etudiant.matricule = matriculeController.text;

      preInscription.datedepayement = datePreinscription.toString();
      preInscription.paye = ((preinscription == true) ? 1 : 0).toString();
      preInscription.id = idPreinscription;

      premiereTRanche.datedepayement = datePremiereTranche.toString();
      premiereTRanche.paye = ((premiereTranche == true) ? 1 : 0).toString();
      premiereTRanche.id = idPremiereTranche;

      deuxiemeTRanche.datedepayement = dateDeuxiemeTranche.toString();
      deuxiemeTRanche.paye = ((deuxiemeTranche == true) ? 1 : 0).toString();
      deuxiemeTRanche.id = idDeuxiemeTranche;

      troisiemeTRanche.datedepayement = dateTroisiemeTranche.toString();
      troisiemeTRanche.paye = ((troisiemTranche == true) ? 1 : 0).toString();
      troisiemeTRanche.id = idTroisiemeTranche;
      
      quatriemeTRanche.datedepayement = dateQuatriemeTranche.toString();
      quatriemeTRanche.paye = ((quatriemeTranche == true) ? 1 : 0).toString();
      quatriemeTRanche.id = idQuatriemeTranche;

      EtudiantController.updateEtudiant(etudiant, preInscription, premiereTRanche, deuxiemeTRanche, troisiemeTRanche, quatriemeTRanche).then((result){

          if(result == "success"){
            modification();
          }else{
            print("erreur");
          }
      });

    }
  }

   Future<Null> modification() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Message"),
            content: Text("Modification réussie"),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
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