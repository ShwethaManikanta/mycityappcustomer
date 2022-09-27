import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/CommonWidgets/cached_network_image.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/Models/AddOnViewModel.dart';
import 'package:mycityapp/Food/Models/RestaurantViewModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/Services/restaurant_details_api_provider.dart';
import 'package:mycityapp/Food/pages/custom_divider_view.dart';
import '../../CommonWidgets/utils.dart';
import '../../Services/cart_api_provider.dart';
import '../BottomSheet/bottom_sheet.dart';
import '../ui_helper.dart';
import '../veg_badge_view.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool? selectedProductType = false;

  @override
  void initState() {
    context.read<RestaurantDetailsAPIProvider>().initialize();
    context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        "3");
    super.initState();
  }

  restypevalue(String value) {
    context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      bottomSheet: BottomCartSheet(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(child: body()),
    );
  }

  body() {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);

    if (restaurantDetailsAPIProvider.ifLoading) {
      return Center(
        child: Utils.showLoading(),
      );
    } else if (restaurantDetailsAPIProvider.error) {
      return Utils.showErrorMessage(restaurantDetailsAPIProvider.errorMessage);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel != null &&
        restaurantDetailsAPIProvider.restaurantViewModel!.status == '0') {
      return Utils.showErrorMessage(
          restaurantDetailsAPIProvider.restaurantViewModel!.message!);
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            restaurantDetailsSection(),
            Visibility(
              visible: restaurantDetailsAPIProvider
                      .restaurantViewModel!.retailerlist!.foodType !=
                  "2",
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    visualDensity: VisualDensity(),
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    value: selectedProductType,
                    onChanged: (bool? value) {
                      selectedProductType = value;
                      if (selectedProductType == true) {
                        restypevalue("1");
                      } else {
                        restypevalue("3");
                      }
                    },
                  ),
                  Text(
                    "Veg Only",
                    style: CommonStyles.black12thin(),
                  ),
                ],
              ),
            ),
            RecommendedProductWidget(id: widget.id),
            CustomDividerView(dividerHeight: 10.0),
            OrderNowView(widget.id)
          ],
        ),
      );
    }
  }

  restaurantDetailsSection() {
    final restaurantDetailsProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.lightBlue,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: restaurantDetailsProvider
                                .restaurantViewModel!.retailerlist!.outletName!
                                .substring(0, 1)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),
                        TextSpan(
                            text: restaurantDetailsProvider
                                .restaurantViewModel!.retailerlist!.outletName!
                                .substring(
                                    1,
                                    restaurantDetailsProvider
                                        .restaurantViewModel!
                                        .retailerlist!
                                        .outletName!
                                        .length)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
                      ])),
                      // Text(
                      //   restaurantDetailsProvider
                      //       .restaurantViewModel!.retailerlist!.outletName!
                      //       .toUpperCase(),
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .subtitle2!
                      //       .copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            restaurantDetailsProvider
                                .restaurantViewModel!.retailerlist!.status!
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                  restaurantDetailsProvider.restaurantViewModel!.retailerlist!
                              .outletAddress! ==
                          ""
                      ? Text("Restaurant Address",
                          style: CommonStyles.black57S12W500())
                      /* : AnimatedTextKit(
                          animatedTexts: [
                            // isRepeatingAnimation: true,
                            ColorizeAnimatedText(
                              "${restaurantDetailsProvider.restaurantViewModel!.retailerlist!.outletAddress!}",
                              textStyle: CommonStyles.black57S12W500(),
                              textAlign: TextAlign.left,
                              colors: colorizeColors,
                            )
                          ],
                        ),*/
                      : Text(
                          restaurantDetailsProvider.restaurantViewModel!
                              .retailerlist!.outletAddress!,
                          style: CommonStyles.black57S12W500()),
                  UIHelper.verticalSpaceSmall(),
                  //    CustomDividerView(dividerHeight: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildVerticalStack(
                          context,
                          Icons.star,
                          restaurantDetailsProvider
                              .restaurantViewModel!.retailerlist!.rating!,
                          'Rating'),
                      _buildVerticalStack(
                          context,
                          Icons.add_road,
                          restaurantDetailsProvider
                              .restaurantViewModel!.retailerlist!.distance!,
                          'Distance'),
                      _buildVerticalStack(
                          context,
                          Icons.timer,
                          restaurantDetailsProvider
                              .restaurantViewModel!.retailerlist!.duration!,
                          'Delivery Time'),
                      // _buildVerticalStack(context, 'Rs150', 'For Two'),
                    ],
                  ),
                  //   CustomDividerView(dividerHeight: 1.0),
                  UIHelper.verticalSpaceMedium(),
                ],
              ),
              showDropDownSubOutler(),
              Column(
                children: restaurantDetailsProvider
                    .restaurantViewModel!.retailerlist!.offer!
                    .map(
                      (value) => _buildOfferTile(context,
                          '${value.percentage_amount} up to Rs.${value.up_to} | Use code ${value.coupon_name}'),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildOfferTile(BuildContext context, String desc) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.local_offer, color: Colors.red[600], size: 15.0),
            UIHelper.horizontalSpaceSmall(),
            Flexible(
              child: Text(
                desc,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13.0),
              ),
            )
          ],
        ),
      );

  _buildVerticalStack(
          BuildContext context, IconData icon, String title, String subtitle) =>
      Expanded(
        child: SizedBox(
          height: 60.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 15,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    flex: 1,
                    child: FittedBox(
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceExtraSmall(),
              Text(subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 13.0))
            ],
          ),
        ),
      );

  showDropDownSubOutler() {
    final restaurantDetailsProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    return Visibility(
      visible: restaurantDetailsProvider.restaurantViewModel!.subRetailerlist !=
              null &&
          restaurantDetailsProvider
                  .restaurantViewModel!.subRetailerlist!.length >
              0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Other Locations ",
              style: CommonStyles.black57S14(),
            ),
            SizedBox(
              height: 60,
              width: deviceWidth(context),
              child: DropdownButton(
                hint: restaurantDetailsProvider.restaurantViewModel!
                            .retailerlist!.outletAddress! ==
                        ""
                    ? Text(
                        "Address",
                        style: CommonStyles.black12(),
                      )
                    : Text(
                        restaurantDetailsProvider
                            .restaurantViewModel!.retailerlist!.outletAddress!,
                        style: CommonStyles.black12(),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                // value: ,
                items: restaurantDetailsProvider
                    .restaurantViewModel!.subRetailerlist!
                    .map(
                  (value) {
                    return DropdownMenuItem<SubRetailerlist>(
                      value: value,
                      child: SizedBox(
                        width: deviceWidth(context),
                        child: Wrap(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  value.outletAddress!,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: CommonStyles.black12(),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.red),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      restaurantDetailsProvider
                                          .restaurantViewModel!
                                          .retailerlist!
                                          .status!
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0,
                                              color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (SubRetailerlist? val) {
                  print("selected sub restaturant id  ------------    " +
                      val!.id!);
                  context.read<RestaurantDetailsAPIProvider>().initialize();
                  // setState(() {});
                  context
                      .read<RestaurantDetailsAPIProvider>()
                      .getRestaurantDetails(
                          val.id!,
                          SharedPreference.longitude.toString(),
                          SharedPreference.latitude.toString(),
                          "3");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedProductWidget extends StatefulWidget {
  const RecommendedProductWidget({Key? key, required this.id})
      : super(key: key);
  final String id;
  @override
  _RecommendedProductWidgetState createState() =>
      _RecommendedProductWidgetState();
}

class _RecommendedProductWidgetState extends State<RecommendedProductWidget> {
  restypevalue(String value) {
    context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  @override
  Widget build(BuildContext context) {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    if (restaurantDetailsAPIProvider.ifLoading) {
      return Center(
        child: Utils.showLoading(),
      );
    } else if (restaurantDetailsAPIProvider.error) {
      return Utils.showErrorMessage(restaurantDetailsAPIProvider.errorMessage);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel != null &&
        restaurantDetailsAPIProvider.restaurantViewModel!.status == '0') {
      return Utils.showErrorMessage(
          restaurantDetailsAPIProvider.restaurantViewModel!.message!);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel == null) {
      return Center(
        child: Utils.showLoading(),
      );
    } else {
      print("else part printing -- - - - - - - ");
      List<ProductList>? _productList =
          restaurantDetailsAPIProvider.restaurantViewModel!.productList;
      return _productList == null
          ? Center(
              child: Utils.showLoading(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Recommended',
                    style: CommonStyles.black57S14(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 190,
                  // color: Colors.indigoAccent,
                  width: deviceWidth(context),
                  child: ListView.builder(
                      primary: false,
                      itemCount: _productList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        final p = _productList[index];
                        return RecommendedProductViewWidget(
                            p: p, id: widget.id);
                      })),
                ),
              ],
            );
    }
  }
}

class AddonWidget extends StatefulWidget {
  const AddonWidget(
      {Key? key,
      // required this.isSelected,
      required this.index,
      required this.addOn,
      required this.p})
      : super(key: key);
  // final bool isSelected;
  final int index;
  final ProductList p;
  final AddOnData addOn;

  @override
  _AddonWidgetState createState() => _AddonWidgetState();
}

class _AddonWidgetState extends State<AddonWidget> {
  bool _isSelectedAddOn = false;

  @override
  void initState() {
    // TODO: implement initState
    _isSelectedAddOn = widget.addOn.cartStatus == "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Checkbox(
                    activeColor: Colors.green,
                    value: _isSelectedAddOn,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onChanged: (value) async {
                      if (value != null) {
                        print("The selected value" + value.toString());
                        if (value == true) {
                          setState(() {
                            _isSelectedAddOn = true; // setState(() {
                          });
                          await apiService.addProduct(
                              context, widget.addOn.id, "+1", "1",
                              snackbarMessage: "Addons selected",
                              productStatus: "2");
                        } else if (value == false) {
                          setState(() {
                            _isSelectedAddOn = false; // setState(() {
                          });
                          await apiService.addProduct(
                              context, widget.addOn.id, "-1", "0",
                              snackbarMessage: "Addons selected",
                              productStatus: "2");
                        }
                        context.read<CartListAPIProvider>().cartlist(
                            SharedPreference.latitude,
                            SharedPreference.longitude,
                            "");
                      }
                    },
                  ),
                ),
                Text(widget.addOn.menuName!),
              ],
            ),
            Row(
              children: [
                Text(" ₹ ${widget.addOn.salePrice}"), //Text
                Utils.getSizedBox(width: 10),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class RecommendedProductViewWidget extends StatefulWidget {
  const RecommendedProductViewWidget(
      {Key? key, required this.p, required this.id})
      : super(key: key);
  final ProductList p;
  final String id;
  @override
  _RecommendedProductViewWidgetState createState() =>
      _RecommendedProductViewWidgetState();
}

class _RecommendedProductViewWidgetState
    extends State<RecommendedProductViewWidget> {
  // List<AddOnData> addon = [];
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    print("Add on Status - -- - -  " + widget.p.adonStatus!);
    // if (widget.p.addonStatus == "1") {
    //   await apiServices.addonDetails(widget.p.id).then((value) {
    //     print("cart status  printitn");
    //     addon.forEach((element) {
    //       print("cart status ---" + element.cartStatus!);
    //       if (element.cartStatus == "1") {
    //         // _selectedAddons[index] = true;
    //         _selectedAddons.add(true);
    //       } else {
    //         _selectedAddons.add(false);
    //         // _selectedAddons[index] = false;
    //       }
    //       print("Add ones list  ----- " + element.cartStatus.toString());
    //     });
    //   });
    // }
  }

  bool isLoading = false;

  Future restypevalue(String value) async {
    await context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  setIsLoadingFalse() {
    isLoading = false;
  }

  checkAddOns() async {
    if (widget.p.adonStatus == "1") {
      await apiService.addonDetails(widget.p.id).then((value) {
        List<AddOnData> addon = ApiService.addonproductList!;
        print("ADD ones result  ---- -- -- - - " + addon.isNotEmpty.toString());

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    children: [
                      Text(
                        "Add-ons",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: addon.length,
                          itemBuilder: (context, index) {
                            print("RUNNING BUILD ------------");
                            return AddonWidget(
                                // isSelected: _selectedAddons[index],
                                index: index,
                                p: widget.p,
                                addOn: addon[index]);
                            // return Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: <Widget>[
                            //         Checkbox(
                            //           activeColor: Colors.green,
                            //           value: _selectedAddons[index],
                            //           onChanged: (value) {
                            //             if (value != null) {
                            //               print("The selected value" +
                            //                   value.toString());
                            //               setState(() {
                            //                 _selectedAddons[index] =
                            //                     value;
                            //               });
                            //             }
                            //             // if (this.value == true) {}
                            //             // print(
                            //             //     "checkbox +${this.value}");
                            //           },
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ), //SizedBox
                            //         Text(addon[index].menuName! + "  "),
                            //         Text(
                            //             "₹ ${addon[index].salePrice}"), //Text
                            //         SizedBox(width: 10), //SizedBox
                            //         /** Checkbox Widget **/
                            //         //Checkbox
                            //       ], //<Widget>[]
                            //     ),
                            //     TextButton(
                            //         onPressed: () {
                            //           apiServices
                            //               .addToCart(context,
                            //                   addon[index].id, "1", "1")
                            //               .then((value) => context
                            //                   .read<
                            //                       CartListAPIProvider>()
                            //                   .cartlist(
                            //                       SharedPreference
                            //                           .latitude,
                            //                       SharedPreference
                            //                           .longitude,
                            //                       ""));
                            //         },
                            //         child: Text(
                            //           "ADD",
                            //           style: TextStyle(
                            //               color: Colors.green),
                            //         )),
                            //   ],
                            // );
                          }),
                      CustomDividerView(dividerHeight: 10.0),
                      Builder(builder: (context) {
                        return Container(
                          alignment: Alignment.bottomLeft,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Select Addons",
                                    style: CommonStyles.whiteText12BoldW500(),
                                  ),
                                )
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Item total ',
                                //       style:
                                //           TextStyle(color: Colors.white),
                                //     ),
                                //     Text(
                                //       "${}",
                                //       style:
                                //           TextStyle(color: Colors.white),
                                //     ),
                                //   ],
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //         context, 'CartScreen');
                                //   },
                                //   child: Text(
                                //     "VIEW CART",
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      }),
                      CustomDividerView(dividerHeight: 10.0),
                    ],
                  ),
                );
              });
            });

        // else {
        //   final snackBar = SnackBar(
        //     backgroundColor: Colors.green,
        //     content: Row(
        //       children: [
        //         Text('Items added '),
        //         Text('Rs.${widget.salesprice}'),
        //       ],
        //     ),
        //     action: SnackBarAction(
        //       label: 'View',
        //       onPressed: () {
        //         Navigator.pushReplacementNamed(context, 'CartScreen');
        //       },
        //     ),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      });
    }
  }

  addButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        //   print(ApiService.userId! + "------" + widget.p.id! + " - - --  -- -");
        await apiService
            .addToCart(context, widget.p.id, "+1", "1")
            .then((value) async {
          restypevalue("3");
          setState(() {
            isLoading = false;
          });
          if (value != 'no') {
            checkAddOns();
          }

          context.read<CartListAPIProvider>().cartlist(
              SharedPreference.latitude, SharedPreference.longitude, "");
        });
        // apiServices.addonDetails(widget.id).then((value) {
        //  setState(() {
        //    if (value != null) {
        //      showModalBottomSheet(
        //          context: context,
        //          builder: (ctx) {
        //            return Padding(
        //              padding: const EdgeInsets.all(12.0),
        //              child: Wrap(
        //                children: [
        //                  Text(
        //                    "Add-ons",
        //                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //                  ),
        //                  ListView.builder(
        //                      shrinkWrap: true,
        //                      physics: ScrollPhysics(),
        //                      itemCount: addon.length,
        //                      itemBuilder: (context, index) {
        //                        return Padding(
        //                          padding: const EdgeInsets.all(8.0),
        //                          child: Row(
        //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                            children: [
        //                              Row(
        //                                children: [
        //                                  Text(addon[index].menu_name + "  "),
        //                                  Text("Rs.${addon[index].sale_price}"),
        //                                ],
        //                              ),
        //                              AddBtnView(id: addon[index].id, salesprice: addon[index].sale_price),
        //                            ],
        //                          ),
        //                        );
        //                      }),
        //                  Container(
        //                    alignment: Alignment.bottomLeft,
        //                    color: Colors.green,
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(8.0),
        //                      child: Row(
        //                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                        children: [
        //                          Row(
        //                            children: [
        //                              Text(
        //                                'Items added ',
        //                                style: TextStyle(color: Colors.white),
        //                              ),
        //                              Text(
        //                                'Rs.${widget.salesprice}',
        //                                style: TextStyle(color: Colors.white),
        //                              ),
        //                            ],
        //                          ),
        //                          InkWell(
        //                            onTap: () {
        //                              Navigator.pushReplacementNamed(context, 'CartScreen');
        //                            },
        //                            child: Text(
        //                              "View",
        //                              style: TextStyle(color: Colors.white),
        //                            ),
        //                          )
        //                        ],
        //                      ),
        //                    ),
        //                  )
        //                ],
        //              ),
        //            );
        //          });
        //      apiServices.addToCart(context, widget.id, "1", "1").then((value) {
        //        print(value['status']);
        //        if (value['status'] == "1") {
        //          final snackBar = SnackBar(
        //            backgroundColor: Colors.green,
        //            content: Row(
        //              children: [
        //                Text('Items added '),
        //                Text('Rs.${widget.salesprice}'),
        //              ],
        //            ),
        //            action: SnackBarAction(
        //              label: 'View',
        //              onPressed: () {
        //                Navigator.pushReplacementNamed(context, 'CartScreen');
        //              },
        //            ),
        //          );
        //          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //        }
        //      });
        //    }
        //  });
        // });
      },
      child: Container(
        height: 25,
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            gradient: RadialGradient(colors: [
              Colors.lightBlue.withOpacity(0.8),
              Colors.blue.withOpacity(0.8)
            ])),
        child: Center(
          child: isLoading
              ? Utils.showLoadingFittedBox()
              : Text(
                  'ADD',
                  style: CommonStyles.whiteText10BoldW400(),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    if (restaurantDetailsAPIProvider.ifLoading) {
      return SizedBox(
        height: 110,
        width: 130,
        child: Center(
          child: Utils.showLoading(),
        ),
      );
    } else if (restaurantDetailsAPIProvider.error) {
      return Utils.showErrorMessage(restaurantDetailsAPIProvider.errorMessage);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel != null &&
        restaurantDetailsAPIProvider.restaurantViewModel!.status == '0') {
      return Utils.showErrorMessage(
          restaurantDetailsAPIProvider.restaurantViewModel!.message!);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel == null) {
      return Center(
        child: Utils.showLoading(),
      );
    }
    return Card(
      elevation: 4,
      shadowColor: Colors.lightBlue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.only(left: 4, top: 8),
        height: 110,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 80.0,
                width: 100.0,
                child: widget.p.menuImage!.first != ""
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: cachedNetworkImage(
                            80,
                            100,
                            restaurantDetailsAPIProvider
                                    .restaurantViewModel!.productBaseurl! +
                                widget.p.menuImage!.first))
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        height: 80.0,
                        width: 100.0,
                        child: cachedNetworkImage(
                          80,
                          100,
                          "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                        )),
              ),
            ),
            Utils.getSizedBox(height: 5),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpaceExtraSmall(),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: <Widget>[
                      widget.p.foodType == "1"
                          ? VegBadgeView()
                          : NonVegBadgeView(),
                      UIHelper.horizontalSpaceExtraSmall(),
                      Flexible(
                        child: Text(
                          widget.p.menuName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Utils.getSizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("₹ " + widget.p.salePrice!,
                          style: CommonStyles.black12thin()),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: widget.p.mrp != "",
                        child: Text("₹ " + widget.p.mrp!,
                            style: CommonStyles.black10LineThrough()),
                      ),
                    ],
                  ),
                ),
                Utils.getSizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    restaurantDetailsAPIProvider
                                .restaurantViewModel!.retailerlist!.status !=
                            "close"
                        ? widget.p.status != 1
                            ? Align(
                                alignment: Alignment.center, child: addButton()

                                // AddBtnView(
                                //   isLoading: setIsLoadingFalse,
                                //   loading: isLoading,
                                //   id: widget.p.id,
                                //   index: 1,
                                //   menuname: widget.p.menuName,
                                //   salesprice: widget.p.salePrice,
                                //   post: () {
                                //     restypevalue('3');
                                //   },
                                // ),
                                )
                            : Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 25,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      gradient: RadialGradient(colors: [
                                        Colors.lightBlue.withOpacity(0.8),
                                        Colors.blue.withOpacity(0.8)
                                      ])),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Icon(FontAwesomeIcons.minus,
                                              size: 18, color: Colors.white),
                                        ),
                                        onTap: () async {
                                          if (widget.p.cartDetails == "1") {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            apiService
                                                .addToCart(context, widget.p.id,
                                                    "-1", "0")
                                                .then((value) {
                                              restypevalue('3').then((value) {
                                                context
                                                    .read<CartListAPIProvider>()
                                                    .cartlist(
                                                        SharedPreference
                                                            .latitude,
                                                        SharedPreference
                                                            .longitude,
                                                        "");
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            apiService
                                                .addToCart(context, widget.p.id,
                                                    "-1", "1")
                                                .then((value) {
                                              restypevalue('3').then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                              context
                                                  .read<CartListAPIProvider>()
                                                  .cartlist(
                                                      SharedPreference.latitude,
                                                      SharedPreference
                                                          .longitude,
                                                      "")
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      isLoading
                                          ? SizedBox(
                                              height: 14,
                                              width: 14,
                                              child: Center(
                                                child: Utils
                                                    .showLoadingFittedBox(),
                                              ),
                                            )
                                          : widget.p.cartDetails == ""
                                              ? Text(
                                                  "0",
                                                  style: CommonStyles
                                                      .whiteText12BoldW500(),
                                                )
                                              : Text(
                                                  "${widget.p.cartDetails}",
                                                  style: CommonStyles
                                                      .whiteText12BoldW500(),
                                                ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Icon(Icons.add,
                                            color: Colors.white),
                                        onTap: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if (widget.p.adonStatus == "1") {
                                            showRepeatChooseDialog()
                                                .whenComplete(() {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else {
                                            apiService
                                                .addToCart(context, widget.p.id,
                                                    "+1", "1")
                                                .then((value) {
                                              restypevalue('3').then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                              context
                                                  .read<CartListAPIProvider>()
                                                  .cartlist(
                                                      SharedPreference.latitude,
                                                      SharedPreference
                                                          .longitude,
                                                      "")
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        : Align(
                            // bottom: -4,
                            // left: 15,
                            alignment: Alignment.center,

                            child: Container(
                              height: 25,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.grey),
                              child: Center(
                                child: Text(
                                  'ADD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future showRepeatChooseDialog() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Builder(builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "What would you like to do with add-ons?",
                        style: CommonStyles.black12(),
                      ),
                    ),
                    Utils.getSizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              //
                              showAddOnDialog();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              // decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.blue, width: 0.5)

                              // )
                              elevation: 12,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "I'll Choose Add-ons",
                                    style: CommonStyles.black12thin(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await apiService
                                  .addToCart(context, widget.p.id, "+1", "1")
                                  .then((value) async {
                                restypevalue('3').then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                context
                                    .read<CartListAPIProvider>()
                                    .cartlist(SharedPreference.latitude,
                                        SharedPreference.longitude, "")
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              });
                              Navigator.of(context).pop();
                              setState(() {
                                isLoading = false;
                              });
                              //Repeat code\
                            },
                            child: Card(
                              elevation: 12,
                              // decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.blue, width: 0.5)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Repeat Add-ons",
                                      style: CommonStyles.black12thin()),
                                ),
                              ),
                            ),
                          )
                        ]),
                    Utils.getSizedBox(height: 20),
                  ],
                ),
              ),
            );

            // return Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Wrap(
            //     children: [
            //       Text(
            //         "Add-ons",
            //         style: TextStyle(
            //             fontSize: 15, fontWeight: FontWeight.bold),
            //       ),
            //       ListView.builder(
            //           shrinkWrap: true,
            //           physics: ScrollPhysics(),
            //           itemCount: addon.length,
            //           itemBuilder: (context, index) {
            //             print("RUNNING BUILD ------------");
            //             return AddonWidget(
            //                 // isSelected: _selectedAddons[index],
            //                 index: index,
            //                 p: widget.p,
            //                 addOn: addon[index]);
            //             // return Row(
            //             //   mainAxisAlignment:
            //             //       MainAxisAlignment.spaceBetween,
            //             //   children: [
            //             //     Row(
            //             //       children: <Widget>[
            //             //         Checkbox(
            //             //           activeColor: Colors.green,
            //             //           value: _selectedAddons[index],
            //             //           onChanged: (value) {
            //             //             if (value != null) {
            //             //               print("The selected value" +
            //             //                   value.toString());
            //             //               setState(() {
            //             //                 _selectedAddons[index] =
            //             //                     value;
            //             //               });
            //             //             }
            //             //             // if (this.value == true) {}
            //             //             // print(
            //             //             //     "checkbox +${this.value}");
            //             //           },
            //             //         ),
            //             //         SizedBox(
            //             //           width: 10,
            //             //         ), //SizedBox
            //             //         Text(addon[index].menuName! + "  "),
            //             //         Text(
            //             //             "₹ ${addon[index].salePrice}"), //Text
            //             //         SizedBox(width: 10), //SizedBox
            //             //         /** Checkbox Widget **/
            //             //         //Checkbox
            //             //       ], //<Widget>[]
            //             //     ),
            //             //     TextButton(
            //             //         onPressed: () {
            //             //           apiServices
            //             //               .addToCart(context,
            //             //                   addon[index].id, "1", "1")
            //             //               .then((value) => context
            //             //                   .read<
            //             //                       CartListAPIProvider>()
            //             //                   .cartlist(
            //             //                       SharedPreference
            //             //                           .latitude,
            //             //                       SharedPreference
            //             //                           .longitude,
            //             //                       ""));
            //             //         },
            //             //         child: Text(
            //             //           "ADD",
            //             //           style: TextStyle(
            //             //               color: Colors.green),
            //             //         )),
            //             //   ],
            //             // );
            //           }),
            //       CustomDividerView(dividerHeight: 10.0),
            //       Builder(builder: (context) {
            //         return Container(
            //           alignment: Alignment.bottomLeft,
            //           color: Colors.green,
            //           child: Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: Row(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.center,
            //               children: [
            //                 InkWell(
            //                   onTap: () {
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text(
            //                     "Select Addons",
            //                     style: CommonStyles
            //                         .whiteText12BoldW500(),
            //                   ),
            //                 )
            //                 // Row(
            //                 //   children: [
            //                 //     Text(
            //                 //       'Item total ',
            //                 //       style:
            //                 //           TextStyle(color: Colors.white),
            //                 //     ),
            //                 //     Text(
            //                 //       "${}",
            //                 //       style:
            //                 //           TextStyle(color: Colors.white),
            //                 //     ),
            //                 //   ],
            //                 // ),
            //                 // InkWell(
            //                 //   onTap: () {
            //                 //     Navigator.pushNamed(
            //                 //         context, 'CartScreen');
            //                 //   },
            //                 //   child: Text(
            //                 //     "VIEW CART",
            //                 //     style: TextStyle(color: Colors.white),
            //                 //   ),
            //                 // )
            //               ],
            //             ),
            //           ),
            //         );
            //       }),
            //       CustomDividerView(dividerHeight: 10.0),
            //     ],
            //   ),
            // );
          });
        });

    // else {
    //   final snackBar = SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Row(
    //       children: [
    //         Text('Items added '),
    //         Text('Rs.${widget.salesprice}'),
    //       ],
    //     ),
    //     action: SnackBarAction(
    //       label: 'View',
    //       onPressed: () {
    //         Navigator.pushReplacementNamed(context, 'CartScreen');
    //       },
    //     ),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  showAddOnDialog() async {
    await apiService
        .addToCart(context, widget.p.id, "+1", "1")
        .then((value) async {
      restypevalue("3");
      setState(() {
        isLoading = false;
      });
      if (value != 'no') {
        if (widget.p.adonStatus == "1") {
          await apiService.addonDetails(widget.p.id).then((value) {
            List<AddOnData> addon = ApiService.addonproductList!;
            print("ADD ones result  ---- -- -- - - " +
                addon.isNotEmpty.toString());

            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        children: [
                          Text(
                            "Add-ons",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: addon.length,
                              itemBuilder: (context, index) {
                                print("RUNNING BUILD ------------");
                                return AddonWidget(
                                    // isSelected: _selectedAddons[index],
                                    index: index,
                                    p: widget.p,
                                    addOn: addon[index]);
                                // return Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: <Widget>[
                                //         Checkbox(
                                //           activeColor: Colors.green,
                                //           value: _selectedAddons[index],
                                //           onChanged: (value) {
                                //             if (value != null) {
                                //               print("The selected value" +
                                //                   value.toString());
                                //               setState(() {
                                //                 _selectedAddons[index] =
                                //                     value;
                                //               });
                                //             }
                                //             // if (this.value == true) {}
                                //             // print(
                                //             //     "checkbox +${this.value}");
                                //           },
                                //         ),
                                //         SizedBox(
                                //           width: 10,
                                //         ), //SizedBox
                                //         Text(addon[index].menuName! + "  "),
                                //         Text(
                                //             "₹ ${addon[index].salePrice}"), //Text
                                //         SizedBox(width: 10), //SizedBox
                                //         /** Checkbox Widget **/
                                //         //Checkbox
                                //       ], //<Widget>[]
                                //     ),
                                //     TextButton(
                                //         onPressed: () {
                                //           apiServices
                                //               .addToCart(context,
                                //                   addon[index].id, "1", "1")
                                //               .then((value) => context
                                //                   .read<
                                //                       CartListAPIProvider>()
                                //                   .cartlist(
                                //                       SharedPreference
                                //                           .latitude,
                                //                       SharedPreference
                                //                           .longitude,
                                //                       ""));
                                //         },
                                //         child: Text(
                                //           "ADD",
                                //           style: TextStyle(
                                //               color: Colors.green),
                                //         )),
                                //   ],
                                // );
                              }),
                          CustomDividerView(dividerHeight: 10.0),
                          Builder(builder: (context) {
                            return Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Select Addons",
                                        style:
                                            CommonStyles.whiteText12BoldW500(),
                                      ),
                                    )
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       'Item total ',
                                    //       style:
                                    //           TextStyle(color: Colors.white),
                                    //     ),
                                    //     Text(
                                    //       "${}",
                                    //       style:
                                    //           TextStyle(color: Colors.white),
                                    //     ),
                                    //   ],
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.pushNamed(
                                    //         context, 'CartScreen');
                                    //   },
                                    //   child: Text(
                                    //     "VIEW CART",
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }),
                          CustomDividerView(dividerHeight: 10.0),
                        ],
                      ),
                    );
                  });
                });

            // else {
            //   final snackBar = SnackBar(
            //     backgroundColor: Colors.green,
            //     content: Row(
            //       children: [
            //         Text('Items added '),
            //         Text('Rs.${widget.salesprice}'),
            //       ],
            //     ),
            //     action: SnackBarAction(
            //       label: 'View',
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, 'CartScreen');
            //       },
            //     ),
            //   );
            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // }
          });
        }
      }

      context
          .read<CartListAPIProvider>()
          .cartlist(SharedPreference.latitude, SharedPreference.longitude, "");
    });
  }
}

