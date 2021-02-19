class DetailsRestaurantsModel {
  String _id;
  String _name;
  String _description;
  String _city;
  String _address;
  String _pictureId;
  dynamic _rating;
  List<CustomerReviewsModel> _customerReviews;

  String get id => _id;

  String get name => _name;

  String get description => _description;

  String get city => _city;

  String get address => _address;

  String get pictureId => _pictureId;

  dynamic get rating => _rating;

  List<CustomerReviewsModel> get customerReviews => _customerReviews;

  DetailsRestaurantsModel(
      {String id,
      String name,
      String description,
      String city,
      String address,
      String pictureId,
      dynamic rating,
      List<CustomerReviewsModel> customerReviews}) {
    _id = id;
    _name = name;
    _description = description;
    _city = city;
    _address = address;
    _pictureId = pictureId;
    _rating = rating;
    _customerReviews = customerReviews;
  }
}

class CustomerReviewsModel {
  String _name;
  String _review;
  String _date;

  String get name => _name;

  String get review => _review;

  String get date => _date;

  CustomerReviewsModel({String name, String review, String date}) {
    _name = name;
    _review = review;
    _date = date;
  }
}
