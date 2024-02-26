class AssociationKinds {
  AssociationKinds({
    required this.kinds,
    });
  
  late final List<String> kinds;

  AssociationKinds.fromJSON(Map<String, dynamic> json){
      kinds = json['kinds'];
      }
  
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'kinds': kinds,
    };
    return data;
  }

  AssociationKinds empty(){
    return AssociationKinds(kinds: []);
  }
}