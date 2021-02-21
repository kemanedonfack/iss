class TroisiemeTranche{

  String id;
  String datedepayement;
  String paye;

  
  TroisiemeTranche({this.datedepayement, this.id, this.paye});

  factory TroisiemeTranche.formJson(Map<String, dynamic> json){
    return TroisiemeTranche(
      id: json['id'] as String,
      datedepayement: json['datedepayement'] as String,
      paye: json['paye'] as String,
      
    );
  }
}
