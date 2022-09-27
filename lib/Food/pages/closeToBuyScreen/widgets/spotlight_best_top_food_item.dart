import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/cached_network_image.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import '../../../Models/TakeAwayModel.dart';
import '../../restaurantDetailsPage/restaurant_detail_screen.dart';
import '../../ui_helper.dart';

class SpotlightBestTopFoodItem extends StatelessWidget {
  final NewArrival foods;
  final String baseImagreUrl;

  const SpotlightBestTopFoodItem(
      {Key? key, required this.foods, required this.baseImagreUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
          foods.id,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(
              id: foods.id!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                      )
                    ],
                  ),
                  child: foods.image != ""
                      ? cachedNetworkImage(
                          110, 80, baseImagreUrl + foods.image!)
                      : SizedBox(
                          height: 110,
                          width: 80,
                          child: Image.network(
                            "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                            height: 110.0,
                            width: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                foods.offer != ""
                    ? Positioned(
                        bottom: 0,
                        left: 5,
                        // top: 100,
                        child: Container(
                          alignment: Alignment.center,
                          transform: Matrix4.translationValues(0, 15, 0),
                          width: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                children: [
                                  Text(
                                    foods.offer! + " OFF",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 11.0,
                                            color: Colors.white),
                                  ),
                                  Text(
                                    "UPTO Rs. " + foods.upTo!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 8.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            UIHelper.horizontalSpaceSmall(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          foods.restaurantName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                  FittedBox(
                    child: Row(
                      children: [
                        Text(foods.status!,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: swiggyOrange,
                                fontWeight: FontWeight.bold)),
                        UIHelper.horizontalSpaceSmall(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.fiber_manual_record,
                              size: 10.0,
                              color: Colors.grey[600],
                            ),
                            UIHelper.horizontalSpaceSmall(),
                            Text(foods.durationLt!,
                                style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 14.0,
                              color: Colors.grey[600],
                            ),
                            UIHelper.horizontalSpaceSmall(),
                            Text(foods.rating!,
                                style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(
                    foods.category!,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey, fontSize: 13),
                  ),
                  // UIHelper.verticalSpaceSmall(),
                  // Text(
                  //   restaurant.coupon,
                  //   style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red[900], fontSize: 13.0),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
