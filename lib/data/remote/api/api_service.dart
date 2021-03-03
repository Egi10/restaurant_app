import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/remote/model/details_restaurants_response.dart';
import 'package:restaurant_app/data/remote/model/restaurants_response.dart';

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

  Future<RestaurantsResponse> searchRestaurants(String query) async {
    final response = await http.get(_baseUrl + "/search?q=$query");

    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw 'Failed Load Data ${response.statusCode}';
    }
  }
}
