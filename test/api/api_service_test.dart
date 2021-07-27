import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/remote/api/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('listRestaurant', () {
    ApiService apiService;
    String _baseUrl = "restaurant-api.dicoding.dev";
    var endPoint = Uri.https(_baseUrl, "/list");

    setUp(() {
      apiService = ApiService();
    });

    test('return an all restourant if the http call completes successfully', () async {
      final client = MockClient();
      var response = '{"error": false, "message": "success", "count": 20}';

      when(client.get(endPoint)).thenAnswer((_) async =>
          http.Response(response, 200));

      var allRestaurant = await apiService.listRestaurants(client);
      expect(allRestaurant.message, 'success');
    });

    test('throws an exception if the http call completes with an error', () async {
      final client = MockClient();

      when(client.get(endPoint)).thenAnswer((_) async =>
          http.Response('Not Found', 404));

      var allRestaurant = apiService.listRestaurants(client);
      expect(allRestaurant, throwsException);
    });
  });
}
