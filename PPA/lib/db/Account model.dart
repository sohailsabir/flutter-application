class ModelUser{
  int? id;
  String? email;
  String? pass;
  String? question;
  // ModelPass({ this.title, this.pass});
  // Map<String,dynamic>toMap(){
  //   return ({
  //     'id':id,
  //     'title':title,
  //     'pass':pass
  //   });
  // }
  UserMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id??null;
    mapping['username']=email!;
    mapping['pass']=pass!;
    mapping['question']=question!;
    return mapping;

  }
}