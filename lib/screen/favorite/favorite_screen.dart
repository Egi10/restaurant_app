import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/widget/item_list_favorite.dart';
import 'package:restaurant_app/widget/no_data_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Favorite Restaurant',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.start,
              ),
              Text(
                'Favorite restaurant for you!',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Expanded(
                child: Consumer<DbProvider>(
                  builder: (context, provider, child) {
                    if (provider.resultState == ResultStateFavorite.NoData) {
                      return NoDataFavoriteWidget();
                    } else {
                      provider.getAllRestaurant();
                      final restaurant = provider.listRestaurant;
                      return ListView.builder(
                          itemCount: restaurant.length,
                          itemBuilder: (context, index) {
                            return itemListFavorite(context, restaurant[index]);
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
