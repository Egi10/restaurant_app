class RestaurantsResponse {
  bool _error;
  String _message;
  int _count;
  List<Restaurants> _restaurants;

  bool get error => _error;

  String get message => _message;

  int get count => _count;

  List<Restaurants> get restaurants => _restaurants;

  RestaurantsResponse(
      {bool error, String message, int count, List<Restaurants> restaurants}) {
    _error = error;
    _message = message;
    _count = count;
    _restaurants = restaurants;
  }

  RestaurantsResponse.fromJson(dynamic json) {
    _error = json["error"];
    _message = json["message"];
    _count = json["count"];
    if (json["restaurants"] != null) {
      _restaurants = [];
      json["restaurants"].forEach((v) {
        _restaurants.add(Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = _error;
    map["message"] = _message;
    map["count"] = _count;
    if (_restaurants != null) {
      map["restaurants"] = _restaurants.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Restaurants {
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

  Restaurants(
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

  Restaurants.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _pictureId = json["pictureId"];
    _city = json["city"];
    _rating = json["rating"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["pictureId"] = _pictureId;
    map["city"] = _city;
    map["rating"] = _rating;
    return map;
  }
}
