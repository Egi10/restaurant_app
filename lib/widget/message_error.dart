import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageError extends StatelessWidget {
  final String image;
  final String message;
  final String subMessage;

  MessageError(
      {@required this.image,
      @required this.message,
      @required this.subMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              image,
              height: 200,
              width: 250,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
