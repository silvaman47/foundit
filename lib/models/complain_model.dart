class Complaint {
  String? user;
  String? description;
  List? finders;
  double? latitude;
  double? longitude;
  String? status;
  DateTime? dateTime;
  String? image;
  String? location;

  Complaint(
      {this.description,
      this.finders,
      this.latitude,
      this.longitude,
      this.status,
      this.user,
      this.dateTime,
      this.location,
      this.image});
}
