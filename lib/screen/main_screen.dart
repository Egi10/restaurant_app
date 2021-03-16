import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/remote/api/api_service.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/widget/item_list_restaurants.dart';
import 'package:restaurant_app/widget/message_error.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ChangeNotifierProvider<DbProvider>(
                create: (_) => DbProvider(),
                child: FavoriteScreen(),
              );
            }),
          );
        },
        label: Text('Favorite'),
        icon: Icon(Icons.favorite),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search_rounded),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ChangeNotifierProvider<RestaurantsProvider>(
                              create: (_) => RestaurantsProvider(),
                              child: SearchScreen(),
                            );
                          }),
                        );
                      }),

                  IconButton(
                      icon: Icon(Icons.settings),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ChangeNotifierProvider<RestaurantsProvider>(
                              create: (_) => RestaurantsProvider(),
                              child: SearchScreen(),
                            );
                          }),
                        );
                      }),
                ],
              ),
              Text(
                'Restaurant',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.start,
              ),
              Text(
                'Recommendation restaurant for you!',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Expanded(
                child: ChangeNotifierProvider<RestaurantsProvider>(
                  create: (_) =>
                      RestaurantsProvider.allList(apiService: ApiService()),
                  child: Consumer<RestaurantsProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.state == ResultState.HasData) {
                        return ListView.builder(
                            itemCount: state.result.length,
                            itemBuilder: (context, index) {
                              return buildRestaurantsItems(
                                  context, state.result[index]);
                            });
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
                            subMessage:
                                "Our server goes down. We will be back soon.");
                      } else {
                        return MessageError(
                            image: "assets/image/bg_connection.svg",
                            message: state.message,
                            subMessage:
                                "Slow or internet no connection. Please check your internet settings");
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
