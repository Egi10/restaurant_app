import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:toast/toast.dart';

class ImageDetailFavorite extends StatelessWidget {
  const ImageDetailFavorite({
    Key key,
    @required this.detailsRestaurantsModel,
    @required this.provider,
  }) : super(key: key);

  final RestaurantsEntity detailsRestaurantsModel;
  final DbProvider provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}