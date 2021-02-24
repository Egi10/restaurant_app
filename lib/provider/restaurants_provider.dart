import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/model/details_restaurants_model.dart';
import 'package:restaurant_app/provider/model/restaurants_model.dart';

enum ResultState { Loading, NoData, HasData, Error, NoInternet }

class RestaurantsProvider extends ChangeNotifier {
  ApiService apiService;
  String idRestaurants;
  String querySearch;

  RestaurantsProvider({ApiService apiService}) {
    this.apiService = apiService;
    _fetchAllListRestaurant();
  }

  RestaurantsProvider.details({ApiService apiService, String idRestaurants}) {
    this.apiService = apiService;
    this.idRestaurants = idRestaurants;
    _fetchDetailsRestaurant();
  }

  RestaurantsProvider.search({ApiService apiService, String querySearch}) {
    this.apiService = apiService;
    this.querySearch = querySearch;
    _fetchSearchRestaurant();
  }

  ResultState _state;
  String _message;
  List<RestaurantsModel> _result;
  DetailsRestaurantsModel _resultDetails;

  ResultState get state => _state;

  String get message => _message;

  List<RestaurantsModel> get result => _result;

  DetailsRestaurantsModel get resultDetail => _resultDetails;

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
    } on SocketException {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Check Your Internet Network';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }

  Future<dynamic> _fetchDetailsRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailsRestaurant =
          await apiService.detailRestaurants(idRestaurants);
      _state = ResultState.HasData;
      notifyListeners();
      List<CustomerReviewsModel> listCustomerReview = [];
      for (var i = 0;
          i < detailsRestaurant.restaurant.customerReviews.length;
          i++) {
        listCustomerReview.add(CustomerReviewsModel(
            name: detailsRestaurant.restaurant.customerReviews[i].name,
            review: detailsRestaurant.restaurant.customerReviews[i].review,
            date: detailsRestaurant.restaurant.customerReviews[i].date));
      }

      var detailResult = DetailsRestaurantsModel(
          id: detailsRestaurant.restaurant.id,
          name: detailsRestaurant.restaurant.name,
          description: detailsRestaurant.restaurant.description,
          city: detailsRestaurant.restaurant.city,
          address: detailsRestaurant.restaurant.address,
          pictureId: detailsRestaurant.restaurant.pictureId,
          rating: detailsRestaurant.restaurant.rating,
          customerReviews: listCustomerReview);
      return _resultDetails = detailResult;
    } on SocketException {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Check Your Internet Network';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }

  Future<dynamic> _fetchSearchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final listRestaurants = await apiService.searchRestaurants(querySearch);
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
    } on SocketException {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Check Your Internet Network';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
