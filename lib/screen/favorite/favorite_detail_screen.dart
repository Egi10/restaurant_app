import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:toast/toast.dart';

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
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.8,
                            child: Hero(
                              tag: "Favorite Picture",
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                child: Image.network(
                                  "https://restaurant-api.dicoding.dev/images/medium/${detailsRestaurantsModel.picture}",
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Image(
                                        image: AssetImage(
                                            'assets/image/empty.jpg'));
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  },
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            right: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey,
                                      spreadRadius: 2)
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {
                                    provider.deleteRestaurantById(
                                        detailsRestaurantsModel.id);

                                    Toast.show(
                                        "Your Favorite Restaurant Data Has Been Deleted Successfully",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);

                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
