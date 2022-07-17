class Complaint {
  String? user;
  String? description;
  List? finders;
  double? latitude;
  double? longitude;
  String? status;
  String? time;
  String? image;

  Complaint(
      {this.description,
      this.finders,
      this.latitude,
      this.longitude,
      this.status,
      this.user,
      this.time,
      this.image});
}
