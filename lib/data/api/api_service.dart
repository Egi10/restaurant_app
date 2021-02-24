import 'dart:convert';
import 'package:restaurant_app/data/model/details_restaurants_response.dart';
import 'package:restaurant_app/data/model/restaurants_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantsResponse> listRestaurants() async {
    final response = await http.get(_baseUrl + "list");

    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw 'Failed Load Data';
    }
  }

  Future<DetailsRestaurantsResponse> detailRestaurants(String id) async {
    final response = await http.get(_baseUrl + "detail/" + id);

    if (response.statusCode == 200) {
      return DetailsRestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw 'Failed Load Data';
    }
  }
}
