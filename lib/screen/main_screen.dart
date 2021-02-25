import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/widget/item_list_restaurants.dart';

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
                          return ChangeNotifierProvider<RestaurantsProvider>(
                            create: (_) => RestaurantsProvider(),
                            child: SearchScreen(),
                          );
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