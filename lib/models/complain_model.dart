import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  String? idowner;
  String? description;
  String? ownernum;
  double? latitude;
  double? longitude;
  String? status;
  DateTime? dateTime;
  String? image;
  String? location;

  Complaint(
      {this.description,
      this.ownernum,
      this.latitude,
      this.longitude,
      this.status,
      this.idowner,
      this.dateTime,
      this.location,
      this.image});

       factory Complaint.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Complaint(
      idowner: data?['idowner'],
      description: data?['description'],
      status: data?['status'],
      location: data?['location'],
      image: data?['image'],
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      dateTime: data?['dateTime'],
      ownernum: data?['ownernum'],
      
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (idowner != null) "idowner": idowner,
      if (image != null) "image": image,
      if (location != null) "location": location,
      if (ownernum != null) "ownernum": ownernum,
      if (status != null) "status": status,
      if (description != null) "description": description,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
      if (dateTime != null) "dateTime": dateTime, 
    };
  }
}
