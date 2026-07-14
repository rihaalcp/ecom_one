class User{
  String? id;
  String name;
  String email;
  String phone;
  String password;
  String role;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
  });

  Map<String,dynamic> toJson(){
    return{
      "name":name,
      "email":email,
      "phone":phone,
      "password":password,
      "role":"user"
    };
  }

}