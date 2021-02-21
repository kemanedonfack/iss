
class Preinscription{

  String id;
  String datedepayement;
  String paye;

  
  Preinscription({this.datedepayement, this.id, this.paye});

  factory Preinscription.formJson(Map<String, dynamic> json){
    return Preinscription(
      id: json['id'] as String,
      datedepayement: json['datedepayement'] as String,
      paye: json['paye'] as String,
      
    );
  }
}