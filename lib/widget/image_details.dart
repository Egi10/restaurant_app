import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/model/details_restaurants_model.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({
    Key key,
    @required this.detailsRestaurantsModel,
  }) : super(key: key);

  final DetailsRestaurantsModel detailsRestaurantsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}