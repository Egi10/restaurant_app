import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/response/restaurants_response.dart';

class DetailScreen extends StatelessWidget {
  final Restaurants restaurants;

  DetailScreen({@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: restaurants.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                child: Image.network(restaurants.pictureId,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.2,
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurants.name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 3.0)),
                      Text(
                        restaurants.city,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    restaurants.description,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
