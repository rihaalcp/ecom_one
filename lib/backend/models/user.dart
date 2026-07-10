class User{
  String? id;
  String name;
  String email;
  String phone;
  String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String,dynamic> toJson(){
    return{
      "name":name,
      "email":email,
      "phone":phone,
      "password":password
    };
  }

}