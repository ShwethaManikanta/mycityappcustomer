import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/PopularCuraionViewModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';

class PopularCurationsView extends StatefulWidget {
  final dynamic categoryId;
  final dynamic title;

  const PopularCurationsView({Key? key, this.categoryId, this.title})
      : super(key: key);

  @override
  _PopularCurationsViewState createState() => _PopularCurationsViewState();
}

class _PopularCurationsViewState extends State<PopularCurationsView> {
  List<PopularCurationViewModel>? popularView = ApiService.popularCurationsView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiService
          .popluarcuration(SharedPreference.latitudeValue,
              SharedPreference.longitudeValue, widget.categoryId)
          .then((value) {
        setState(() {
          popularView = ApiService.popularCurationsView;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: swiggyOrange,
          title: Text(widget.title),
        ),
        body: popularView!.isNotEmpty
            ? SingleChildScrollView(
                child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: popularView!.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailScreen(
                            id: popularView![index].id!,
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
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: popularView![index].image != ""
                                    ? Image.network(
                                        "https://foodieworlds.in/foodie/uploads/restaurant/${popularView![index].image}",
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
                              popularView![index].offer != ""
                                  ? Positioned(
                                      bottom: 0,
                                      left: 5,
                                      // top: 100,
                                      child: Container(
                                        alignment: Alignment.center,
                                        transform:
                                            Matrix4.translationValues(0, 15, 0),
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  popularView![index].offer! +
                                                      " OFF",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontSize: 11.0,
                                                          color: Colors.white),
                                                ),
                                                Text(
                                                  "UPTO Rs. " +
                                                      popularView![index]
                                                          .up_to!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontSize: 8.0,
                                                          color: Colors.white),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  popularView![index].restaurant_name!,
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
                                          Text(popularView![index].rating!,
                                              style: TextStyle(fontSize: 12.0))
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
                                          Text(popularView![index].duration_lt!,
                                              style: TextStyle(fontSize: 12.0))
                                        ],
                                      ),
                                      UIHelper.horizontalSpaceSmall(),
                                    ],
                                  ),
                                ),
                                UIHelper.verticalSpaceSmall(),
                                Text(popularView![index].category!,
                                    style: TextStyle(fontSize: 12.0))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ))
            : Center(child: Text("Restaurants unavailable")));
  }
}
