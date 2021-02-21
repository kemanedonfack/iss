import 'package:flutter/material.dart';
import 'package:iai/vue/composant/draw.dart';
import 'package:iai/vue/utile/couleur.dart';

class Compte extends StatefulWidget {
  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Draw(),
      appBar: AppBar(
        backgroundColor: primaire,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,), onPressed: Navigator.of(context).pop ),
        title: Text("Compte"),
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            onTap: Navigator.of(context).pop,
            child: Padding(
              padding: EdgeInsets.only(left: 0,),
              child: Builder(
                  builder: (BuildContext context){
                    return IconButton(
                        icon: Icon(Icons.menu, size: 30),
                        onPressed: ()  {
                          Scaffold.of(context).openDrawer();
                        }
                    );
                  }
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage("images/avatar.jpg"),
                    ),
                  ),
                  Positioned(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primaire
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 20,),
                        )
                    ),
                    bottom: 50,
                  ),
                ],
              ),
            ),
            Center(
                child: Text("Kemane Donfack",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
            ),
            Padding(
              padding : EdgeInsets.only(left: 5, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10),
                      child: Text("kemanedonfack5@gmail.com", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),),
                    ),
                    trailing: Icon(Icons.edit, color: primaire),
                  ),
                  ListTile(
                    title: Text("Téléphone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10),
                      child: Text("+237 690 710 856", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),),
                    ),
                    trailing: Icon(Icons.edit, color: primaire),
                  ),
                  ListTile(
                    title: Text("Mot de passe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10),
                      child: Text("**********", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),),
                    ),
                    trailing: Icon(Icons.edit, color: primaire),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
