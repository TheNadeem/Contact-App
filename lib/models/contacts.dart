class Contacts {
  int? id;
  late String name;
  late String email;
  late int number;

  Contacts({
    this.id,
    required this.name,
    required this.email,
    required this.number,
  });


Map<String ,dynamic> toMap(){
  return {
    'id':id,
    'name':name,
    'email':email,
    'number':number,
  };
}

Contacts.fromMap(Map<String ,dynamic>map){
  id=map['id'];
  name=map['name'];
  email=map['email'];
  number=map['number'];

}

}
