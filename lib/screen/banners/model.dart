class BannerModel {
  final String id;
  final String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromMap(String id, Map<String, dynamic> map) {
    return BannerModel(
      id: id,
      image: map['image'] ?? '',
    );
  }
}