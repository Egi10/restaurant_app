import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Favorite Restaurant',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.start,
              ),
              Text(
                'Favorite restaurant for you!',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Expanded(
                child: Consumer<DbProvider>(
                  builder: (context, provider, child) {
                    if (provider.resultState == ResultStateFavorite.NoData) {
                      return Text('Kosong');
                    } else {
                      final restaurant = provider.listRestaurant;
                      return ListView.builder(
                          itemCount: restaurant.length,
                          itemBuilder: (context, index) {
                            return _itemListFavorite(
                                context, restaurant[index]);
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemListFavorite(
      BuildContext context, RestaurantsEntity restaurantsEntity) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 4, left: 4),
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          Column(
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
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                restaurantsEntity.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(top: 3)),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14.0,
                    color: Colors.grey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 3.0)),
                  Text(
                    restaurantsEntity.city,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
