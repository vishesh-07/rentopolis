class HouseModel {
  late final String about;
  late final String address;
  late final int area;
  late final int bathroom;
  late final int bedroom;
  late final int houseid;
  late final List<dynamic> images;
  late final String name;
  late final int rent;
  late final String uid;
  late final List<dynamic> latilong;
  HouseModel(
      {required this.about,
      required this.address,
      required this.area,
      required this.bathroom,
      required this.bedroom,
      required this.houseid,
      required this.images,
      required this.name,
      required this.rent,
      required this.uid,
      required this.latilong});
}