class CategoryProductsWidget extends StatefulWidget {
  const CategoryProductsWidget(
      {Key? key, required this.food, required this.id, required this.index})
      : super(key: key);
  final ProductList food;
  final String id;
  final int index;
  @override
  _CategoryProductsWidgetState createState() => _CategoryProductsWidgetState();
}

class _CategoryProductsWidgetState extends State<CategoryProductsWidget> {
  Future restypevalue(String value) async {
    await context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  final selectedProductType = false;

  bool isLoading = false;

  setIsLoadingFalse() {
    isLoading = false;
  }

  checkAddOns() async {
    if (widget.food.adonStatus == "1") {
      await apiService.addonDetails(widget.food.id).then((value) {
        List<AddOnData> addon = ApiService.addonproductList!;
        print("ADD ones result  ---- -- -- - - " + addon.isNotEmpty.toString());
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    children: [
                      Text(
                        "Add-ons",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: addon.length,
                          itemBuilder: (context, index) {
                            print("RUNNING BUILD ------------");
                            return AddonWidget(
                                // isSelected: _selectedAddons[index],
                                index: index,
                                p: widget.food,
                                addOn: addon[index]);
                            // return Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: <Widget>[
                            //         Checkbox(
                            //           activeColor: Colors.green,
                            //           value: _selectedAddons[index],
                            //           onChanged: (value) {
                            //             if (value != null) {
                            //               print("The selected value" +
                            //                   value.toString());
                            //               setState(() {
                            //                 _selectedAddons[index] =
                            //                     value;
                            //               });
                            //             }
                            //             // if (this.value == true) {}
                            //             // print(
                            //             //     "checkbox +${this.value}");
                            //           },
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ), //SizedBox
                            //         Text(addon[index].menuName! + "  "),
                            //         Text(
                            //             "₹ ${addon[index].salePrice}"), //Text
                            //         SizedBox(width: 10), //SizedBox
                            //         /** Checkbox Widget **/
                            //         //Checkbox
                            //       ], //<Widget>[]
                            //     ),
                            //     TextButton(
                            //         onPressed: () {
                            //           apiServices
                            //               .addToCart(context,
                            //                   addon[index].id, "1", "1")
                            //               .then((value) => context
                            //                   .read<
                            //                       CartListAPIProvider>()
                            //                   .cartlist(
                            //                       SharedPreference
                            //                           .latitude,
                            //                       SharedPreference
                            //                           .longitude,
                            //                       ""));
                            //         },
                            //         child: Text(
                            //           "ADD",
                            //           style: TextStyle(
                            //               color: Colors.green),
                            //         )),
                            //   ],
                            // );
                          }),
                      CustomDividerView(dividerHeight: 10.0),
                      Builder(builder: (context) {
                        return Container(
                          alignment: Alignment.bottomLeft,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Select Addons",
                                    style: CommonStyles.whiteText12BoldW500(),
                                  ),
                                )
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Item total ',
                                //       style:
                                //           TextStyle(color: Colors.white),
                                //     ),
                                //     Text(
                                //       "${}",
                                //       style:
                                //           TextStyle(color: Colors.white),
                                //     ),
                                //   ],
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //         context, 'CartScreen');
                                //   },
                                //   child: Text(
                                //     "VIEW CART",
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      }),
                      CustomDividerView(dividerHeight: 10.0),
                    ],
                  ),
                );
              });
            });

        // else {
        //   final snackBar = SnackBar(
        //     backgroundColor: Colors.green,
        //     content: Row(
        //       children: [
        //         Text('Items added '),
        //         Text('Rs.${widget.salesprice}'),
        //       ],
        //     ),
        //     action: SnackBarAction(
        //       label: 'View',
        //       onPressed: () {
        //         Navigator.pushReplacementNamed(context, 'CartScreen');
        //       },
        //     ),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      });
    }
  }

  addButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isLoading = true;
        });
        print(
            ApiServices.userId! + "------" + widget.food.id! + " - - --  -- -");
        apiService.addToCart(context, widget.food.id, "+1", "1").then((value) {
          restypevalue(selectedProductType == true ? "1" : "3");

          setState(() {
            isLoading = false;
          });
          if (value != "no") {
            checkAddOns();
            // apiServices.addonDetails(widget.id).then((value) {
            //   List<AddOnData> addon = ApiServices.addonproductList!;
            //   if (addon.isNotEmpty) {
            //     showModalBottomSheet(
            //         context: context,
            //         builder: (context) {
            //           return Padding(
            //             padding: const EdgeInsets.all(12.0),
            //             child: Wrap(
            //               children: [
            //                 Text(
            //                   "Add-ons",
            //                   style: TextStyle(
            //                       fontSize: 15, fontWeight: FontWeight.bold),
            //                 ),
            //                 ListView.builder(
            //                     shrinkWrap: true,
            //                     physics: ScrollPhysics(),
            //                     itemCount: addon.length,
            //                     itemBuilder: (context, index) {
            //                       // dynamic sum = widget.salesprice + addon[index].sale_price;
            //                       // String result = sum.toString();
            //                       // print("resultaddvalue +${result}");
            //                       return AddonWidget(
            //                           // isSelected: _selectedAddons[index],
            //                           index: index,
            //                           p: widget.food,
            //                           addOn: addon[index]);
            //                       // return Padding(
            //                       //   padding: const EdgeInsets.all(8.0),
            //                       //   child: Row(
            //                       //     mainAxisAlignment:
            //                       //         MainAxisAlignment.spaceBetween,
            //                       //     children: [
            //                       //       Row(
            //                       //         children: <Widget>[
            //                       //           Checkbox(
            //                       //             activeColor: Colors.green,
            //                       //             value: _selectedAddons[index],
            //                       //             onChanged: (value) {
            //                       //               if (value != null) {
            //                       //                 _selectedAddons[index] =
            //                       //                     value;
            //                       //               }
            //                       //               // if (this.value == true) {}
            //                       //               // print(
            //                       //               //     "checkbox +${this.value}");
            //                       //             },
            //                       //           ),
            //                       //           SizedBox(
            //                       //             width: 10,
            //                       //           ), //SizedBox
            //                       //           Text(addon[index].menuName! + "  "),
            //                       //           Text(
            //                       //               "Rs.${addon[index].salePrice}"), //Text
            //                       //           SizedBox(width: 10), //SizedBox
            //                       //           /** Checkbox Widget **/
            //                       //           //Checkbox
            //                       //         ], //<Widget>[]
            //                       //       ),
            //                       //       TextButton(
            //                       //           onPressed: () {
            //                       //             apiServices
            //                       //                 .addToCart(context,
            //                       //                     addon[index].id, "1", "1")
            //                       //                 .then((value) => context
            //                       //                     .read<
            //                       //                         CartListAPIProvider>()
            //                       //                     .cartlist(
            //                       //                         SharedPreference
            //                       //                             .latitude,
            //                       //                         SharedPreference
            //                       //                             .longitude,
            //                       //                         ""));
            //                       //           },
            //                       //           child: Text(
            //                       //             "ADD",
            //                       //             style: TextStyle(
            //                       //                 color: Colors.green),
            //                       //           )),
            //                       //     ],
            //                       //   ),
            //                       // );
            //                     }),
            //                 CustomDividerView(dividerHeight: 10.0),
            //                 Builder(builder: (context) {
            //                   return Container(
            //                     alignment: Alignment.bottomLeft,
            //                     color: Colors.green,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(15.0),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           InkWell(
            //                             onTap: () {
            //                               Navigator.of(context).pop();
            //                             },
            //                             child: Text(
            //                               "Select Addons",
            //                               style: CommonStyles
            //                                   .whiteText12BoldW500(),
            //                             ),
            //                           )
            //                           // Row(
            //                           //   children: [
            //                           //     Text(
            //                           //       'Item total ',
            //                           //       style:
            //                           //           TextStyle(color: Colors.white),
            //                           //     ),
            //                           //     Text(
            //                           //       "${}",
            //                           //       style:
            //                           //           TextStyle(color: Colors.white),
            //                           //     ),
            //                           //   ],
            //                           // ),
            //                           // InkWell(
            //                           //   onTap: () {
            //                           //     Navigator.pushNamed(
            //                           //         context, 'CartScreen');
            //                           //   },
            //                           //   child: Text(
            //                           //     "VIEW CART",
            //                           //     style: TextStyle(color: Colors.white),
            //                           //   ),
            //                           // )
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //                 CustomDividerView(dividerHeight: 10.0),
            //               ],
            //             ),
            //           );
            //         });
            //   }

            //   // else {
            //   //   final snackBar = SnackBar(
            //   //     backgroundColor: Colors.green,
            //   //     content: Row(
            //   //       children: [
            //   //         Text('Items added '),
            //   //         Text('Rs.${widget.salesprice}'),
            //   //       ],
            //   //     ),
            //   //     action: SnackBarAction(
            //   //       label: 'View',
            //   //       onPressed: () {
            //   //         Navigator.pushReplacementNamed(context, 'CartScreen');
            //   //       },
            //   //     ),
            //   //   );
            //   //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   // }
            // });
            context.read<CartListAPIProvider>().cartlist(
                SharedPreference.latitude, SharedPreference.longitude, "");
          }
        });
      },
      child: Container(
        height: 25,
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            gradient: RadialGradient(colors: [
              Colors.lightBlue.withOpacity(0.8),
              Colors.blue.withOpacity(0.8)
            ])),
        child: Center(
          child: isLoading
              ? Utils.showLoadingFittedBox()
              : Text(
                  'ADD',
                  style: CommonStyles.whiteText10BoldW400(),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    return Card(
      elevation: 10,
      shadowColor: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.food.foodType == "1"
                          ? VegBadgeView()
                          : NonVegBadgeView(),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.food.menuName!,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "₹ " + widget.food.salePrice!,
                        style: CommonStyles.black12thin(),
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Visibility(
                        visible: widget.food.mrp != "",
                        child: Text("₹ " + widget.food.mrp.toString(),
                            style: CommonStyles.black10LineThrough()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
                height: 100,
                width: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          //color: Colors.black,
                          // border: Border.all(
                          //     color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(8)),
                      height: 100,
                      width: 100,
                      child: Center(
                        child: widget.food.menuImage!.first != ""
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                height: 100.0,
                                width: 100.0,
                                child: cachedNetworkImage(
                                    100,
                                    100,
                                    restaurantDetailsAPIProvider
                                            .restaurantViewModel!
                                            .productBaseurl! +
                                        widget.food.menuImage!.first))
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                height: 100.0,
                                width: 100.0,
                                child: cachedNetworkImage(
                                  100,
                                  100,
                                  "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                                )),
                      ),
                    ),
                    Visibility(
                      visible: widget.food.discount != null &&
                          widget.food.discount != "" &&
                          !getWholeNumber(double.parse(widget.food.discount!)),
                      child: Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8)),
                                gradient: RadialGradient(
                                    colors: [Colors.yellow[900]!, Colors.red])),
                            child: FittedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                  "${double.parse(widget.food.discount!).floor()}% off",
                                  style: CommonStyles.whiteText8BoldW400()),
                            ))),
                      ),
                    ),
                    restaurantDetailsAPIProvider
                                .restaurantViewModel!.retailerlist!.status !=
                            "close"
                        ? widget.food.status == 0
                            ? Positioned(
                                left: 15, bottom: -4, child: addButton()
                                // AddBtnView(
                                //   isLoading: setIsLoadingFalse,
                                //   loading: isLoading,
                                //   id: widget.food.id,
                                //   index: widget.index,
                                //   salesprice: widget.food.salePrice,
                                //   menuname: '',
                                //   post: () {
                                //     restypevalue('3');
                                //   },
                                // ),
                                )
                            : Positioned(
                                bottom: -4,
                                child: Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      gradient: RadialGradient(colors: [
                                        Colors.lightBlue.withOpacity(0.8),
                                        Colors.blue.withOpacity(0.8)
                                      ])),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Icon(FontAwesomeIcons.minus,
                                              size: 18, color: Colors.white),
                                        ),
                                        onTap: () {
                                          if (widget.food.cartDetails == "1") {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            apiService
                                                .addToCart(context,
                                                    widget.food.id, "-1", "")
                                                .then((value) {
                                              restypevalue(
                                                      selectedProductType ==
                                                              true
                                                          ? "1"
                                                          : "3")
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                              context
                                                  .read<CartListAPIProvider>()
                                                  .cartlist(
                                                      SharedPreference.latitude,
                                                      SharedPreference
                                                          .longitude,
                                                      "");
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            apiService
                                                .addToCart(context,
                                                    widget.food.id, "-1", "1")
                                                .then((value) {
                                              restypevalue(
                                                      selectedProductType ==
                                                              true
                                                          ? "1"
                                                          : "3")
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                              context
                                                  .read<CartListAPIProvider>()
                                                  .cartlist(
                                                      SharedPreference.latitude,
                                                      SharedPreference
                                                          .longitude,
                                                      "");
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      isLoading
                                          ? SizedBox(
                                              height: 14,
                                              width: 14,
                                              child: Center(
                                                child: Utils
                                                    .showLoadingFittedBox(),
                                              ),
                                            )
                                          : widget.food.cartDetails == ""
                                              ? Text(
                                                  "0",
                                                  style: CommonStyles
                                                      .whiteText12BoldW500(),
                                                )
                                              : Text(
                                                  "${widget.food.cartDetails}",
                                                  style: CommonStyles
                                                      .whiteText12BoldW500(),
                                                ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Icon(Icons.add,
                                            color: Colors.white),
                                        onTap: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if (widget.food.adonStatus == "1") {
                                            showRepeatChooseDialog()
                                                .whenComplete(() {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else {
                                            apiService
                                                .addToCart(context,
                                                    widget.food.id, "+1", "1")
                                                .then((value) {
                                              restypevalue(
                                                      selectedProductType ==
                                                              true
                                                          ? "1"
                                                          : "3")
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                              context
                                                  .read<CartListAPIProvider>()
                                                  .cartlist(
                                                      SharedPreference.latitude,
                                                      SharedPreference
                                                          .longitude,
                                                      "");
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        : Positioned(
                            bottom: -4,
                            left: 15,
                            child: Container(
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.grey),
                              child: Center(
                                child: Text(
                                  'ADD',
                                  style: CommonStyles.whiteText12BoldW500(),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool getWholeNumber(double number) {
    if (number.floor() >= 0) {
      return true;
    }

    return false;
  }

  Future showRepeatChooseDialog() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Builder(builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "What would you like to do with add-ons?",
                        style: CommonStyles.black12(),
                      ),
                    ),
                    Utils.getSizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              //
                              showAddOnDialog();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              // decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.blue, width: 0.5)

                              // )
                              elevation: 12,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "I'll Choose Add-ons",
                                    style: CommonStyles.black12thin(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await apiService
                                  .addToCart(context, widget.food.id, "+1", "1")
                                  .then((value) async {
                                restypevalue("3");
                                context
                                    .read<CartListAPIProvider>()
                                    .cartlist(SharedPreference.latitude,
                                        SharedPreference.longitude, "")
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              });
                              Navigator.of(context).pop();
                              setState(() {
                                isLoading = false;
                              });
                              //Repeat code\
                            },
                            child: Card(
                              elevation: 12,
                              // decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.blue, width: 0.5)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Repeat Add-ons",
                                      style: CommonStyles.black12thin()),
                                ),
                              ),
                            ),
                          )
                        ]),
                    Utils.getSizedBox(height: 20),
                  ],
                ),
              ),
            );

            // return Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Wrap(
            //     children: [
            //       Text(
            //         "Add-ons",
            //         style: TextStyle(
            //             fontSize: 15, fontWeight: FontWeight.bold),
            //       ),
            //       ListView.builder(
            //           shrinkWrap: true,
            //           physics: ScrollPhysics(),
            //           itemCount: addon.length,
            //           itemBuilder: (context, index) {
            //             print("RUNNING BUILD ------------");
            //             return AddonWidget(
            //                 // isSelected: _selectedAddons[index],
            //                 index: index,
            //                 p: widget.p,
            //                 addOn: addon[index]);
            //             // return Row(
            //             //   mainAxisAlignment:
            //             //       MainAxisAlignment.spaceBetween,
            //             //   children: [
            //             //     Row(
            //             //       children: <Widget>[
            //             //         Checkbox(
            //             //           activeColor: Colors.green,
            //             //           value: _selectedAddons[index],
            //             //           onChanged: (value) {
            //             //             if (value != null) {
            //             //               print("The selected value" +
            //             //                   value.toString());
            //             //               setState(() {
            //             //                 _selectedAddons[index] =
            //             //                     value;
            //             //               });
            //             //             }
            //             //             // if (this.value == true) {}
            //             //             // print(
            //             //             //     "checkbox +${this.value}");
            //             //           },
            //             //         ),
            //             //         SizedBox(
            //             //           width: 10,
            //             //         ), //SizedBox
            //             //         Text(addon[index].menuName! + "  "),
            //             //         Text(
            //             //             "₹ ${addon[index].salePrice}"), //Text
            //             //         SizedBox(width: 10), //SizedBox
            //             //         /** Checkbox Widget **/
            //             //         //Checkbox
            //             //       ], //<Widget>[]
            //             //     ),
            //             //     TextButton(
            //             //         onPressed: () {
            //             //           apiServices
            //             //               .addToCart(context,
            //             //                   addon[index].id, "1", "1")
            //             //               .then((value) => context
            //             //                   .read<
            //             //                       CartListAPIProvider>()
            //             //                   .cartlist(
            //             //                       SharedPreference
            //             //                           .latitude,
            //             //                       SharedPreference
            //             //                           .longitude,
            //             //                       ""));
            //             //         },
            //             //         child: Text(
            //             //           "ADD",
            //             //           style: TextStyle(
            //             //               color: Colors.green),
            //             //         )),
            //             //   ],
            //             // );
            //           }),
            //       CustomDividerView(dividerHeight: 10.0),
            //       Builder(builder: (context) {
            //         return Container(
            //           alignment: Alignment.bottomLeft,
            //           color: Colors.green,
            //           child: Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: Row(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.center,
            //               children: [
            //                 InkWell(
            //                   onTap: () {
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text(
            //                     "Select Addons",
            //                     style: CommonStyles
            //                         .whiteText12BoldW500(),
            //                   ),
            //                 )
            //                 // Row(
            //                 //   children: [
            //                 //     Text(
            //                 //       'Item total ',
            //                 //       style:
            //                 //           TextStyle(color: Colors.white),
            //                 //     ),
            //                 //     Text(
            //                 //       "${}",
            //                 //       style:
            //                 //           TextStyle(color: Colors.white),
            //                 //     ),
            //                 //   ],
            //                 // ),
            //                 // InkWell(
            //                 //   onTap: () {
            //                 //     Navigator.pushNamed(
            //                 //         context, 'CartScreen');
            //                 //   },
            //                 //   child: Text(
            //                 //     "VIEW CART",
            //                 //     style: TextStyle(color: Colors.white),
            //                 //   ),
            //                 // )
            //               ],
            //             ),
            //           ),
            //         );
            //       }),
            //       CustomDividerView(dividerHeight: 10.0),
            //     ],
            //   ),
            // );
          });
        });

    // else {
    //   final snackBar = SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Row(
    //       children: [
    //         Text('Items added '),
    //         Text('Rs.${widget.salesprice}'),
    //       ],
    //     ),
    //     action: SnackBarAction(
    //       label: 'View',
    //       onPressed: () {
    //         Navigator.pushReplacementNamed(context, 'CartScreen');
    //       },
    //     ),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  showAddOnDialog() async {
    await apiService
        .addToCart(context, widget.food.id, "+1", "1")
        .then((value) async {
      restypevalue("3");
      setState(() {
        isLoading = false;
      });
      if (value != 'no') {
        if (widget.food.adonStatus == "1") {
          await apiService.addonDetails(widget.food.id).then((value) {
            List<AddOnData> addon = ApiService.addonproductList!;
            print("ADD ones result  ---- -- -- - - " +
                addon.isNotEmpty.toString());

            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        children: [
                          Text(
                            "Add-ons",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: addon.length,
                              itemBuilder: (context, index) {
                                print("RUNNING BUILD ------------");
                                return AddonWidget(
                                    // isSelected: _selectedAddons[index],
                                    index: index,
                                    p: widget.food,
                                    addOn: addon[index]);
                                // return Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: <Widget>[
                                //         Checkbox(
                                //           activeColor: Colors.green,
                                //           value: _selectedAddons[index],
                                //           onChanged: (value) {
                                //             if (value != null) {
                                //               print("The selected value" +
                                //                   value.toString());
                                //               setState(() {
                                //                 _selectedAddons[index] =
                                //                     value;
                                //               });
                                //             }
                                //             // if (this.value == true) {}
                                //             // print(
                                //             //     "checkbox +${this.value}");
                                //           },
                                //         ),
                                //         SizedBox(
                                //           width: 10,
                                //         ), //SizedBox
                                //         Text(addon[index].menuName! + "  "),
                                //         Text(
                                //             "₹ ${addon[index].salePrice}"), //Text
                                //         SizedBox(width: 10), //SizedBox
                                //         /** Checkbox Widget **/
                                //         //Checkbox
                                //       ], //<Widget>[]
                                //     ),
                                //     TextButton(
                                //         onPressed: () {
                                //           apiServices
                                //               .addToCart(context,
                                //                   addon[index].id, "1", "1")
                                //               .then((value) => context
                                //                   .read<
                                //                       CartListAPIProvider>()
                                //                   .cartlist(
                                //                       SharedPreference
                                //                           .latitude,
                                //                       SharedPreference
                                //                           .longitude,
                                //                       ""));
                                //         },
                                //         child: Text(
                                //           "ADD",
                                //           style: TextStyle(
                                //               color: Colors.green),
                                //         )),
                                //   ],
                                // );
                              }),
                          CustomDividerView(dividerHeight: 10.0),
                          Builder(builder: (context) {
                            return Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Select Addons",
                                        style:
                                            CommonStyles.whiteText12BoldW500(),
                                      ),
                                    )
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       'Item total ',
                                    //       style:
                                    //           TextStyle(color: Colors.white),
                                    //     ),
                                    //     Text(
                                    //       "${}",
                                    //       style:
                                    //           TextStyle(color: Colors.white),
                                    //     ),
                                    //   ],
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.pushNamed(
                                    //         context, 'CartScreen');
                                    //   },
                                    //   child: Text(
                                    //     "VIEW CART",
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }),
                          CustomDividerView(dividerHeight: 10.0),
                        ],
                      ),
                    );
                  });
                });

            // else {
            //   final snackBar = SnackBar(
            //     backgroundColor: Colors.green,
            //     content: Row(
            //       children: [
            //         Text('Items added '),
            //         Text('Rs.${widget.salesprice}'),
            //       ],
            //     ),
            //     action: SnackBarAction(
            //       label: 'View',
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, 'CartScreen');
            //       },
            //     ),
            //   );
            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // }
          });
        }
      }

      context
          .read<CartListAPIProvider>()
          .cartlist(SharedPreference.latitude, SharedPreference.longitude, "");
    });
  }
}

