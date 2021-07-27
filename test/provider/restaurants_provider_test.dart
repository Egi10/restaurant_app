import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';

void main() {
  test('fetch all list restaurant success', (){
    // arrange
    var restaurantsProvider = RestaurantsProvider();
    var tesModuleName = 'Test Module';
    // act


    // assert
    var result = restaurantsProvider.result.contains('');
    expect(result, true);
  });
}