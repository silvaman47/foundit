import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? image;
  String? email;
  String? number;
  String? password;

  UserModel({this.name, this.image, this.number, this.email, this.password});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      password: data?['password'],
      image: data?['image'],
      number: data?['number'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (image != null) "image": image,
      if (number != null) "number": number,
      if (password != null) "password": password,
    };
  }
}
