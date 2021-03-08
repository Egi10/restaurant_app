import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';

class DetailsFavoriteScreen extends StatelessWidget {
  final RestaurantsEntity restaurantsEntity;

  DetailsFavoriteScreen({this.restaurantsEntity});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          provider.deleteRestaurantById(restaurantsEntity.id);
          Navigator.of(context).pop(false);
        },
        label: Text('Delete Favorite'),
        icon: Icon(Icons.favorite),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "Favorite ${restaurantsEntity.picture}",
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${restaurantsEntity.picture}",
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurantsEntity.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 3.0)),
                      Text(
                        restaurantsEntity.city,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    restaurantsEntity.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
