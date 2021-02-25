import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/model/details_restaurants_model.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/widget/message_error.dart';

class DetailScreen extends StatelessWidget {
  final String idRestaurants;

  DetailScreen({@required this.idRestaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ChangeNotifierProvider<RestaurantsProvider>(
        create: (_) => RestaurantsProvider.details(
            apiService: ApiService(), idRestaurants: idRestaurants),
        child: Consumer<RestaurantsProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            return _buildRestaurantsDetail(context, state.resultDetail);
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
            return MessageError(
                image: "assets/image/bg_connection.svg",
                message: state.message,
                subMessage:
                    "Slow or internet no connection. Please check your internet settings");
          }
        }),
      )),
    );
  }
}

Widget _buildRestaurantsDetail(
    BuildContext context, DetailsRestaurantsModel detailsRestaurantsModel) {
  return SingleChildScrollView(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Hero(
        tag: detailsRestaurantsModel.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
          child: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/${detailsRestaurantsModel.pictureId}",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
            return Image(image: AssetImage('assets/image/empty.jpg'));
          }, loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.2,
                    child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator())));
          },
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 1.2,
              fit: BoxFit.fill),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              detailsRestaurantsModel.name,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 3)),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 16.0,
                  color: Colors.grey,
                ),
                Padding(padding: EdgeInsets.only(left: 3.0)),
                Text(
                  detailsRestaurantsModel.city,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              detailsRestaurantsModel.description,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              "Customer Reviews",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: detailsRestaurantsModel.customerReviews.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          detailsRestaurantsModel.customerReviews[index].name,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          detailsRestaurantsModel.customerReviews[index].date,
                          style: TextStyle(fontSize: 10),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          detailsRestaurantsModel.customerReviews[index].review,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Divider()
                      ],
                    ),
                  );
                })
          ],
        ),
      )
    ],
  ));
}
