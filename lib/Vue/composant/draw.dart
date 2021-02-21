import 'package:flutter/material.dart';
import 'package:iai/Vue/page/home.dart';
import 'package:iai/vue/page/admin.dart';
import 'package:iai/vue/page/compte.dart';
import 'package:iai/vue/page/enregistrer.dart';
import 'package:iai/vue/utile/couleur.dart';

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("kemane donfack"),
            accountEmail: Text("kemanedonfack5@gmail.com"),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person),
              ),
            ),
            decoration: new BoxDecoration(
              color: primaire,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Admin() ));
            } ,
            child: ListTile(
              title: Text("Modifier"),
              leading: Icon(Icons.edit, color: primaire,),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Enregistrer() ));
            } ,
            child: ListTile(
              title: Text("Ajouter étudiant"),
              leading: Icon(Icons.person_add , color: primaire,),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Compte() ));
            } ,
            child: ListTile(
              title: Text("Mon compte"),
              leading: Icon(Icons.account_circle, color: primaire,),
            ),
          ),
          
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home() ));
            } ,
            child: ListTile(
              title: Text("Déconnexion"),
                leading: Icon(Icons.call_received ),
            ),
          ),
        ],
      ),
    );
  }
}
