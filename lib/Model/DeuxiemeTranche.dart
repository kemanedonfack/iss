
class DeuxiemeTranche{

  String id;
  String datedepayement;
  String paye;

  
  DeuxiemeTranche({this.datedepayement, this.id, this.paye});

  factory DeuxiemeTranche.formJson(Map<String, dynamic> json){
    return DeuxiemeTranche(
      id: json['id'] as String,
      datedepayement: json['datedepayement'] as String,
      paye: json['paye'] as String,
      
    );
  }
}