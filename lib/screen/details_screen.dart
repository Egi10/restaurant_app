import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/model/restaurants_model.dart';

class DetailScreen extends StatelessWidget {
  final RestaurantsModel restaurants;

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
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.2,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  ));
                },
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.2,
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
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