// class BrowseMenuFloatingActionButton extends StatefulWidget {
//   const BrowseMenuFloatingActionButton({Key? key}) : super(key: key);

//   @override
//   _BrowseMenuFloatingActionButtonState createState() =>
//       _BrowseMenuFloatingActionButtonState();
// }

// class _BrowseMenuFloatingActionButtonState
//     extends State<BrowseMenuFloatingActionButton> {
//   @override
//   Widget build(BuildContext context) {}
// }

class OrderNowView extends StatefulWidget {
  final String id;

  const OrderNowView(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  _OrderNowViewState createState() => _OrderNowViewState();
}

class _OrderNowViewState extends State<OrderNowView> {
  final List<String> images = [
    "assets/pizza-2487090_1920.jpg",
    "assets/salmon-518032_1920.jpg",
    "assets/beef-5466246_1920.jpg",
    "assets/images/food1.jpg",
    "assets/images/food2.jpg",
  ];
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  // Future? _post;

  ScrollController _controller = new ScrollController();
  TextEditingController searchController = TextEditingController();

  bool selectedProductType = false;

  // PageController? _pageController;

  // final dataKey = new GlobalKey();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  // List<TakeAwayModel>? foods = [];

  @override
  void initState() {
    super.initState();
    print("THe id is s-s--s-s-s-s-s-s- " + widget.id);
    _restypevalue("3");
  }

