import 'package:flutter/material.dart';

class Aucune extends StatefulWidget {

  
  final matricule;

  Aucune(this.matricule);

  @override
  _AucuneState createState() => _AucuneState();
}

class _AucuneState extends State<Aucune> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context); Navigator.pop(context); },
        ),
      ),
      body: Center(
        child: Text("Aucune correspondance pour : $widget.matricule "),
      ),
    );
  }
}
