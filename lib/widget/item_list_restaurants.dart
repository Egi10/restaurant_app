import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/provider/model/restaurants_model.dart';
import 'package:restaurant_app/screen/details_screen.dart';

Widget buildRestaurantsItems(
    BuildContext context, RestaurantsModel restaurants) {
  return Container(
    height: 60,
    margin: EdgeInsets.all(8),
    child: Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider<DbProvider>(
                  create: (_) => DbProvider(),
                  child: DetailScreen(
                    idRestaurants: restaurants.id,
                  ),
                );
              }),
            );
          },
          child: Row(
            children: <Widget>[
              Hero(
                tag: restaurants.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}",
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image(image: AssetImage('assets/image/empty.jpg'));
                      }, loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: Container(
                            width: 80,
                            height: 60,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator())));
                  }, width: 80, height: 60, fit: BoxFit.fill),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurants.name,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12.0,
                          color: Colors.grey,
                        ),
                        Padding(padding: EdgeInsets.only(left: 3.0)),
                        Text(
                          restaurants.city,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 12.0,
                              color: Colors.grey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 3.0)),
                            Text(
                              restaurants.rating.toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ],
    ),
  );
}