  _restypevalue(String value) {
    // final restaurantDetailsAPIProvider =
    //     Provider.of<RestaurantDetailsAPIProvider>(context);
    context.read<RestaurantDetailsAPIProvider>().initialize();
    context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        widget.id,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
    // print(restaurantDetailsAPIProvider.restaurantViewModel!.retailerlist);
    // print(restaurantDetailsAPIProvider.restaurantViewModel!.productBaseurl);
    // print(restaurantDetailsAPIProvider.restaurantViewModel!.browseMenu);
    // print(restaurantDetailsAPIProvider.restaurantViewModel!.categoryMenu);

    // setState(() {
    //   apiServices
    //       .getRestaurantDetail(widget.id, SharedPreference.latitudeValue,
    //           SharedPreference.longitudeValue, value)
    //       .then((value) {
    //     setState(() {
    //       retailerlist = ApiServices.retailerList;
    //     });
    //     setState(() {
    //       productList = ApiServices.productList;
    //     });
    //     setState(() {
    //       categorymodel = ApiServices.categoryMenu;
    //     });
    //     setState(() {
    //       browseMenu = ApiServices.browsemenu;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: _post,
    //     builder: (context, snapshot) {

    return successBody();

    // return restaurantDetailsAPIProvider.ifLoading
    //     ? Center(
    //         child: Utils.showLoading(),
    //       )
    //     : restaurantDetailsAPIProvider.error
    //         ? Utils.showErrorMessage(restaurantDetailsAPIProvider.errorMessage)
    //         : restaurantDetailsAPIProvider.restaurantViewModel == null ||
    //                 restaurantDetailsAPIProvider.restaurantViewModel!.status ==
    //                     "0"
    //             ? Utils.showErrorMessage(
    //                 restaurantDetailsAPIProvider.restaurantViewModel!.message!)
    //             :
    // // });
  }

