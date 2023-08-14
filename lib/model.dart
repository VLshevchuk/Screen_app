class Model {
  final String user;
  final String photo;
  Model({required this.user, required this.photo});
  factory Model.fromJson(Map<String, dynamic> json) {
  return Model(
    user: json['user'] ['username'],
    photo: json['urls']['small']
  );
  }
}
