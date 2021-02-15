import 'package:flutter/material.dart';
import 'package:restaurant_app/response/restaurants_response.dart';
import 'package:restaurant_app/screen/details_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 35, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Restaurant',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.start,
              ),
              Text(
                'Recomendation restauran for you!',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Expanded(
                child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString("assets/data/local_restaurant.json"),
                    builder: (context, snapshot) {
                      final restaurantsResponse =
                          parseRestaurant(snapshot.data);
                      return ListView.builder(
                          itemCount:
                              restaurantsResponse.restaurants.length ?? 0,
                          itemBuilder: (context, index) {
                            return _buildRestaurantsItems(context,
                                restaurantsResponse.restaurants[index]);
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRestaurantsItems(BuildContext context, Restaurants restaurants) {
  return Container(
    height: 60,
    margin: EdgeInsets.all(8),
    child: Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(
                restaurants: restaurants,
              );
            }));
          },
          child: Row(
            children: <Widget>[
              Hero(
                tag: restaurants.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(restaurants.pictureId,
                      width: 80, height: 60, fit: BoxFit.fill),
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