  Widget successBody() {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    if (restaurantDetailsAPIProvider.ifLoading) {
      print("Loading Details");
      return Center(
        child: Utils.showLoading(),
      );
    } else if (restaurantDetailsAPIProvider.error) {
      print("Error Found");

      return Utils.showErrorMessage(restaurantDetailsAPIProvider.errorMessage);
    } else if (restaurantDetailsAPIProvider.restaurantViewModel != null &&
        restaurantDetailsAPIProvider.restaurantViewModel!.status == '0') {
      print("Status is 0");

      return Utils.showErrorMessage(
          restaurantDetailsAPIProvider.restaurantViewModel!.message!);
    } else {
      print("Success Status");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScrollablePositionedList.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            // key: dataKey,
            itemCount: restaurantDetailsAPIProvider
                .restaurantViewModel!.categoryMenu!.length,
            itemBuilder: (context, categoryIndex) {
              final categorymodel = restaurantDetailsAPIProvider
                  .restaurantViewModel!.categoryMenu;
              // for (int i = 0;
              //     i < categorymodel![index].productList!.length;
              //     i++) {
              //   print("Index  -- " + i.toString());
              // }
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment:
                  //     CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        // Text('Item $index'),
                        Text(
                          categorymodel![categoryIndex].categoryName!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                    ListView.builder(
                        itemCount:
                            categorymodel[categoryIndex].productList!.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, ind) {
                          final food =
                              categorymodel[categoryIndex].productList![ind];
                          return CategoryProductsWidget(
                              food: food, id: widget.id, index: ind);
                          // print("Category model product list length ----------" +
                          //     index.toString() +
                          //     "  - - -- - -  - -" +
                          //     categorymodel![index]
                          //         .productList!
                          //         .length
                          //         .toString());
                          // print(
                          //     "Hello world from category model  --------------" +
                          //         index.toString());
                          // categorymodel![index].productList!.forEach((e) {
                          //   print(e.id);
                          // });
                          // return Container();
                        }
                        //   //   // children: categorymodel![index]
                        //   //   //     .productList!
                        //   //   //     .map(
                        //   //   //       (e) =>
                        //   //   //     )
                        //   //   //     .toList(),
                        // ),
                        // Divider(
                        //   color: Colors.black12,
                        //   thickness: 1,
                        )
                  ],
                ),
              );
            },
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
          CustomDividerView(dividerHeight: 15.0),
          SizedBox(
            height: 50,
          )
          // _FoodListView(
          //   title: 'All Time Favourite',
          //   foods: RestaurantDetail.getAllTimeFavFoods(),
          // ),
          // CustomDividerView(dividerHeight: 15.0),
          // _FoodListView(
          //   title: 'Kozhukattaiyum & Paniyarams',
          //   foods: RestaurantDetail.getOtherDishes(),
          // )
        ],
      );
    }
  }

  // showDropDownSubOutler() {
  //   return Visibility(
  //     visible: subRetailerList != null && subRetailerList!.length > 1,
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10.0, right: 8),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Other Locations ",
  //             style: CommonStyles.black57S14(),
  //           ),
  //           SizedBox(
  //             height: 60,
  //             width: deviceWidth(context),
  //             child: DropdownButton(
  //               hint: retailerlist!.outletAddress! == ""
  //                   ? Text(
  //                       "Address",
  //                       style: CommonStyles.black12(),
  //                     )
  //                   : Text(
  //                       retailerlist!.outletAddress!,
  //                       style: CommonStyles.black12(),
  //                     ),
  //               isExpanded: true,
  //               iconSize: 30.0,
  //               style: TextStyle(color: Colors.blue),
  //               items: subRetailerList!.map(
  //                 (val) {
  //                   return DropdownMenuItem<SubRetailerlist>(
  //                     value: val,
  //                     child: SizedBox(
  //                       width: deviceWidth(context),
  //                       height: 50,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           FittedBox(
  //                             child: Text(
  //                               val.outletAddress!,
  //                               maxLines: 1,
  //                               style: CommonStyles.black12(),
  //                             ),
  //                           ),
  //                           SizedBox(height: 5),
  //                           Container(
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(5.0),
  //                                 color: Colors.red),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(2.0),
  //                               child: Text(
  //                                 retailerlist!.status!.toUpperCase(),
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .subtitle2!
  //                                     .copyWith(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 10.0,
  //                                         color: Colors.white),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ).toList(),
  //               onChanged: (SubRetailerlist? val) {
  //                 // setState(
  //                 //   () {
  //                 //     _dropDownValue = val;
  //                 //   },
  //                 // );
  //                 context.read<RestaurantDetailsAPIProvider>().initialize();
  //                 context
  //                     .read<RestaurantDetailsAPIProvider>()
  //                     .getRestaurantDetails(
  //                         val!.id!,
  //                         SharedPreference.longitude.toString(),
  //                         SharedPreference.latitude.toString(),
  //                         "3");
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Padding _buildOfferTile(BuildContext context, String desc) => Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Icon(Icons.local_offer, color: Colors.red[600], size: 15.0),
  //           UIHelper.horizontalSpaceSmall(),
  //           Flexible(
  //             child: Text(
  //               desc,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .bodyText1!
  //                   .copyWith(fontSize: 13.0),
  //             ),
  //           )
  //         ],
  //       ),
  //     );

  // Expanded _buildVerticalStack(
  //         BuildContext context, String title, String subtitle) =>
  //     Expanded(
  //       child: SizedBox(
  //         height: 60.0,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               title,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .subtitle2!
  //                   .copyWith(fontSize: 15.0),
  //             ),
  //             UIHelper.verticalSpaceExtraSmall(),
  //             Text(subtitle,
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .bodyText1!
  //                     .copyWith(fontSize: 13.0))
  //           ],
  //         ),
  //       ),
  //     );

  // Widget categoryList() {
  //   PageController? _pageController;
  //   return ListView(
  //     controller: _pageController,
  //     shrinkWrap: true,
  //     physics: ScrollPhysics(),
  //     children: categorymodel!.map((e) {
  //       return Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.all(10),
  //               child: Text(
  //                 e.categoryName!,
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .subtitle2!
  //                     .copyWith(fontSize: 18.0),
  //               ),
  //             ),
  //             // ListView.builder(
  //             //   shrinkWrap: true,
  //             //   itemCount: e.productList!.length,
  //             //   physics: NeverScrollableScrollPhysics(),
  //             //   itemBuilder: (context, index) => Container(
  //             //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //             //     child: Column(
  //             //       crossAxisAlignment: CrossAxisAlignment.start,
  //             //       children: <Widget>[
  //             //         UIHelper.verticalSpaceSmall(),
  //             //         Row(
  //             //           crossAxisAlignment: CrossAxisAlignment.start,
  //             //           children: <Widget>[
  //             //             e.productList![index].food_type == "1"
  //             //                 ? VegBadgeView()
  //             //                 : NonVegBadgeView(),
  //             //             UIHelper.horizontalSpaceMedium(),
  //             //             Expanded(
  //             //               child: Column(
  //             //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //             //                 children: <Widget>[
  //             //                   Text(
  //             //                     e.productList![index].menu_name!,
  //             //                     style: Theme.of(context).textTheme.bodyText1,
  //             //                   ),
  //             //                   UIHelper.verticalSpaceSmall(),
  //             //                   Row(
  //             //                     children: [
  //             //                       Text(
  //             //                           "Rs." +
  //             //                               e.productList![index].mrp
  //             //                                   .toString(),
  //             //                           style: Theme.of(context)
  //             //                               .textTheme
  //             //                               .subtitle1!
  //             //                               .copyWith(
  //             //                                   fontSize: 14.0,
  //             //                                   decoration: TextDecoration
  //             //                                       .lineThrough)),
  //             //                       UIHelper.horizontalSpaceMedium(),
  //             //                       Text(
  //             //                         "Rs ." +
  //             //                             e.productList![index].sale_price!,
  //             //                         style: Theme.of(context)
  //             //                             .textTheme
  //             //                             .bodyText1!
  //             //                             .copyWith(fontSize: 14.0),
  //             //                       ),
  //             //                     ],
  //             //                   ),

  //             //                   // if (foods[index].desc != null)
  //             //                   //   Text(
  //             //                   //     foods[index].desc,
  //             //                   //     maxLines: 2,
  //             //                   //     overflow: TextOverflow.ellipsis,
  //             //                   //     style: Theme.of(context).textTheme.bodyText1.copyWith(
  //             //                   //           fontSize: 12.0,
  //             //                   //           color: Colors.grey[500],
  //             //                   //         ),
  //             //                   //   ),
  //             //                 ],
  //             //               ),
  //             //             ),
  //             //             Stack(
  //             //               children: [
  //             //                 Image.network(
  //             //                   "https://foodieworlds.in/foodie//uploads/menu/e.productList[index].menu_image.first",
  //             //                   height: 80.0,
  //             //                   width: 80.0,
  //             //                   fit: BoxFit.cover,
  //             //                 ),
  //             //                 Positioned(
  //             //                   bottom: 0,
  //             //                   child: AddBtnView(
  //             //                     id: e.productList![index].id,
  //             //                     salesprice: e.productList![index].sale_price,
  //             //                     index: null,
  //             //                     menuname: '',
  //             //                     post: () {},
  //             //                   ),
  //             //                 ),
  //             //               ],
  //             //             )
  //             //           ],
  //             //         ),
  //             //       ],
  //             //     ),
  //             //   ),
  //             // )
  //           ],
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  // floatingActionButton() {
  //   return FloatingActionButton.extended(
  //     onPressed: () {
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           title: const Text('Varities'),
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(20))),
  //           scrollable: true,
  //           content: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: List.generate(
  //                 browseMenu!.length,
  //                 (index) => Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: InkWell(
  //                         onTap: () {
  //                           itemScrollController.scrollTo(
  //                               index: index,
  //                               duration: Duration(microseconds: 2),
  //                               curve: Curves.easeInOutCubic);

  //                           // itemScrollController.jumpTo(index: index);

  //                           // Scrollable.ensureVisible(dataKey.currentContext!);

  //                           Navigator.pop(context);
  //                         },
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             // Text(index.toString()),
  //                             Text(browseMenu![index].categoryName!),
  //                             Text(browseMenu![index].count.toString()),
  //                           ],
  //                         ),
  //                       ),
  //                     )),
  //           ),
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: [
  //             // OutlinedButton(
  //             //   onPressed: () => Navigator.pop(context),
  //             //   child: Text('I have done reading ✓'),
  //             // )
  //           ],
  //         ),
  //       );
  //     },
  //     label: const Text(
  //       'BROWSE MENU',
  //       style: TextStyle(color: Colors.white, fontSize: 13),
  //     ),
  //     icon: const Icon(
  //       Icons.restaurant,
  //       color: Colors.white,
  //       size: 18,
  //     ),
  //     backgroundColor: Colors.black87,
  //   );
  // }

  // _animateToIndex(i) => _controller.animateTo(24,
  //     duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
}

