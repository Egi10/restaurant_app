import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/database_helper.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';

enum ResultStateFavorite { NoData, HasData }

class DbProvider extends ChangeNotifier {
  ResultStateFavorite _resultState;
  List<RestaurantsEntity> _listRestaurant = [];
  DatabaseHelper _helper;

  List<RestaurantsEntity> get listRestaurant => _listRestaurant;

  ResultStateFavorite get resultState => _resultState;

  DbProvider() {
    _helper = DatabaseHelper();
    _getAllRestaurant();
  }

  void _getAllRestaurant() async {
    _listRestaurant = await _helper.getRestaurant();
    if (_listRestaurant.isEmpty) {
      _resultState = ResultStateFavorite.NoData;
      notifyListeners();
    } else {
      _resultState = ResultStateFavorite.HasData;
      notifyListeners();
    }
  }

  Future<void> addRestaurant(RestaurantsEntity restaurantsEntity) async {
    await _helper.insertRestaurant(restaurantsEntity);
  }

  Future<RestaurantsEntity> getRestauranById(String id) async {
    return await _helper.getRestaurantById(id);
  }

  void deleteRestaurantById(String id) async {
    await _helper.getRestaurantById(id);
  }
}
