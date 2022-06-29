import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

final _firestore = FirebaseFirestore.instance;

final _fireStore = FirebaseFirestore.instance;
final controller = TextEditingController();

class _UserProfileState extends State<UserProfile> {
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
                  final user = User(
                      name: controllerName.text,
                      age: int.parse(controllerAge.text),
                      email: controllerEmail.text);
                  createUser(user);
                  Navigator.pop(context);
                },
                child: Text("Oluştur"))
          ],
        ),
      );
  Stream<List<User>>readUsers()=>FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>snapshot.docs.map((doc) =>User.fromJson (doc.data()) ).toList());
  Future createUser(User user) async {
    ///reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email);
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
  Map< String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'email': email,
      };
  static User fromJson(Map<String,dynamic>json)=>User(name: json['name'], age: json['age'], email: json['email']);
}
