import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iai/Model/DeuxiemeTranche.dart';
import 'package:iai/Model/Etudiant.dart';
import 'package:iai/Model/Preinscription.dart';
import 'package:iai/Model/PremiereTranche.dart';
import 'package:iai/Model/QuatriemeTranche.dart';
import 'package:iai/Model/TroisiemeTranche.dart';

class EtudiantController {
  static const root = 'http://192.168.43.123/Test/create.php';
  static const root2 = 'http://192.168.43.123/Test/insert.php';
  static const root3 = 'http://192.168.43.123/Test/select.php';
  static const root4 = 'http://192.168.43.123/Test/update.php';
  static const upload = 'http://192.168.43.123/Test/upload.php';

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _ADD_ACTION = 'ADD_ACTION';
  static const _ADD_PI_ACTION = 'ADD_PI_ACTION';
  static const _ADD_PT_ACTION = 'ADD_PT_ACTION';
  static const _ADD_DT_ACTION = 'ADD_DT_ACTION';
  static const _ADD_TT_ACTION = 'ADD_TT_ACTION';
  static const _ADD_QT_ACTION = 'ADD_QT_ACTION';
  static const _ADD_ET_ACTION = 'ADD_ET_ACTION';
  static const _GET_ET_ACTION = 'GET_ET_ACTION';
  static const _GET_ALL_ACTION = 'GET_ALL_ACTION';
  static const _CONNEXION = 'CONNEXION';
  static const _UPDATE_ET = 'UPDATE_ET';  

  static Future<String> createTable() async{

    try{
      
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(root, body: map);
      print('Create Table Response: ${response.body}' );
       if(200 == response.statusCode){
          return response.body;
       }else{
        return "erreur";
       }
    }catch(e){
      return "erreur ici";
    }
  }

  Future<String> add(Etudiant etudiant, Preinscription preinscription, PremiereTranche premiereTranche,
   DeuxiemeTranche deuxiemeTranche, TroisiemeTranche troisiemeTranche, QuatriemeTranche quatriemeTranche) async {

      try{
        var map = Map<String, dynamic>();
        map['action'] = _ADD_ACTION;
        map['datepayementPreinscription'] = preinscription.datedepayement; 
        map['payePreinscription'] = preinscription.paye;

        map['datepayementPremiereTranche'] = premiereTranche.datedepayement; 
        map['payePremiereTranche'] = premiereTranche.paye;

        map['datepayementDeuxiemeTranche'] = deuxiemeTranche.datedepayement; 
        map['payeDeuxiemeTranche'] = deuxiemeTranche.paye;

        map['datepayementTroisiemeTranche'] = troisiemeTranche.datedepayement; 
        map['payeTroisiemeTranche'] = troisiemeTranche.paye;
        
        map['datepayementQuatriemeTranche'] = quatriemeTranche.datedepayement; 
        map['payeQuatriemeTranche'] = quatriemeTranche.paye;

        map['photo'] = etudiant.photo;  
        map['nom'] = etudiant.nom;
        map['matricule'] = etudiant.matricule;
        map['email'] = etudiant.email;
        map['telephone'] = etudiant.telephone;
        map['classe'] = etudiant.classe;
        map['niveau'] = etudiant.niveau;
        print('ii');

        final response = await http.post(root2, body: map);
        print('Ajoutée préinscription: ${response.body}' );
        
        if(200 == response.statusCode){
          return response.body;
        }else{
          return "erreur ici";
        }
    }catch(e){
      return "erreur";
    }

   } 