class CategoryMenu extends StatelessWidget {
  final List<CategoryMenuModel>? categorymodel;
  final String? categoryid;

  const CategoryMenu({Key? key, this.categorymodel, this.categoryid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: categorymodel!.map((e) {
        return Container(
          // color: Colors.yellowAccent,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  e.categoryName!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 18.0),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: e.productList!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          e.productList![index].foodType == "1"
                              ? VegBadgeView()
                              : NonVegBadgeView(),
                          UIHelper.horizontalSpaceMedium(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  e.productList![index].menuName!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                UIHelper.verticalSpaceSmall(),
                                Row(
                                  children: [
                                    Text(
                                        "Rs." +
                                            e.productList![index].mrp
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize: 14.0,
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                    UIHelper.horizontalSpaceMedium(),
                                    Text(
                                      "Rs ." + e.productList![index].salePrice!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 14.0),
                                    ),
                                  ],
                                ),

                                // if (foods[index].desc != null)
                                //   Text(
                                //     foods[index].desc,
                                //     maxLines: 2,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: Theme.of(context).textTheme.bodyText1.copyWith(
                                //           fontSize: 12.0,
                                //           color: Colors.grey[500],
                                //         ),
                                //   ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                    "https://foodieworlds.in/foodie//uploads/menu/${e.productList![index].menuImage!.first}",
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Positioned(
                                //   bottom: 0,
                                //   child: AddBtnView(
                                //     id: e.productList![index].id,
                                //     salesprice:
                                //         e.productList![index].sale_price,
                                //     index: index,
                                //     menuname: '',
                                //     post: () {},
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

class AddBtnView extends StatefulWidget {
  const AddBtnView(
      {Key? key,
      required this.id,
      required this.menuname,
      required this.index,
      required this.salesprice,
      required this.post,
      this.loading = false,
      required this.isLoading})
      : super(key: key);

  final String? id;
  final int? index;
  final bool loading;
  final Function isLoading;

  final String? menuname;
  final dynamic salesprice;
  final void Function() post;

  @override
  State<AddBtnView> createState() => _AddBtnViewState();
}

class _AddBtnViewState extends State<AddBtnView> {
  bool value = false;
  List<bool> _selectedAddons = [];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("indexindex + ${widget.index}");
        print("added");
        print("id+${widget.id}");
        apiService.addToCart(context, widget.id, "+1", "1").then((value) {
          widget.isLoading();
          widget.post();
          if (value['status'] == "1") {
            apiService.addonDetails(widget.id).then((value) {
              List<AddOnData> addon = ApiService.addonproductList!;
              if (addon.isNotEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Wrap(
                          children: [
                            Text(
                              "Add-ons",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: addon.length,
                                itemBuilder: (context, index) {
                                  addon.forEach((element) {
                                    if (element.cartStatus == "1") {
                                      _selectedAddons[index] = true;
                                    } else {
                                      _selectedAddons[index] = false;
                                    }
                                  });
                                  // dynamic sum = widget.salesprice + addon[index].sale_price;
                                  // String result = sum.toString();
                                  // print("resultaddvalue +${result}");
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                              activeColor: Colors.green,
                                              value: _selectedAddons[index],
                                              onChanged: (value) {
                                                if (value != null) {
                                                  _selectedAddons[index] =
                                                      value;
                                                }
                                                // if (this.value == true) {}
                                                // print(
                                                //     "checkbox +${this.value}");
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ), //SizedBox
                                            Text(addon[index].menuName! + "  "),
                                            Text(
                                                "Rs.${addon[index].salePrice}"), //Text
                                            SizedBox(width: 10), //SizedBox
                                            /** Checkbox Widget **/
                                            //Checkbox
                                          ], //<Widget>[]
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              apiService
                                                  .addToCart(
                                                      context,
                                                      addon[index].id,
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
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                      ],
                                    ),
                                  );
                                }),
                            CustomDividerView(dividerHeight: 10.0),
                            Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Item total ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${widget.salesprice}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'CartScreen');
                                      },
                                      child: Text(
                                        "VIEW CART",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CustomDividerView(dividerHeight: 10.0),
                          ],
                        ),
                      );
                    });
              }

              // else {
              //   final snackBar = SnackBar(
              //     backgroundColor: Colors.green,
              //     content: Row(
              //       children: [
              //         Text('Items added '),
              //         Text('Rs.${widget.salesprice}'),
              //       ],
              //     ),
              //     action: SnackBarAction(
              //       label: 'View',
              //       onPressed: () {
              //         Navigator.pushReplacementNamed(context, 'CartScreen');
              //       },
              //     ),
              //   );
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // }
            });
            context.read<CartListAPIProvider>().cartlist(
                SharedPreference.latitude, SharedPreference.longitude, "");
          }
        });
        // apiServices.addonDetails(widget.id).then((value) {
        //  setState(() {
        //    if (value != null) {
        //      showModalBottomSheet(
        //          context: context,
        //          builder: (ctx) {
        //            return Padding(
        //              padding: const EdgeInsets.all(12.0),
        //              child: Wrap(
        //                children: [
        //                  Text(
        //                    "Add-ons",
        //                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //                  ),
        //                  ListView.builder(
        //                      shrinkWrap: true,
        //                      physics: ScrollPhysics(),
        //                      itemCount: addon.length,
        //                      itemBuilder: (context, index) {
        //                        return Padding(
        //                          padding: const EdgeInsets.all(8.0),
        //                          child: Row(
        //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                            children: [
        //                              Row(
        //                                children: [
        //                                  Text(addon[index].menu_name + "  "),
        //                                  Text("Rs.${addon[index].sale_price}"),
        //                                ],
        //                              ),
        //                              AddBtnView(id: addon[index].id, salesprice: addon[index].sale_price),
        //                            ],
        //                          ),
        //                        );
        //                      }),
        //                  Container(
        //                    alignment: Alignment.bottomLeft,
        //                    color: Colors.green,
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(8.0),
        //                      child: Row(
        //                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                        children: [
        //                          Row(
        //                            children: [
        //                              Text(
        //                                'Items added ',
        //                                style: TextStyle(color: Colors.white),
        //                              ),
        //                              Text(
        //                                'Rs.${widget.salesprice}',
        //                                style: TextStyle(color: Colors.white),
        //                              ),
        //                            ],
        //                          ),
        //                          InkWell(
        //                            onTap: () {
        //                              Navigator.pushReplacementNamed(context, 'CartScreen');
        //                            },
        //                            child: Text(
        //                              "View",
        //                              style: TextStyle(color: Colors.white),
        //                            ),
        //                          )
        //                        ],
        //                      ),
        //                    ),
        //                  )
        //                ],
        //              ),
        //            );
        //          });
        //      apiServices.addToCart(context, widget.id, "1", "1").then((value) {
        //        print(value['status']);
        //        if (value['status'] == "1") {
        //          final snackBar = SnackBar(
        //            backgroundColor: Colors.green,
        //            content: Row(
        //              children: [
        //                Text('Items added '),
        //                Text('Rs.${widget.salesprice}'),
        //              ],
        //            ),
        //            action: SnackBarAction(
        //              label: 'View',
        //              onPressed: () {
        //                Navigator.pushReplacementNamed(context, 'CartScreen');
        //              },
        //            ),
        //          );
        //          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //        }
        //      });
        //    }
        //  });
        // });
      },
      child: Container(
        height: 25,
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            gradient: RadialGradient(colors: [
              Colors.lightBlue.withOpacity(0.8),
              Colors.blue.withOpacity(0.8)
            ])),
        child: Center(
          child: widget.loading
              ? Utils.showLoadingFittedBox()
              : Text(
                  'ADD',
                  style: CommonStyles.whiteText10BoldW400(),
                ),
        ),
      ),
    );
  }
}
