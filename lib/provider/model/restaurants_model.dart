class RestaurantsModel {
  String _id;
  String _name;
  String _description;
  String _pictureId;
  String _city;
  dynamic _rating;

  String get id => _id;

  String get name => _name;

  String get description => _description;

  String get pictureId => _pictureId;

  String get city => _city;

  dynamic get rating => _rating;

  RestaurantsModel(
      {String id,
      String name,
      String description,
      String pictureId,
      String city,
      dynamic rating}) {
    _id = id;
    _name = name;
    _description = description;
    _pictureId = pictureId;
    _city = city;
    _rating = rating;
  }
}
