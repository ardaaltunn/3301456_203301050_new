import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserUpdate extends StatefulWidget {
  const UserUpdate({Key? key}) : super(key: key);

  @override
  State<UserUpdate> createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Kullanıcı ekle'),
    ),

    body: ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: controllerName,
          decoration: InputDecoration(hintText: 'name'),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: controllerAge,
          decoration: InputDecoration(
            hintText: 'age',
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controllerEmail,
          decoration: InputDecoration(hintText: 'email'),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
            onPressed: () {
              final userData = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email);
              userData.update({
                "name" : controllerName.text,
                "email" : controllerEmail.text,
                "age" : int.parse(controllerAge.text ,
                ),});
              Navigator.pop(context);
            },
            child: Text("Güncelle"))
      ],
    ),
  );
}
Future createUser(User user) async {
  ///reference to document
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  final json = user.toJson();
  user.id=docUser.id;
  ///Doküment kurma ve datayı Firebaseye yazma
  await docUser.set(json);
}

class User {
  String id;
  final String name;
  final int age;
  final String email;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.email,
  });
  Map< String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'email': email,
  };
  static User fromJson(Map<String,dynamic>json)=>User(name: json['name'], age: json['age'], email: json['email']);
}
