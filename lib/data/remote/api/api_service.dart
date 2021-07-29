import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/remote/model/details_restaurants_response.dart';
import 'package:restaurant_app/data/remote/model/restaurants_response.dart';

class ApiService {
  static final String _baseUrl = "restaurant-api.dicoding.dev";

  Future<RestaurantsResponse> listRestaurants(http.Client client) async {
    var endPoint = Uri.https(_baseUrl, "/list");
    final response = await client.get(endPoint);

    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Data');
    }
  }

  Future<RestaurantsResponse> listRestaurantsNotification() async {
    var endPoint = Uri.https(_baseUrl, "/list");
    final response = await http.get(endPoint);

    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Data');
    }
  }

  Future<DetailsRestaurantsResponse> detailRestaurants(http.Client client, String id) async {
    var endPoint = Uri.https(_baseUrl, '/detail/$id');
    final response = await http.get(endPoint);

    if (response.statusCode == 200) {
      return DetailsRestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Data');
    }
  }

  Future<RestaurantsResponse> searchRestaurants(http.Client client, String query) async {
    var endPoint = Uri.https(_baseUrl, "/search", {"q" : query});
    final response = await http.get(endPoint);

    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Data');
    }
  }
}
