class Etudiant{

  String id;
  String nom;
  String telephone;
  String email;
  String matricule;
  String classe;
  String niveau;
  String photo;
  String preInscription;
  String un;
  String deux;
  String trois;
  String quatre;
  String preinscriptionDate;
  String unDate;
  String deuxDate;
  String troisDate;
  String quatreDate;
  String idPreinscription;
  String idPremiereTranche;
  String idDeuxiemeTranche;
  String idTroisiemeTranche;
  String idQuatriemeTranche;



  Etudiant({this.nom, this.id, this.telephone, this.classe, this.email, this.matricule, this.niveau, this.photo, this.deux,
   this.preInscription, this.quatre, this.trois, this.un, this.preinscriptionDate, this.unDate, this.deuxDate, this.quatreDate, 
   this.troisDate, this.idDeuxiemeTranche, this.idPreinscription, this.idPremiereTranche, this.idQuatriemeTranche, this.idTroisiemeTranche});

  factory Etudiant.formJson(Map<String, dynamic> json){
    return Etudiant(
      id: json['id'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      nom: json['nom'] as String,
      matricule: json['matricule'] as String,
      classe: json['classe'] as String,
      niveau: json['niveau'] as String,
      photo: json['photo'] as String,
      preInscription: json['preInscription'] as String,
      un: json['un'] as String,
      deux: json['deux'] as String,
      trois: json['trois'] as String,
      quatre: json['quatre'] as String,
      preinscriptionDate: json['preinscriptionDate'] as String,
      unDate: json['unDate'] as String,
      deuxDate: json['deuxDate'] as String,
      troisDate: json['troisDate'] as String,
      quatreDate: json['quatreDate'] as String,
      idPreinscription: json['idPreinscription'] as String,
      idPremiereTranche: json['idPremiereTranche'] as String,
      idDeuxiemeTranche: json['idDeuxiemeTranche'] as String,
      idTroisiemeTranche: json['idTroisiemeTranche'] as String,
      idQuatriemeTranche: json['idQuatriemeTranche'] as String,

    );
  }

}