import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icha_store/userProfile.dart';

class UserPage extends StatefulWidget {

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller=TextEditingController();
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(
      title: Text('Kullanıcılar'),
    ),
    body: StreamBuilder<List<User>>(
      stream: readUsers(),
      builder: (context,snapshot){
        if (snapshot.hasError){
       return Text('Something went wrong! ${snapshot.error}');
        }
        else if (snapshot.hasData){ final users=snapshot.data!;
        return ListView(
          children: users.map(buildUser).toList(),
        );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  Widget buildUser(User user)=>ListTile(
    leading: CircleAvatar(child: Text('${user.age}')),
    title: Text(user.name),
    subtitle: Text(user.email),

  );
  Stream<List<User>>readUsers()=>FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>snapshot.docs.map((doc) =>User.fromJson (doc.data()) ).toList());
  Future createUser(User user) async {
    ///reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = user.toJson();
    user.id=docUser.id;
    ///Doküment kurma ve datayı Firebaseye yazma
    await docUser.set(json);
  }
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
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'email': email,
  };
  static User fromJson(Map<String,dynamic>json)=>User(name: json['name'], age: json['age'], email: json['email']);
}
