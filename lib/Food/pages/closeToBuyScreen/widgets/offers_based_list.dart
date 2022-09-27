import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/PopularCuraionViewModel.dart';
import 'package:mycityapp/Food/Services/offer_based_list_api_provider.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:provider/provider.dart';

import '../../../CommonWidgets/utils.dart';

class OfferBasedList extends StatefulWidget {
  final dynamic offerLimit;
  final String? id;
  final Color color;
  final String? title;
  final dynamic code;
  final dynamic offerPercent;
  final dynamic image;

  const OfferBasedList(
      {Key? key,
      required this.id,
      required this.offerLimit,
      required this.image,
      required this.color,
      required this.code,
      required this.offerPercent,
      required this.title})
      : super(key: key);

  @override
  _OfferBasedListState createState() => _OfferBasedListState();
}

class _OfferBasedListState extends State<OfferBasedList> {
  List<PopularCurationViewModel>? offer = [];
  int filter = 1;
  @override
  void initState() {
    super.initState();
    // if(apiServices.of)
    context.read<OfferRestaurantBannerAPIProvider>().initialize();
    if (context
            .read<OfferRestaurantBannerAPIProvider>()
            .offerRestaurantBannerResponseModel ==
        null) {
      context.read<OfferRestaurantBannerAPIProvider>().getOfferBannerBased(
          lat: SharedPreference.latitudeValue,
          long: SharedPreference.longitude,
          offerLimit: widget.offerLimit,
          filter: filter.toString(),
          id: widget.id!);
    }

    // apiServices
    //     .offerbasedlistUrl(SharedPreference.latitudeValue,
    //         SharedPreference.longitudeValue, widget.offerLimit, "1", widget.id)
    //     .then((value) {
    //   setState(() {
    //     offer = ApiServices.offerBasedList;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final offerRequestBannerApiProvider =
        Provider.of<OfferRestaurantBannerAPIProvider>(context);
    if (offerRequestBannerApiProvider.ifLoading) {
      return Center(child: Utils.showLoading());
    }
    if (offerRequestBannerApiProvider.error) {
      return Utils.showErrorMessage(offerRequestBannerApiProvider.errorMessage);
    } else if (offerRequestBannerApiProvider
            .offerRestaurantBannerResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(offerRequestBannerApiProvider
          .offerRestaurantBannerResponseModel!.message!);
    } else {
      final images = offerRequestBannerApiProvider
          .offerRestaurantBannerResponseModel!.newArrival!;

      return Scaffold(
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            //2
            SliverAppBar(
              backgroundColor: widget.color.withOpacity(0.5),
              automaticallyImplyLeading: false,
              expandedHeight: 330,
              pinned: false,
              floating: false,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                widget.title!.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: widget.color),
                              )),
                          UIHelper.verticalSpaceSmall(),
                          Image.network(
                            "https://foodieworlds.in/foodie/" + widget.image,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 100,
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        "${widget.offerPercent} on your first order",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      UIHelper.verticalSpaceMedium(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Use Code: ${widget.code}",
                              style: TextStyle(color: widget.color)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: offer!.length,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetailScreen(
                                  id: offer![index].id!,
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
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      child: offer![index].image != ""
                                          ? Image.network(
                                              "https://foodieworlds.in/foodie/uploads/restaurant/${offer![index].image}",
                                              height: 110.0,
                                              width: 80.0,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                                              height: 110.0,
                                              width: 80.0,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    offer![index].offer != ""
                                        ? Positioned(
                                            bottom: 0,
                                            left: 5,
                                            // top: 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, 15, 0),
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        offer![index].offer! +
                                                            " OFF",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                                fontSize: 11.0,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Text(
                                                        "UPTO Rs. " +
                                                            offer![index]
                                                                .up_to!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                                fontSize: 8.0,
                                                                color: Colors
                                                                    .white),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        offer![index].restaurant_name!,
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
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  size: 14.0,
                                                  color: Colors.grey[600],
                                                ),
                                                UIHelper.horizontalSpaceSmall(),
                                                Text(offer![index].rating!,
                                                    style: TextStyle(
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            UIHelper.horizontalSpaceSmall(),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.fiber_manual_record,
                                                  size: 10.0,
                                                  color: Colors.grey[600],
                                                ),
                                                UIHelper.horizontalSpaceSmall(),
                                                Text(offer![index].duration_lt!,
                                                    style: TextStyle(
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            UIHelper.horizontalSpaceSmall(),
                                          ],
                                        ),
                                      ),
                                      // UIHelper.verticalSpaceSmall(),
                                      // Text(foods[index].category, style: TextStyle(fontSize: 12.0))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      );
    }
  }
}
