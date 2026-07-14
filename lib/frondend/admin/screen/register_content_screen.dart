import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterContentPage extends StatefulWidget {

const RegisterContentPage({super.key});


@override
State<RegisterContentPage> createState()
=> _RegisterContentPageState();

}



class _RegisterContentPageState
extends State<RegisterContentPage>{


final Map<String,TextEditingController> c={};



final fields=[

"title",
"subtitle",

"fullNameLabel",
"fullNameHint",

"emailLabel",
"emailHint",

"phoneLabel",
"phoneHint",

"passwordLabel",
"passwordHint",

"confirmPasswordLabel",
"confirmPasswordHint",

"googleLabel",
"googleHint",

"appleLabel",
"appleHint",

"buttonText"

];



@override
void initState(){

super.initState();


for(var f in fields){

c[f]=TextEditingController();

}


loadData();

}



Future loadData() async{


final res=await http.get(
Uri.parse(
"http://localhost:5000/admin/page/get-register-page"
)
);


final data=jsonDecode(res.body);



for(var f in fields){

c[f]!.text=data[f] ?? "";

}


setState((){});


}





Future save() async{


final body={};


for(var f in fields){

body[f]=c[f]!.text;

}


await http.post(

Uri.parse(
"http://localhost:5000/admin/page/save-register-page"
),

headers:{
"content-type":"application/json"
},

body:jsonEncode(body)

);


ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content:Text("Saved Successfully")
)
);


}




@override
Widget build(BuildContext context){


return Scaffold(

appBar:AppBar(
title:const Text(
"Register CMS"
),
),


body:ListView(

padding:const EdgeInsets.all(20),


children:[


...fields.map(
(f)=>Padding(

padding:
const EdgeInsets.only(bottom:15),

child:TextField(

controller:c[f],

decoration:
InputDecoration(

labelText:f,

border:
const OutlineInputBorder()

),

),

)

),



ElevatedButton(

onPressed:save,

child:
const Text(
"Save"
)

)



],


),


);


}



}