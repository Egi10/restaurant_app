import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:restaurant_app/screen/favorite/favorite_detail_screen.dart';

Widget itemListFavorite(
    BuildContext context, RestaurantsEntity restaurantsEntity) {
  return Container(
    margin: EdgeInsets.only(top: 8, bottom: 8, right: 4, left: 4),
    padding: EdgeInsets.only(bottom: 10),
    child: Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider<DbProvider>(
                  create: (_) => DbProvider(),
                  child: FavoriteDetailScreen(
                    idRestaurants: restaurantsEntity.id,
                  ),
                );
              }),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: "Favorite Picture",
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
          ),
        ),
      ],
    ),
  );
}
