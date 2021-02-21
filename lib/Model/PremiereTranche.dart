
class PremiereTranche{

  String id;
  String datedepayement;
  String paye;

  
  PremiereTranche({this.datedepayement, this.id, this.paye});

  factory PremiereTranche.formJson(Map<String, dynamic> json){
    return PremiereTranche(
      id: json['id'] as String,
      datedepayement: json['datedepayement'] as String,
      paye: json['paye'] as String,

    );
  }
}