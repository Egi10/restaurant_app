import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/widget/item_list_restaurants.dart';
import 'package:restaurant_app/widget/message_error.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RestaurantsProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Search',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.start,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              height: 40.0,
              child: TextFormField(
                maxLines: 1,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    appState.fetchSearchRestaurant(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search your restaurant',
                  hintStyle: TextStyle(fontSize: 12.0),
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            _searchRestaurant()
          ],
        ),
      )),
    );
  }
}

Widget _searchRestaurant() {
  return Expanded(child: Consumer<RestaurantsProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        print("Loading");
        return Center(
          child: Lottie.asset('assets/anim/search_loading.json'),
        );
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 30),
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              return buildRestaurantsItems(context, state.result[index]);
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
            subMessage: "Our server goes down. We will be back soon.");
      } else {
        String message;
        if (state.message != null) {
          message = state.message;
        } else {
          message = "Ops";
        }
        return MessageError(
            image: "assets/image/bg_connection.svg",
            message: message,
            subMessage:
                "Slow or internet no connection. Please check your internet settings");
      }
    },
  ));
}
