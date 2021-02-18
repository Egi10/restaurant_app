import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/model/restaurants_model.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({@required this.apiService}) {
    _fetchAllListRestaurant();
  }

  ResultState _state;
  String _message;
  List<RestaurantsModel> _result;

  ResultState get state => _state;

  String get message => _message;

  List<RestaurantsModel> get result => _result;

  Future<dynamic> _fetchAllListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final listRestaurants = await apiService.listRestaurants();
      if (listRestaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Daya';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        List<RestaurantsModel> newList = [];
        for (var i = 0; i < listRestaurants.restaurants.length; i++) {
          newList.add(RestaurantsModel(
              id: listRestaurants.restaurants[i].id,
              name: listRestaurants.restaurants[i].name,
              description: listRestaurants.restaurants[i].description,
              pictureId: listRestaurants.restaurants[i].pictureId,
              city: listRestaurants.restaurants[i].city,
              rating: listRestaurants.restaurants[i].rating));
        }
        return _result = newList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }
}
