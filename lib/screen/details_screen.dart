import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:restaurant_app/data/remote/api/api_service.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/widget/message_error.dart';
import 'package:toast/toast.dart';

class DetailScreen extends StatefulWidget {
  final String idRestaurants;

  DetailScreen({@required this.idRestaurants});

  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  static bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);

    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider.details(
              apiService: ApiService(), idRestaurants: widget.idRestaurants),
          child: Consumer<RestaurantsProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              print('${provider.listRestaurantFavorite.length} - $isFavorite');
              provider.getRestaurantByIdSize(widget.idRestaurants);
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              final detailsRestaurantsModel = state.resultDetail;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: Hero(
                            tag: detailsRestaurantsModel.pictureId,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              child: Image.network(
                                "https://restaurant-api.dicoding.dev/images/medium/${detailsRestaurantsModel.pictureId}",
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image(
                                      image:
                                          AssetImage('assets/image/empty.jpg'));
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
                                height: MediaQuery.of(context).size.width * 0.8,
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
                                icon: provider.listRestaurantFavorite.length > 0
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                                onPressed: () async {
                                  final list = provider.listRestaurantFavorite;
                                  if (list.length > 0) {
                                    provider.deleteRestaurantById(
                                        detailsRestaurantsModel.id);
                                    Toast.show(
                                        "Your Favorite Restaurant Data Has Been Deleted Successfully",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);

                                    setState(() {
                                      provider.getRestaurantByIdSize(
                                          detailsRestaurantsModel.id);

                                      isFavorite = false;
                                    });
                                  } else {
                                    final restaurantsEntity = RestaurantsEntity(
                                        detailsRestaurantsModel.id,
                                        detailsRestaurantsModel.name,
                                        detailsRestaurantsModel.description,
                                        detailsRestaurantsModel.pictureId,
                                        detailsRestaurantsModel.city);

                                    provider.addRestaurant(restaurantsEntity);
                                    Toast.show(
                                        "Your Favorite Restaurant Data Successfully Saved",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);

                                    setState(() {
                                      provider.getRestaurantByIdSize(
                                          detailsRestaurantsModel.id);

                                      isFavorite = true;
                                    });
                                  }
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
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "Customer Reviews",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              itemCount: detailsRestaurantsModel
                                  .customerReviews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        detailsRestaurantsModel
                                            .customerReviews[index].name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        detailsRestaurantsModel
                                            .customerReviews[index].date,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Text(
                                        detailsRestaurantsModel
                                            .customerReviews[index].review,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return MessageError(
                  image: "assets/image/bg_empty.svg",
                  message: state.message,
                  subMessage:
                      "We Cannot find the item you are searching for. maybe a little spelling mistake?");
            } else if (state.state == ResultState.Error) {
              return MessageError(
                  image: "assets/image/bg_server_down.svg",
                  message: state.message,
                  subMessage: "Our server goes down. We will be back soon.");
            } else {
              return MessageError(
                  image: "assets/image/bg_connection.svg",
                  message: state.message,
                  subMessage:
                      "Slow or internet no connection. Please check your internet settings");
            }
          }),
        ),
      ),
    );
  }
}
