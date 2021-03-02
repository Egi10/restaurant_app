class DetailsRestaurantsResponse {
  bool _error;
  String _message;
  Restaurant _restaurant;

  bool get error => _error;
  String get message => _message;
  Restaurant get restaurant => _restaurant;

  DetailsRestaurantsResponse({
      bool error, 
      String message, 
      Restaurant restaurant}){
    _error = error;
    _message = message;
    _restaurant = restaurant;
}

  DetailsRestaurantsResponse.fromJson(dynamic json) {
    _error = json["error"];
    _message = json["message"];
    _restaurant = json["restaurant"] != null ? Restaurant.fromJson(json["restaurant"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = _error;
    map["message"] = _message;
    if (_restaurant != null) {
      map["restaurant"] = _restaurant.toJson();
    }
    return map;
  }

}

class Restaurant {
  String _id;
  String _name;
  String _description;
  String _city;
  String _address;
  String _pictureId;
  List<Categories> _categories;
  Menus _menus;
  dynamic _rating;
  List<CustomerReviews> _customerReviews;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get city => _city;
  String get address => _address;
  String get pictureId => _pictureId;
  List<Categories> get categories => _categories;
  Menus get menus => _menus;
  dynamic get rating => _rating;
  List<CustomerReviews> get customerReviews => _customerReviews;

  Restaurant({
      String id, 
      String name, 
      String description, 
      String city, 
      String address, 
      String pictureId, 
      List<Categories> categories, 
      Menus menus, 
      dynamic rating,
      List<CustomerReviews> customerReviews}){
    _id = id;
    _name = name;
    _description = description;
    _city = city;
    _address = address;
    _pictureId = pictureId;
    _categories = categories;
    _menus = menus;
    _rating = rating;
    _customerReviews = customerReviews;
}

  Restaurant.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _city = json["city"];
    _address = json["address"];
    _pictureId = json["pictureId"];
    if (json["categories"] != null) {
      _categories = [];
      json["categories"].forEach((v) {
        _categories.add(Categories.fromJson(v));
      });
    }
    _menus = json["menus"] != null ? Menus.fromJson(json["menus"]) : null;
    _rating = json["rating"];
    if (json["customerReviews"] != null) {
      _customerReviews = [];
      json["customerReviews"].forEach((v) {
        _customerReviews.add(CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["city"] = _city;
    map["address"] = _address;
    map["pictureId"] = _pictureId;
    if (_categories != null) {
      map["categories"] = _categories.map((v) => v.toJson()).toList();
    }
    if (_menus != null) {
      map["menus"] = _menus.toJson();
    }
    map["rating"] = _rating;
    if (_customerReviews != null) {
      map["customerReviews"] = _customerReviews.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Ahmad"
/// review : "Tidak rekomendasi untuk pelajar!"
/// date : "13 November 2019"

class CustomerReviews {
  String _name;
  String _review;
  String _date;

  String get name => _name;
  String get review => _review;
  String get date => _date;

  CustomerReviews({
      String name, 
      String review, 
      String date}){
    _name = name;
    _review = review;
    _date = date;
}

  CustomerReviews.fromJson(dynamic json) {
    _name = json["name"];
    _review = json["review"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["review"] = _review;
    map["date"] = _date;
    return map;
  }

}

/// foods : [{"name":"Paket rosemary"},{"name":"Toastie salmon"}]
/// drinks : [{"name":"Es krim"},{"name":"Sirup"}]

class Menus {
  List<Foods> _foods;
  List<Drinks> _drinks;

  List<Foods> get foods => _foods;
  List<Drinks> get drinks => _drinks;

  Menus({
      List<Foods> foods, 
      List<Drinks> drinks}){
    _foods = foods;
    _drinks = drinks;
}

  Menus.fromJson(dynamic json) {
    if (json["foods"] != null) {
      _foods = [];
      json["foods"].forEach((v) {
        _foods.add(Foods.fromJson(v));
      });
    }
    if (json["drinks"] != null) {
      _drinks = [];
      json["drinks"].forEach((v) {
        _drinks.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_foods != null) {
      map["foods"] = _foods.map((v) => v.toJson()).toList();
    }
    if (_drinks != null) {
      map["drinks"] = _drinks.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Es krim"

class Drinks {
  String _name;

  String get name => _name;

  Drinks({
      String name}){
    _name = name;
}

  Drinks.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}

/// name : "Paket rosemary"

class Foods {
  String _name;

  String get name => _name;

  Foods({
      String name}){
    _name = name;
}

  Foods.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}

/// name : "Italia"

class Categories {
  String _name;

  String get name => _name;

  Categories({
      String name}){
    _name = name;
}

  Categories.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}