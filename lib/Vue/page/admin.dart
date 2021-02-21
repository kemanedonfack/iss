import 'package:flutter/material.dart';
import 'package:iai/Controller/EtudianController.dart';
import 'package:iai/Model/Etudiant.dart';
import 'package:iai/Vue/page/etudiantPage.dart';
import 'package:iai/Vue/page/modifier.dart';
import 'package:iai/vue/composant/draw.dart';
import 'package:iai/vue/utile/couleur.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  
  TextEditingController rechercheController = TextEditingController();
  List<Etudiant> _etudiant = [];

  final GlobalKey<RefreshIndicatorState> _refreshkey = new GlobalKey<RefreshIndicatorState>();
  @override 
  initState() {
    super.initState();
    recupererTousEtudiant();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshkey,
      onRefresh: () async{
        await recupererTousEtudiant();
      },
          child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Draw(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.arrow_back_ios, color: Colors.black,)
          ),
          title: Material(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.withOpacity(0.2),
            child: TextFormField(
              controller: rechercheController,
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0,),
                  child: Icon(Icons.search, color: Colors.grey,),
                ),
                border: InputBorder.none,
                hintText: "Nom ...",
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
          centerTitle: true,
          actions: [
            InkWell(
                child: Builder(
                    builder: (BuildContext context){
                      return IconButton(
                        color: Colors.black,
                          icon: Icon(Icons.menu, size: 30),
                          onPressed: ()  {
                            Scaffold.of(context).openDrawer();
                          }
                      );
                    }
                ),
            ),
          ],
          elevation: 0.0,
        ),

        body: Container(
          child: ListView.builder(
            itemCount: _etudiant.length,
            itemBuilder: (BuildContext context, int index){
                return ListTile(
                  onTap: (){
                    // print(_etudiant[index].matricule);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EtudiantPage(_etudiant[index].matricule) ));
                  },
                    leading: CircleAvatar(
                    backgroundImage: NetworkImage(_etudiant[index].photo),
                    radius: 30,
                  ),
                title: Text(_etudiant[index].nom),
                subtitle: Text(_etudiant[index].classe, style: TextStyle(color: primaire, fontSize: 13),),
                trailing: IconButton(icon: Icon(Icons.edit), onPressed: (() => 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Modifier(_etudiant[index].matricule) )) ), 
                )
                );
              }
            ),
        ),
      ),
    );
  }

  recupererTousEtudiant() {
       EtudiantController.getAllEtudiant().then((etudiant){
        setState(() {
           _etudiant = etudiant;
        });        
    });
  }
}