  //   Future<String> addPreinscription(Preinscription preinscription) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_PI_ACTION;
  //       map['datepayement'] = preinscription.datedepayement; 
  //       map['paye'] = preinscription.paye;
  //       final response = await http.post(root2, body: map);
  //       print('Ajoutée préinscription: ${response.body}' );
        
  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }

  //   Future<String> addPremiereTranche(PremiereTranche premiereTranche) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_PT_ACTION;
  //       map['datepayement'] = premiereTranche.datedepayement; 
  //       map['paye'] = premiereTranche.paye;
  //       final response = await http.post(root2, body: map);
  //       print('Ajouté première tranche: ${response.body}' );

  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }

  
  //   Future<String> addDeuxiemeTranche(DeuxiemeTranche deuxiemeTranche) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_DT_ACTION;
  //       map['datepayement'] = deuxiemeTranche.datedepayement; 
  //       map['paye'] = deuxiemeTranche.paye;
  //       final response = await http.post(root2, body: map);
  //       print('Ajouté deuxième tranche: ${response.body}' );

  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }

    
  //   Future<String> addTroisiemeTranche(TroisiemeTranche troisiemeTranche) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_TT_ACTION;
  //       map['datepayement'] = troisiemeTranche.datedepayement; 
  //       map['paye'] = troisiemeTranche.paye;
  //       final response = await http.post(root2, body: map);
  //       print('Ajouté troisième tranche: ${response.body}' );

  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }

  //     Future<String> addQuatriemeTranche(QuatriemeTranche quatriemeTranche) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_QT_ACTION;
  //       map['datepayement'] = quatriemeTranche.datedepayement; 
  //       map['paye'] = quatriemeTranche.paye;
  //       final response = await http.post(root2, body: map);
  //       print('Ajouté quatrième tranche: ${response.body}' );

  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }

  //   Future<String> addEtudiant(Etudiant etudiant) async {

  //   try{
  //       var map = Map<String, dynamic>();
  //       map['action'] = _ADD_ET_ACTION;
  //       map['photo'] = etudiant.photo;  
  //       map['nom'] = etudiant.nom;
  //       map['matricule'] = etudiant.matricule;
  //       map['email'] = etudiant.email;
  //       map['telephone'] = etudiant.telephone;
  //       map['classe'] = etudiant.classe;
  //       map['niveau'] = etudiant.niveau;

  //       final response = await http.post(root2, body: map);
  //       print('Etudiant ajouté: ${response.body}' );

  //       if(200 == response.statusCode){
  //         return response.body;
  //       }else{
  //         return "erreur ici";
  //       }
  //   }catch(e){
  //     return "erreur la";
  //   }

  // }


  static Future<List<Etudiant>> getEtudiant(String matricule) async {

    try{
        var map = Map<String, dynamic>();
        map['action'] = _GET_ET_ACTION;
        map['matricule'] = matricule; 
        // print(matricule);
        final response = await http.post(root3, body: map);
        print('récupérér étudiant: ${response.body}' );

        if(200 == response.statusCode){
          List<Etudiant> list = parseResponse(response.body);
          
          return list;
        }else{
          return List<Etudiant>();
        }
    }catch(e){
      return List<Etudiant>();
    }
  }

  static Future<List<Etudiant>> getAllEtudiant() async {

    try{
        var map = Map<String, dynamic>();
        map['action'] = _GET_ALL_ACTION;
        final response = await http.post(root3, body: map);
        // print('récupérér étudiant: ${response.body}' );

        if(200 == response.statusCode){
          List<Etudiant> list = parseResponse(response.body);
          
          return list;
        }else{
          return List<Etudiant>();
        }
    }catch(e){
      return List<Etudiant>();
    }
  }

  static Future<String> connexion(String numero, String pass) async {

    try{
        var map = Map<String, dynamic>();
        map['action'] = _CONNEXION;
        map['numero'] = numero; 
        map['pass'] = pass; 
        final response = await http.post(root3, body: map);
        // print('récupérér étudiant: ${response.body}' );
        if(200 == response.statusCode){
          return response.body;
        }else{
          return "erreur";
        }
    }catch(e){
      return "connexion";
    }
  }

  static Future<String> reseau() async {
    try{
      final response = await http.post(root3);
      if(200 == response.statusCode){
        return "connecter";
      }else{
        return "instable";
      }
    }catch(e){
      return "erreur";
    }
  }

  static List<Etudiant> parseResponse(String responseBody){
    
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Etudiant>((json) => Etudiant.formJson(json)).toList();
  }

   static Future<String> updateEtudiant(Etudiant etudiant, Preinscription preinscription, PremiereTranche premiereTranche,
   DeuxiemeTranche deuxiemeTranche, TroisiemeTranche troisiemeTranche, QuatriemeTranche quatriemeTranche) async {

    try{
        var map = Map<String, dynamic>();
        map['action'] = _UPDATE_ET;
        // map['photo'] = etudiant.photo;  
        map['nom'] = etudiant.nom;
        map['matricule'] = etudiant.matricule;
        map['email'] = etudiant.email;
        map['telephone'] = etudiant.telephone;
        map['classe'] = etudiant.classe;
        map['niveau'] = etudiant.niveau;

        print(etudiant.nom);
        print(etudiant.matricule);
        print(etudiant.email);
        print(etudiant.telephone);
        print(etudiant.classe);
        print(etudiant.niveau);

        
        map['idPreinscription'] = preinscription.id;
        map['preinscriptionDate'] = preinscription.datedepayement;
        map['PreinscriptionPaye'] = preinscription.paye;

        
        map['idPremiereTranche'] = premiereTranche.id;
        map['premiereTrancheDate'] = premiereTranche.datedepayement;
        map['premiereTranchePaye'] = premiereTranche.paye;  

        
        map['idDeuxiemeTranche'] = deuxiemeTranche.id;
        map['deuxiemeTrancheDate'] = deuxiemeTranche.datedepayement;
        map['deuxiemeTranchePaye'] = deuxiemeTranche.paye;

        
        map['idTroisiemeTranche'] = troisiemeTranche.id;
        map['troisiemeTrancheDate'] = troisiemeTranche.datedepayement;
        map['troisiemeTranchePaye'] = troisiemeTranche.paye;

        
        map['idQuatriemeTranche'] = quatriemeTranche.id;
        map['quatriemeTrancheDate'] = quatriemeTranche.datedepayement;
        map['quatriemeTranchePaye'] = quatriemeTranche.paye;  

        final response = await http.post(root4, body: map);
        print('étudiant modifié: ${response.body}' );

        if(200 == response.statusCode){
          return response.body;
        }else{
          return "erreur";
        }
    }catch(e){
      return "connexion";
    }

  }

  Future<void> uploadImage(File uploadimage ) async {
    print("here");
    try{
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      var response = await http.post(
              upload, 
              body: {
                 'image': baseimage,
              }
      );
      if(response.statusCode == 200){
         var jsondata = json.decode(response.body); //decode json data
         if(jsondata["error"]){ //check error sent from server
             print(jsondata["msg"]);
             //if error return from server, show message from server
         }else{
             print("Upload successful");
         }
      }else{
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    }catch(e){
       print("Error during converting to Base64");
       //there is error during converting file image to base64 encoding. 
    }
  }

} 
