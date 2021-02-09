import 'dart:convert';
import 'dart:developer';

class RestaurantsResponse {
  List<Restaurants> restaurants;

  RestaurantsResponse({this.restaurants});

  RestaurantsResponse.fromJson(dynamic json) {
    if (json["restaurants"] != null) {
      restaurants = [];
      json["restaurants"].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
        log('data Dini: ${json[restaurants]}');
      });
    } else {
      restaurants = [];
    }
  }
}

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  Restaurants.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"];
  }
}

RestaurantsResponse parseRestaurant(String json) {
  var parsed = jsonDecode(json);
  var restaurant = RestaurantsResponse.fromJson(parsed);
  log('data2: ${restaurant.restaurants[0]}');

  return RestaurantsResponse.fromJson(parsed);
}
