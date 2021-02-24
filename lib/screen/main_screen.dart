import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/model/restaurants_model.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/screen/details_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchScreen();
                        }));
                      }),
                ],
              ),
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
                child: ChangeNotifierProvider<RestaurantsProvider>(
                  create: (_) => RestaurantsProvider(apiService: ApiService()),
                  child: Consumer<RestaurantsProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.state == ResultState.HasData) {
                        return ListView.builder(
                            itemCount: state.result.length,
                            itemBuilder: (context, index) {
                              return _buildRestaurantsItems(
                                  context, state.result[index]);
                            });
                      } else if (state.state == ResultState.NoData) {
                        return Center(child: Text(state.message));
                      } else if (state.state == ResultState.Error) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text(''));
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

Widget _buildRestaurantsItems(
    BuildContext context, RestaurantsModel restaurants) {
  return Container(
    height: 60,
    margin: EdgeInsets.all(8),
    child: Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(
                idRestaurants: restaurants.id,
              );
            }));
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
