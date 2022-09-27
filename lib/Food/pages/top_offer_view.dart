import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/TopOffersModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/pages/offer_screen.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';

import 'app_colors.dart';
import 'spotlight_best_top_food.dart';
import 'ui_helper.dart';

class TopOffersViews extends StatefulWidget {
  final List<TopOfferModel>? topOffers;

  const TopOffersViews({Key? key, this.topOffers}) : super(key: key);

  @override
  State<TopOffersViews> createState() => _TopOffersViewsState();
}

class _TopOffersViewsState extends State<TopOffersViews> {
  List<TopOfferModel>? topOffers = ApiService.topOffers;

  final restaurants = SpotlightBestTopFood.getTopRestaurants();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          topOffers != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Top Offers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 20.0),
                                ),
                                UIHelper.verticalSpaceExtraSmall(),
                                Text(
                                  'Trending treats, from top brands',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OffersScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'VIEW ALL',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                UIHelper.horizontalSpaceExtraSmall(),
                                ClipOval(
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: swiggyOrange,
                                    height: 25.0,
                                    width: 25.0,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      UIHelper.verticalSpaceExtraSmall(),
                      // Text(
                      //   "20 % off",
                      //   style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
                      // ),
                    ],
                  ),
                )
              : Container(),
          topOffers!.isNotEmpty ? UIHelper.verticalSpaceMedium() : Container(),
          topOffers!.isNotEmpty
              ? LimitedBox(
                  maxHeight: 400.0,
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 3
                              : 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1.3),
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: topOffers!.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RestaurantDetailScreen(
                                      id: topOffers![index].id!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                            )
                                          ],
                                        ),
                                        child: topOffers![index].image != ""
                                            ? Image.network(
                                                "https://foodieworlds.in/foodie/uploads/restaurant/${topOffers![index].image}",
                                                height: 120.0,
                                                width: 140.0,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                                                height: 120.0,
                                                width: 140.0,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        child: Container(
                                          width: 130.0,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(5.0),
                                                  bottomRight:
                                                      Radius.circular(5.0)),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  topOffers![index].offer! +
                                                      "% OFF ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: swiggyOrange,
                                                      fontSize: 11.5),
                                                ),
                                                Text(
                                                  "UPTO Rs." +
                                                      topOffers![index].up_to!,
                                                  style: TextStyle(
                                                      color: swiggyOrange,
                                                      fontSize: 11.5),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  UIHelper.verticalSpaceSmall(),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Text(
                                            topOffers![index].restaurant_name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(fontSize: 14.0),
                                          ),
                                        ),
                                        UIHelper.verticalSpaceSmall(),
                                        Row(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  size: 14.0,
                                                  color: Colors.grey[600],
                                                ),
                                                Text(topOffers![index].rating!,
                                                    style: TextStyle(
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            UIHelper.horizontalSpaceSmall(),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.fiber_manual_record,
                                                  size: 8.0,
                                                  color: Colors.grey[600],
                                                ),
                                                UIHelper.horizontalSpaceSmall(),
                                                Text(
                                                    topOffers![index]
                                                        .duration_lt!,
                                                    style: TextStyle(
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Text(
                                  //   "restaurant.coupon",
                                  //   style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red[900], fontSize: 13.0),
                                  // ),
                                ],
                              ),
                            ),
                          )),
                )
              : Container()
        ],
      ),
    );
  }
}
