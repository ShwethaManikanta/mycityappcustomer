import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/PopularDishModel.dart';
import 'package:mycityapp/Food/Models/PopularRestaurantModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/cart_api_provider.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/closeToBuyScreen/widgets/offer_banner_view.dart';
import '../../Services/popular_restaurant_api_provider.dart';
import '../spotlight_best_top_food.dart';
import '../ui_helper.dart';
import 'package:provider/provider.dart';

class MeatScreen extends StatefulWidget {
  @override
  _MeatScreenState createState() => _MeatScreenState();
}

class _MeatScreenState extends State<MeatScreen> {
  List<PopularDishModel>? popularDishs = [];
  List<PopularRestaurantModel> popularRestarunt = [];

  @override
  void initState() {
    super.initState();
    // apiServices
    //     .getPopularDishes(
    //         SharedPreference.latitudeValue, SharedPreference.longitudeValue)
    //     .then((value) {
    //   setState(() {
    //     popularDishs = ApiServices.popularDishs;
    //     print("popularDishs length ---------- ${popularDishs!.length}");
    //   });
    // });
    // apiServices
    //     .getPopularRestaurants(
    //         SharedPreference.latitudeValue, SharedPreference.longitudeValue, 5)
    //     .then((value) {
    //   setState(() {
    //     popularRestarunt = ApiServices.popularRestaurants;
    //   });
    // });
  }

  initialize() async {
    context.read<PopularRestaurantAPIProvider>().initialize();
    if (context
            .read<PopularRestaurantAPIProvider>()
            .popularRestaurantResponseModel ==
        null) {
      context.read<PopularRestaurantAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "2",
          foodType: "3");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.popAndPushNamed(context, 'Home');
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Meat",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                MeatBannerView(),
                SizedBox(
                  height: 20,
                ),
                /*Container(
                  height: 100,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 8.0, bottom: 4),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 28,
                                    child: Image.asset(
                                      "assets/images/homeLogo.png",
                                      width: 28,
                                    ),
                                  )),
                              Text(
                                "Close To Buy",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),

                              //   Text("C2B")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children:
                                List.generate(popularRestarunt.length, (index) {
                              print(popularRestarunt.length);
                              popularRestarunt.isNotEmpty
                                  ? Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8.0, bottom: 4),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                radius: 28,
                                                child: Image.network(
                                                  "https://chillkrt.in/closetobuy/uploads/restaurant/${popularRestarunt[index].image}",
                                                  width: 28,
                                                ),
                                              )),
                                          Text(
                                            popularRestarunt[index]
                                                .restaurantName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  : CircularProgressIndicator();
                            }),
                          ))
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 20,
                ),
                popularDishs!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: popularDishs!
                              .map((e) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: _ListViewHeader(
                                          title: e.category_name,
                                          desc:
                                              "Trying to taste best buying experience",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemCount: e.productList!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 2.0,
                                                            )
                                                          ],
                                                        ),
                                                        child: Image.network(
                                                          "https://chillkrt.in/Mycities/Mycities_food/uploads/menu/${e.productList![index].image}",
                                                          height: 90.0,
                                                          width: 90.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    UIHelper
                                                        .horizontalSpaceSmall(),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          e.productList![index]
                                                              .dishes_name
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16.0),
                                                        ),
                                                        UIHelper
                                                            .verticalSpaceSmall(),
                                                        Row(
                                                          children: [
                                                            // Container(
                                                            //     decoration: BoxDecoration(
                                                            //         borderRadius: BorderRadius.circular(5.0),
                                                            //         border: Border.all(color: Colors.grey)),
                                                            //     child: Padding(
                                                            //       padding: const EdgeInsets.all(2.0),
                                                            //       child: Text(
                                                            //         "${e.productList[index].weight} ",
                                                            //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                            //       ),
                                                            //     )),
                                                            // UIHelper.horizontalSpaceSmall(),
                                                            // Text("-"),
                                                            UIHelper
                                                                .horizontalSpaceSmall(),
                                                            Text(
                                                                "${e.productList![index].pieces} pieces" +
                                                                    " -"),
                                                            UIHelper
                                                                .horizontalSpaceSmall(),
                                                            Text(
                                                              "Rs.${e.productList![index].price}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                        // Text(foods[index].desc,
                                                        //     style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[800], fontSize: 13.5)),
                                                        UIHelper
                                                            .verticalSpaceSmall(),
                                                      ],
                                                    ),
                                                    UIHelper
                                                        .horizontalSpaceSmall(),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        apiService
                                                            .addToCart(
                                                                context,
                                                                popularDishs![
                                                                        index]
                                                                    .productList![
                                                                        index]
                                                                    .id,
                                                                "+1",
                                                                "1")
                                                            .then((value) => context
                                                                .read<
                                                                    CartListAPIProvider>()
                                                                .cartlist(
                                                                    SharedPreference
                                                                        .latitude,
                                                                    SharedPreference
                                                                        .longitude,
                                                                    ""));
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 6.0,
                                                                horizontal:
                                                                    25.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                        child: Text(
                                                          'ADD',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .subtitle2!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Loading.....")
                        ],
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoresListView extends StatelessWidget {
  final foods = SpotlightBestTopFood.getPopularAllRestaurants();
  final List<PopularDishModel> popularDishs;

  _StoresListView({
    required this.popularDishs,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: popularDishs.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _ListViewHeader(
                title: popularDishs[index].category_name,
                desc: "Trying to taste best buying experience",
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        )
                      ],
                    ),
                    child: Image.network(
                      "https://foodieworlds.in/foodie/uploads/menu/${popularDishs[index].productList![index].image}",
                      height: 40.0,
                      width: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      popularDishs[index].productList![index].dishes_name!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16.0),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "${popularDishs[index].productList![index].weight} ",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            )),
                        UIHelper.horizontalSpaceSmall(),
                        Text("-"),
                        UIHelper.horizontalSpaceSmall(),
                        Text(
                            "${popularDishs[index].productList![index].pieces} pieces" +
                                " -"),
                        UIHelper.horizontalSpaceSmall(),
                        Text(
                          "Rs.${popularDishs[index].productList![index].price}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    // Text(foods[index].desc,
                    //     style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[800], fontSize: 13.5)),
                    UIHelper.verticalSpaceSmall(),
                  ],
                ),
                UIHelper.horizontalSpaceSmall(),
                Spacer(),
                InkWell(
                  onTap: () {
                    apiService
                        .addToCart(
                            context,
                            popularDishs[index].productList![index].id,
                            "+1",
                            "1")
                        .then((value) => context
                            .read<CartListAPIProvider>()
                            .cartlist(SharedPreference.latitude,
                                SharedPreference.longitude, ""));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      'ADD',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ListViewHeader extends StatelessWidget {
  final String? title;
  final String desc;

  const _ListViewHeader({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.orange,
            ),
            UIHelper.horizontalSpaceSmall(),
            Text(
              title!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        UIHelper.verticalSpaceExtraSmall(),
        Text(
          desc,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 13.0,
              ),
        )
      ],
    );
  }
}
