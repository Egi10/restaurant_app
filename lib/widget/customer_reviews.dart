import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/model/details_restaurants_model.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({
    Key key,
    @required this.detailsRestaurantsModel,
  }) : super(key: key);

  final DetailsRestaurantsModel detailsRestaurantsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Customer Reviews",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      detailsRestaurantsModel.customerReviews[index].date,
                      style: TextStyle(fontSize: 10),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      detailsRestaurantsModel.customerReviews[index].review,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
