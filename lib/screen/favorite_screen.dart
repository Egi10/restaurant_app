import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<DbProvider>(
                builder: (context, provider, child) {
                  final restaurant = provider.listRestaurant;

                  return ListView.builder(
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return Text(restaurant[index].city);
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
