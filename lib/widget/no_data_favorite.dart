import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataFavoriteWidget extends StatelessWidget {
  const NoDataFavoriteWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              "assets/image/bg_empty.svg",
              height: 200,
              width: 250,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            "No Favorite Data",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Text(
            "You Haven't Added Favorite Data, Let's Add Your Favorite Restaurant",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
