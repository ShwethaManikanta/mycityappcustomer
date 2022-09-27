import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/TopOffersModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/closeToBuyScreen/widgets/offer_banner_view.dart';
import 'restaurantDetailsPage/restaurant_detail_screen.dart';
import 'ui_helper.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'FOODIE OFFERS',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: _RestaurantOfferView(),
        ),
      ),
    );
  }
}

class _RestaurantOfferView extends StatefulWidget {
  @override
  State<_RestaurantOfferView> createState() => _RestaurantOfferViewState();
}

class _RestaurantOfferViewState extends State<_RestaurantOfferView> {
  List<TopOfferModel>? food = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      apiService
          .getPopularRestaurants(SharedPreference.latitudeValue,
              SharedPreference.longitudeValue, 5)
          .then((value) {
        setState(() {
          food = ApiService.topOffers;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceSmall(),
          TopOfferBannerView(),
          UIHelper.verticalSpaceSmall(),
          // Text(

          //   'All Offers',
          //   style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, fontSize: 19.0),
          // ),
          // UIHelper.verticalSpaceMedium(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: food!.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                          id: food![index].id!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  )
                                ],
                              ),
                              child: Image.network(
                                "https://foodieworlds.in/foodie/uploads/restaurant/${food![index].image}",
                                height: 90.0,
                                width: 90.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              child: Container(
                                width: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0)),
                                    color: Colors.orange),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        food![index].offer! + "% OFF ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 8),
                                      ),
                                      Text(
                                        "UPTO Rs." + food![index].up_to!,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                food![index].restaurant_name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 15.0),
                              ),
                              // Text(food.desc,
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyText1
                              //         .copyWith(color: Colors.grey[600], fontSize: 13.5)),
                              UIHelper.verticalSpaceSmall(),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    food![index].rating!,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
