import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? image;
  List? complaints;
  String? location;

  UserModel (
    {
      this.name,
      this.image,
      this.location,
      this.complaints,
  });
  


  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      image: data?['image'],
      location: data?['location'],
      complaints: data?['complaints'] is Iterable ? List.from(data?['complaints']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (image != null) "image": image,
      if (location != null) "location": location,
      if (complaints != null) "complaints": complaints,
    };
  }

}
