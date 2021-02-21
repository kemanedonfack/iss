class QuatriemeTranche{

  String id;
  String datedepayement;
  String paye;

  
  QuatriemeTranche({this.datedepayement, this.id, this.paye});

  factory QuatriemeTranche.formJson(Map<String, dynamic> json){
    return QuatriemeTranche(
      id: json['id'] as String,
      datedepayement: json['datedepayement'] as String,
      paye: json['paye'] as String,
    );
  }
}