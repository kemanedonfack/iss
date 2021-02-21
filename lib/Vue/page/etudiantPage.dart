import 'package:flutter/material.dart';
import 'package:iai/Controller/EtudianController.dart';
import 'package:iai/Model/Etudiant.dart';
import 'package:iai/Vue/page/aucun.dart';
import 'package:iai/Vue/utile/couleur.dart';

class EtudiantPage extends StatefulWidget {
 
  final matricule;

  EtudiantPage(this.matricule);

  @override
  _EtudiantPageState createState() => _EtudiantPageState();
}

class _EtudiantPageState extends State<EtudiantPage> {

  List<Etudiant> _etudiant;

  @override void initState() {
    super.initState();
    print(widget.matricule);
    _etudiant = [];
    recupererEtudiant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (() => Navigator.pop(context) ),
            child: Icon(Icons.arrow_back_ios, color: Colors.white)
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: _etudiant.map((e) =>
              Column(
              children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: primaire,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                            radius: 82,
                            backgroundImage: NetworkImage(e.photo),
                        ),
                          ),
                        ),
                        
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: Text(e.nom, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                            ),))
                          ],
                        ),
                      ),
                      
                      Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(e.matricule, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),))
                        ],
                  ),
                ),
                      ],
                    ),
                  ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [              
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("Email : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      Flexible(child: Text(e.email, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 16)))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("Téléphone : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      Flexible(child: Text(e.telephone , style: TextStyle(color: Colors.black, fontSize: 16),))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("Classe : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      Flexible(child: Text(e.classe , style: TextStyle(color: Colors.black, fontSize: 16),))
                    ],
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

                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Text("préinscription : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      (e.preInscription == "1") ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.close_sharp , color: Colors.red,),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("1ère Tranche : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      (e.un == "1") ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.close_sharp , color: Colors.red,),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("2ème Tranche : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      (e.deux == "1") ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.close_sharp , color: Colors.red,),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("3ème Tranche : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                      (e.trois == "1") ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.close_sharp , color: Colors.red,),
                    ],
                  ),
                ),
                (e.niveau == "3") ?
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Text("4ème Tranche : ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                     (e.quatre == "1") ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.close_sharp , color: Colors.red,),
                    ],
                  ),
                )
                :
                Container(

                ),
                    ],
                  ),
                ),
                
                
              ],
            ),
            ).toList(),
          ),
      ),
    );
  }

   recupererEtudiant() {
    
    // EtudiantController etudiantController = EtudiantController();

       EtudiantController.getEtudiant(widget.matricule).then((etudiant){
         if(etudiant.length > 0){   
          setState(() {
            _etudiant = etudiant;
          });  
         }else{
           Navigator.push(context, MaterialPageRoute(builder: (context) => Aucune(widget.matricule) ));
         }      
    });
  }
}