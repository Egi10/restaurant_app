import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:restaurant_app/widget/image_detail_favorite.dart';

class FavoriteDetailScreen extends StatelessWidget {
  final String idRestaurants;

  FavoriteDetailScreen({@required this.idRestaurants});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);

    return Scaffold(
      body: Container(
        child: FutureBuilder<RestaurantsEntity>(
            future: provider.getRestaurantById(idRestaurants),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final detailsRestaurantsModel = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ImageDetailFavorite(
                          detailsRestaurantsModel: detailsRestaurantsModel,
                          provider: provider),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              detailsRestaurantsModel.name,
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
                                  detailsRestaurantsModel.city,
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              detailsRestaurantsModel.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                Navigator.pop(context);
              }
              return Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
