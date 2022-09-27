import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_check/animated_check.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Models/CartList.dart';
import 'package:mycityapp/Food/Models/UserModel.dart';
import 'package:mycityapp/Food/Models/place_order_model.dart';
import 'package:mycityapp/Food/Services/cart_api_provider.dart';
import 'package:mycityapp/Food/Services/firebase_auth_service.dart';
import 'package:mycityapp/Food/Services/ongoing_order_api.dart';
import 'package:mycityapp/Food/Services/profile_view_api_provider.dart';
import 'package:mycityapp/Food/pages/accountScreen/AccountScreen.dart';
import 'package:mycityapp/Food/pages/allRestaurantScreen/all_restaurants_screen.dart';
import 'package:mycityapp/Food/pages/changelocation.dart';
import 'package:mycityapp/Food/pages/skipLogin/personal_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import 'package:mycityapp/Food/pages/custom_divider_view.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/veg_badge_view.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:paytm/paytm.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import '../../CommonWidgets/common_styles.dart';
import '../../Services/login_api_provider.dart';
import '../../Services/restaurant_details_api_provider.dart';

class ModelCartScreen extends StatefulWidget {
  final dynamic couponCode;

  ModelCartScreen(this.couponCode);

  @override
  _ModelCartScreenState createState() => _ModelCartScreenState();
}

class _ModelCartScreenState extends State<ModelCartScreen> {
  dynamic payment_response,
      payment_response_status,
      order_id,
      tax_amount,
      tax_date_time,
      reference_no;

  bool _isAddressSelected = false;

  bool testing = false;

  bool loading = false;

  bool isSkipLogin = false;

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    if (context.read<CartListAPIProvider>().cartResponseModel == null) {
      context.read<CartListAPIProvider>().cartlist(SharedPreference.latitude,
          SharedPreference.longitude, widget.couponCode);
    }
    initialize();
  }

  initialize() async {
    setState(() {
      isSkipLogin = context.read<FirebaseAuthService>().isAnonymusSignIn();
    });

    print("Is skip Login  - - -- - - - - - - - - - - - " +
        isSkipLogin.toString());
  }

  @override
  Widget build(BuildContext context) {
    final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);
    // print("statue +${payment_response_status}");
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        bottomSheet: !isSkipLogin
            ? cartListAPIProvider.ifLoading ||
                    cartListAPIProvider.error ||
                    cartListAPIProvider.cartResponseModel == null ||
                    cartListAPIProvider.cartResponseModel!.productDetails ==
                        null ||
                    cartListAPIProvider
                            .cartResponseModel!.productDetails!.length ==
                        0
                ? SizedBox()
                : showSelfPickUpOrHomeDelivery()
            : addPersonalDetails(),
        body: cartListAPIProvider.ifLoading
            ? Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : cartListAPIProvider.error
                ? errorBody()
                : cartListAPIProvider.cartResponseModel == null ||
                        cartListAPIProvider.cartResponseModel!.productDetails ==
                            null ||
                        cartListAPIProvider
                                .cartResponseModel!.productDetails!.length ==
                            0
                    ? emptyCart()
                    : successBody(cartListAPIProvider.cartResponseModel!));
  }

  emptyCart() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          "https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-2130356-1800917.png",
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
        Text(
          "Your Cart is empty",
          style: TextStyle(
            color: darkOrange,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: .5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllRestaurantsScreen(storeType: "1"),
                ),
              );
            },
            child: Text("Browse Restaurants"),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  50,
                  35,
                ),
                primary: darkOrange),
          ),
        ),
      ],
    ));
  }

  errorBody() {
    final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);

    return Center(
      child: Text(
          "Error while fetching data + ${cartListAPIProvider.errorMessage}"),
    );
  }

  bool isLoading = false;

  Future restypevalue(String value) async {
    final cartListAPIProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    await context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        cartListAPIProvider.cartResponseModel!.retailerDetails!.first.id!,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  setIsLoadingFalse() {
    isLoading = false;
  }

  ScrollController _scrollController = ScrollController();

  Widget successBody(CartResponseModel cartResponseModel) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 11),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText("Cart",
                        textStyle: CommonStyles.black57S18(),
                        textAlign: TextAlign.right,
                        colors: colorizeColors)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                child: Text(
                  " For Delivery",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              // cartResponseModel.usedPromocode != null
              //     ? Padding(
              //         padding:
              //             const EdgeInsets.only(left: 20.0, top: 10, right: 10),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10.0),
              //               color: Colors.green.withOpacity(0.15)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 UIHelper.verticalSpaceSmall(),
              //                 Row(
              //                   children: [
              //                     Text(
              //                       "${cartResponseModel.discountAmt} ",
              //                       style: TextStyle(
              //                           color: Colors.green,
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                     Text(
              //                       "savings",
              //                       style: TextStyle(color: Colors.green),
              //                     ),
              //                   ],
              //                 ),
              //                 UIHelper.verticalSpaceSmall(),
              //                 Text(
              //                   "with  ${cartResponseModel.usedPromocode}  Coupon",
              //                   style: TextStyle(color: Colors.green),
              //                 ),
              //                 UIHelper.verticalSpaceSmall(),
              //               ],
              //             ),
              //           ),
              //         ),
              //       )
              //     : Container(),

              Card(
                // margin: EdgeInsets.symmetric(horizontal: 40),
                elevation: 10,
                shadowColor: Colors.blue,
                clipBehavior: Clip.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        cartResponseModel.retailerProfileurl! +
                            cartResponseModel
                                .retailerDetails!.first.outletImage!,
                        height: 110.0,
                        width: 110.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                                cartResponseModel
                                    .retailerDetails!.first.outletName!
                                    .toUpperCase(),
                                textStyle: CommonStyles.black57S14(),
                                textAlign: TextAlign.right,
                                colors: colorizeColors)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_road,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cartResponseModel
                                      .retailerDetails!.first.distance!,
                                  style: CommonStyles.black12thin(),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cartResponseModel
                                      .retailerDetails!.first.duration!,
                                  style: CommonStyles.black12thin(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: int.parse("5"
                              //  cartResponseModel.retailerDetails!.first.rating!
                              ),
                          size: 15,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  clipBehavior: Clip.none,
                  itemCount: cartResponseModel.productDetails!.length + 1,
                  itemBuilder: (context, index) {
                    print("Index --- " + index.toString());
                    return ProductListCartListWidget(
                      cartResponseModel: cartResponseModel,
                      index: index,
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: CustomDividerView(dividerHeight: 10.0),
              // ),
              // cartResponseModel.usedPromocode == null ||
              //         cartResponseModel.usedPromocode == ""
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 40.0),
              //         child: Card(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           elevation: 5,
              //           shadowColor: Colors.blue,
              //           child: InkWell(
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => PaymentOffersCouponView(
              //                       cartResponseModel.total.toString(), true),
              //                 ),
              //               );
              //             },
              //             child: Container(
              //               padding: const EdgeInsets.all(20.0),
              //               child: Row(
              //                 children: <Widget>[
              //                   Icon(Icons.local_offer,
              //                       size: 20.0, color: Colors.grey[700]),
              //                   UIHelper.horizontalSpaceMedium(),
              //                   Text(
              //                     'APPLY COUPON',
              //                     style: CommonStyles.black12thin(),
              //                   ),
              //                   Spacer(),
              //                   Icon(Icons.keyboard_arrow_right,
              //                       color: Colors.grey),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     : Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         elevation: 5,
              //         shadowColor: Colors.blue,
              //         child: Container(
              //           padding: const EdgeInsets.all(20.0),
              //           width: deviceWidth(context),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               Icon(Icons.stream,
              //                   size: 20.0, color: Colors.grey[700]),
              //               UIHelper.horizontalSpaceMedium(),
              //               Expanded(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Text(
              //                       cartResponseModel.usedPromocode!,
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .subtitle2!
              //                           .copyWith(fontSize: 16.0),
              //                     ),
              //                     UIHelper.verticalSpace(10),
              //                     Text(
              //                       "Offer applied on the bill",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .subtitle1!
              //                           .copyWith(fontSize: 13.0),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               GestureDetector(
              //                 onTap: () {
              //                   // setState(() {
              //                   context.read<CartListAPIProvider>().cartlist(
              //                       SharedPreference.latitude,
              //                       SharedPreference.longitude,
              //                       "");
              //                   // _post = apiServices.cartlist(
              //                   //     context,
              //                   //     SharedPreference.latitudeValue,
              //                   //     SharedPreference.longitudeValue,
              //                   //     "");
              //                   // });
              //                 },
              //                 child: Container(
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(20.0),
              //                         color: Colors.grey.withOpacity(0.5)),
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(2.0),
              //                       child: Icon(
              //                         Icons.clear,
              //                         color: Colors.white,
              //                         size: 15,
              //                       ),
              //                     )),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              // CustomDividerView(dividerHeight: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  // color: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  shadowColor: Colors.blue,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText("Bill Details",
                                    textStyle: CommonStyles.black57S18(),
                                    textAlign: TextAlign.right,
                                    colors: colorizeColors)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Item total', style: CommonStyles.black12()),
                            Text("Rs." + "${cartResponseModel.subTotal}",
                                style: CommonStyles.black12())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     InkWell(
                        //       onTap: () {
                        //         // buildDeliveryDialog(context, cartResponseModel);
                        //       },
                        //       child: Row(
                        //         children: <Widget>[
                        //           Text('Delivery Fee', style: textStyle),
                        //           UIHelper.horizontalSpaceSmall(),
                        //           Icon(Icons.info_outline, size: 14.0)
                        //         ],
                        //       ),
                        //     ),
                        //     Text("Rs." + "${cartResponseModel.deliveryFee}",
                        //         style: textStyle)
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Convenience Tax",
                        //       style: textStyle,
                        //     ),
                        //     Text(
                        //       cartResponseModel.consalationTax!,
                        //       style: textStyle,
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        InkWell(
                          onTap: () async {
                            await buildTaxDialog(context, cartResponseModel);
                          },
                          child: Row(
                            children: <Widget>[
                              Text('Taxes and Charges',
                                  style: CommonStyles.black12()),
                              UIHelper.horizontalSpaceSmall(),
                              Icon(Icons.info_outline, size: 14.0),
                              Spacer(),
                              Text(
                                "Rs." +
                                    (double.parse(cartResponseModel
                                                .consalationTax!) +
                                            double.parse(
                                                cartResponseModel.gstTax!) +
                                            double.parse(
                                                cartResponseModel.packingTax!))
                                        .toStringAsFixed(2),
                                style: CommonStyles.black12(),
                              )
                            ],
                          ),
                        ),

                        Visibility(
                          visible: cartResponseModel.deliveryStatus != null &&
                              cartResponseModel.deliveryStatus == "1",
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Delivery Charge',
                                      style: CommonStyles.black12()),
                                  Spacer(),
                                  Text(
                                    "Rs." +
                                        cartResponseModel.quickerDeliveryFees
                                            .toString(),
                                    style: CommonStyles.black12(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: cartResponseModel.deliveryStatus != null &&
                              cartResponseModel.deliveryStatus == "2",
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Delivery Charge',
                                      style: CommonStyles.black12()),
                                  Spacer(),
                                  Text(
                                    "Rs." +
                                        cartResponseModel.dunzoDeliveryFees
                                            .toString(),
                                    style: CommonStyles.black12(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Visibility(
                        //   visible: cartResponseModel.deliveryStatus != null &&
                        //       cartResponseModel.deliveryStatus == "2",
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: <Widget>[
                        //           Text('Delivery Charge',
                        //               style: CommonStyles.black12()),
                        //           Spacer(),
                        //           Text(
                        //             "Rs." +
                        //                 (int.parse(cartResponseModel
                        //                             .consalationTax!) +
                        //                         int.parse(
                        //                             cartResponseModel.gstTax!) +
                        //                         int.parse(cartResponseModel
                        //                             .packingTax!) +
                        //                         int.parse(
                        //                             cartResponseModel.carryBag!))
                        //                     .toString(),
                        //             style: CommonStyles.black12(),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        UIHelper.verticalSpaceMedium(),

                        _buildDivider(),
                        UIHelper.verticalSpaceMedium(),
                        Row(
                          children: <Widget>[
                            Text('To Pay', style: CommonStyles.black12()),
                            Spacer(),
                            Text("Rs." + "${cartResponseModel.total}",
                                style: CommonStyles.black12())
                          ],
                        ),
                        UIHelper.verticalSpaceLarge(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (_isAddressSelected)
                Visibility(
                    visible: _isAddressSelected,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.my_location_sharp,
                                    color: Colors.purple,
                                  ),
                                  Utils.getSizedBox(width: 10),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      ColorizeAnimatedText("Selected Location",
                                          textStyle: CommonStyles.black57S18(),
                                          textAlign: TextAlign.right,
                                          colors: colorizeColors)
                                    ],
                                  ),
                                ],
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.location_city),
                                title: Text(
                                  addressName(cartResponseModel
                                          .getAllAddressCustomer!
                                          .addressTypeId!)
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartResponseModel
                                        .getAllAddressCustomer!.address!),
                                    Text(cartResponseModel
                                        .getAllAddressCustomer!.landMark!),
                                    Visibility(
                                        visible: cartResponseModel
                                                .getAllAddressCustomer!.floor !=
                                            "",
                                        child: Text(cartResponseModel
                                            .getAllAddressCustomer!.floor!)),
                                    Visibility(
                                        visible: cartResponseModel
                                                .getAllAddressCustomer!.reach !=
                                            "",
                                        child: Text(cartResponseModel
                                            .getAllAddressCustomer!.reach!))
                                  ],
                                ),
                                // trailing: ,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

              SizedBox(
                height: 100,
              ),

              /*  Container(
                child: Column(
                  children: <Widget>[
                    // Visibility(
                    //   visible: !isSkipLogin,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(20.0),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: <Widget>[
                    //         Expanded(
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               Text(
                    //                 'Delivery to',
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .subtitle2!
                    //                     .copyWith(fontSize: 16.0),
                    //               ),
                    //               UIHelper.verticalSpaceSmall(),
                    //               cartResponseModel.getAllAddressCustomer != null
                    //                   ? Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.start,
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           addressName(cartResponseModel
                    //                               .getAllAddressCustomer!
                    //                               .addressTypeId),
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .subtitle1!
                    //                               .copyWith(
                    //                                   fontWeight: FontWeight.bold,
                    //                                   fontSize: 13,
                    //                                   color: Colors.blue),
                    //                         ),
                    //                         Text(
                    //                           cartResponseModel
                    //                               .getAllAddressCustomer!
                    //                               .address!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText1!
                    //                               .copyWith(color: Colors.grey),
                    //                         ),
                    //                         Text(
                    //                           cartResponseModel
                    //                               .getAllAddressCustomer!
                    //                               .landMark!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText1!
                    //                               .copyWith(color: Colors.grey),
                    //                         ),
                    //                         Text(
                    //                           cartResponseModel
                    //                               .getAllAddressCustomer!.floor!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText1!
                    //                               .copyWith(color: Colors.grey),
                    //                         ),
                    //                         Text(
                    //                           cartResponseModel
                    //                               .getAllAddressCustomer!.reach!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText1!
                    //                               .copyWith(color: Colors.grey),
                    //                         ),
                    //                       ],
                    //                     )
                    //                   : Text(
                    //                       cartResponseModel.retailerDetails!.first
                    //                           .outletAddress!,
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .bodyText1!
                    //                           .copyWith(color: Colors.grey),
                    //                     ),
                    //               UIHelper.verticalSpaceSmall(),
                    //             ],
                    //           ),
                    //         ),
                    //         InkWell(
                    //           child: Text(
                    //             'CHANGE ADDRESS',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .subtitle2!
                    //                 .copyWith(color: darkOrange),
                    //           ),
                    //           onTap: () {
                    //             selectDeliveryAddress(context);
                    //           },
                    //         ),
                    //         UIHelper.verticalSpaceMedium(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // !isSkipLogin
                    //     ? showSelfPickUpOrHomeDelivery()
                    //     : addPersonalDetails()
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  addPersonalDetails() {
    final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);
    //  cartListAPIProvider.cartResponseModel!.status == "0"
    //     ? SizedBox()
    //     :

    if (cartListAPIProvider.ifLoading) {
      return SizedBox();
    } else if (cartListAPIProvider.error) {
      return SizedBox();
    } else if (cartListAPIProvider.cartResponseModel == null ||
        cartListAPIProvider.cartResponseModel!.productDetails == null ||
        cartListAPIProvider.cartResponseModel!.productDetails!.length == 0) {
      return SizedBox();
    }
    // ?
    // :
    //     ? errorBody()
    //     :
    //         ? emptyCart()

    final verifyLoggedInUser =
        Provider.of<VerifyUserLoginAPIProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        /*   */ /*final value = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PersonalDetailsPage()));*/ /*
        print("User sign in successfully completed with value ----" +
            value.toString());
        if (value.length >= 2) {
          Utils.showLoaderDialog(context);
          final token = await FirebaseMessaging.instance.getToken();
          // log("Phone Number going to pin is                        -------------------------------" +
          //     token! +
          //     "----------" +
          //     context.read<LoggedInUser>().uid +
          //     "-------------" +
          //     context.read<LoggedInUser>().phoneNo);
          await verifyLoggedInUser.getUser(
              deviceToken: token ?? "NA",
              userFirebaseID: context.read<LoggedInUser>().uid,
              phoneNumber: context.read<LoggedInUser>().phoneNo);
          print("New vendor logged in" +
              verifyLoggedInUser.loginResponse!.driverDetails!.customerName!);
          if (verifyLoggedInUser.loginResponse!.driverDetails!.customerName ==
              null ||
              verifyLoggedInUser.loginResponse!.driverDetails!.customerName ==
                  "") {
           */ /* await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GetUserNameAndLocation()));*/ /*
          } else {
            await apiServices.updateFirebaseId(
                firebaseId: context.read<LoggedInUser>().uid,
                name: verifyLoggedInUser
                    .loginResponse!.driverDetails!.customerName!,
                email: verifyLoggedInUser.loginResponse!.driverDetails!.email!);
          }
          ApiServices.userId =
              verifyLoggedInUser.loginResponse!.driverDetails!.id;
          // if(verifyLoggedInUser.loginResponse.driverDetails.customerName)

          await context.read<ProfileViewApiProvider>().getProfileView();
          await context.read<CartListAPIProvider>().cartlist(
              SharedPreference.latitude, SharedPreference.longitude, "");

          await initialize();
          Navigator.of(context).pop();
        }
        // apiServices
        //     .checkAddress(
        //         cartResponseModel.getAllAddressCustomer!
        //                     .address !=
        //                 null
        //             ? cartResponseModel
        //                 .getAllAddressCustomer!.lat
        //             : cartResponseModel
        //                 .retailerDetails!.first.lat,
        //         cartResponseModel.getAllAddressCustomer!
        //                     .address !=
        //                 null
        //             ? cartResponseModel
        //                 .getAllAddressCustomer!.long
        //             : cartResponseModel
        //                 .retailerDetails!.first.long)
        //     .then((value) {
        //   if (value['status'] == false) {
        //     selectDeliveryAddress(context);
        //   } else {
        //     generateTxnToken(
        //       2,
        //       cartResponseModel.total.toString(),
        //       cartResponseModel
        //           .getAllAddressCustomer!.address,
        //       cartResponseModel
        //           .retailerDetails!.first.id,
        //     );
        //   }
        // });*/
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        color: Colors.green,
        height: 60.0,
        child: Text(
          'Add personal details',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // showBottomBar(String widgetName ){
  //   switch( widgetName){
  //     case "DeliveryAddress":
  //   }
  // }

  bool _selfPickUp = false, _homeDilevery = false;

  // showHomeDeliverySelfPickupSelectedWidget() {
  //   return Column(
  //     children: [
  //       Visibility(
  //         visible: _selfPickUp == false,
  //         child: child),
  //       Visibility(child: child)

  //     ],
  //   );
  // }
  Future _showMyDialog() async {
    final profileViewAPIProvider =
        Provider.of<ProfileViewApiProvider>(context, listen: false);

    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Self Pick Up',
              style: CommonStyles.blue12thin(),
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'The food will be prepared in 20 minutes.',
                style: CommonStyles.black12thin(),
              ),
              Utils.getSizedBox(height: 15),
              Text(
                'Would you like to approve of this message?',
                style: CommonStyles.green9(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop("selected");
              },
            ),
          ],
        );
      },
    );
  }

  showSelfPickUpOrHomeDelivery() {
    // if (_selfPickUp) {
    // } else if (_homeD)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: _isAddressSelected ? 50 : deviceWidth(context) * 0.5,
          child: InkWell(
            onTap: () async {
              // setState(() {
              //   context.read<CartListAPIProvider>().cartlist(
              //       SharedPreference.latitude!,
              //       SharedPreference.longitude!,
              //       "");
              //   restypevalue("");
              //   _isAddressSelected = false;
              // });
              final res = await _showMyDialog();
              if (res == "selected") {
                final resu = await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProceedToPay();
                    });
                if (resu == "clear") {
                  apiService.clearCart();
                  context.read<CartListAPIProvider>().cartlist(
                      SharedPreference.latitude,
                      SharedPreference.longitude,
                      "");
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return AccountScreen();
                  }));
                  context.read<OngoingOrderAPIProvider>().getOrderHistory();
                }
              }

              //self pickup api service with deducted tax amount
              // showModalBottomSheet(
              //     context: context,
              //     builder: (context) {
              //       // return selectDeliveryAddress(context)
              //       return SelectDeliveryPartner();
              //     });
            },
            child: Container(
                height: 60,
                padding: const EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      Visibility(
                          visible: !_isAddressSelected,
                          child: Row(
                            children: [
                              Utils.getSizedBox(width: 5),
                              Text("Self Pick Up",
                                  style: CommonStyles.black12()),
                            ],
                          )),
                    ],
                  ),
                )),
          ),
        ),
        Flexible(
          child: _isAddressSelected
              ? InkWell(
                  onTap: () async {
                    final res = await showModalBottomSheet(
                        context: context,
                        builder: (context) => SelectDeliveryDriver());
                    if (res == "selected") {
                      final resu = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ProceedToPay();
                          });
                      if (resu == "clear") {
                        apiService.clearCart();
                        context.read<CartListAPIProvider>().cartlist(
                            SharedPreference.latitude,
                            SharedPreference.longitude,
                            "");
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return AccountScreen();
                        }));
                        context
                            .read<OngoingOrderAPIProvider>()
                            .getOrderHistory();
                      }
                      print("the rsult is  -- -- - -  --  -" + resu.toString());
                    }

                    if (res == "selected") {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.green,
                    height: 60.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                          ),
                          Utils.getSizedBox(width: 5),
                          Text(
                            'Select Delivery Partner',
                            style: CommonStyles.whiteText12BoldW500(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    // await initPlatformState();
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => RazorPayPage()));
                    final res = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (context) {
                          return SelectDeliveryAddress();
                        });
                    // // final res = await selectDeliveryAddress(context);
                    // print("----------- res --------------" + res.toString());
                    if (res == "selected") {
                      setState(() {
                        _isAddressSelected = true;
                      });
                      // _scrollController
                      //     .jumpTo(_scrollController.position.minScrollExtent);
                      // final res = await showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) => selectDeliveryPartner(context));
                      // if (res == "selected") {
                      //   showModalBottomSheet(
                      //       context: context,
                      //       builder: (context) {
                      //         return ProceedToPay();
                      //       });
                      // }
                    }
                    // selectDeliveryAddress(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.green,
                    height: 60.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                          ),
                          Utils.getSizedBox(width: 5),
                          Text(
                            'Home Delivery',
                            style: CommonStyles.whiteText12BoldW500(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),

        // payment_response != null
        //     ? Text('Response: $payment_response\n')
        //     : Container(),
      ],
    );
  }

  selectDeliveryAddressButton() {
    return InkWell(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      onTap: () async {
        // final res = await selectDeliveryAddress(context);
        // if (res == "selected") {
        //   showBottomSheet(
        //       context: context,
        //       builder: (context) => selectDeliveryPartner(context));
        // }
      },
      child: Container(
        color: Colors.green,
        height: 60,
        child: Center(
          child: Text("Select Delivery Address",
              style: CommonStyles.whiteText10BoldW400()),
        ),
      ),
    );
  }

  Future<dynamic> buildDeliveryDialog(
      BuildContext context, CartResponseModel cartResponseModel) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Delivery Charge and Surge",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Delivery Charge helps compensate your delivery partner fairly for fulfilling your order",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Base Charge",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "20",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Surge",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Rs 24",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Sub Total",
                        //       style: TextStyle(
                        //           fontSize: 12, fontWeight: FontWeight.w500),
                        //     ),
                        //     Text(
                        //       "Rs 24",
                        //       style: TextStyle(
                        //           fontSize: 12, fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Close 2 Buy Discount",
                        //       style: TextStyle(
                        //           fontSize: 14, fontWeight: FontWeight.w500),
                        //     ),
                        //     Text(
                        //       "Rs 24",
                        //       style: TextStyle(
                        //           fontSize: 14, fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Rs 48",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> buildTaxDialog(
      BuildContext context, CartResponseModel cartResponseModel) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Taxes and Charges",
                    style: CommonStyles.black57S14(),
                  ),
                  /*  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Delivery Charge helps compensate your delivery partner fairly for fulfilling your order",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),*/
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Parcel Charges",
                              style: CommonStyles.blue12thin(),
                            ),
                            Text(
                              "Rs " +
                                  double.parse(
                                          cartResponseModel.packingCharge ??
                                              "0")
                                      .toString(),
                              style: CommonStyles.blue12thin(),
                            ),
                          ],
                        ),

                        Visibility(
                          visible: cartResponseModel.gstTax != null &&
                              cartResponseModel.gstTax != "" &&
                              cartResponseModel.gstTax != "0",
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Taxes",
                                    style: CommonStyles.blue12thin(),
                                  ),
                                  Text(
                                    "Rs " + cartResponseModel.gstTax!,
                                    style: CommonStyles.blue12thin(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                          visible: cartResponseModel.consalationTax != null &&
                              cartResponseModel.consalationTax != "" &&
                              cartResponseModel.consalationTax != "0",
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Convenience Charges",
                                    style: CommonStyles.blue12thin(),
                                  ),
                                  Text(
                                    "Rs " + cartResponseModel.consalationTax!,
                                    style: CommonStyles.blue12thin(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Visibility(
                        //   visible: cartResponseModel.consalationTax != null &&
                        //       cartResponseModel.consalationTax != "" &&
                        //       cartResponseModel.consalationTax != "0",
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 8,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Convenience Charges",
                        //             style: CommonStyles.blue12thin(),
                        //           ),
                        //           Text(
                        //             "Rs " +
                        //                 cartResponseModel.consalationTax
                        //                     .toString(),
                        //             style: CommonStyles.blue12thin(),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // Visibility(
                        //   visible: cartResponseModel.carryBag != null &&
                        //       cartResponseModel.carryBag != "" &&
                        //       cartResponseModel.carryBag != "0",
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SizedBox(
                        //         height: 8,
                        //       ),
                        //       Row(
                        //         children: <Widget>[
                        //           Text('Delivery Charge',
                        //               style: CommonStyles.blue12thin()),
                        //           Spacer(),
                        //           Text(
                        //             "Rs." +
                        //                 cartResponseModel.carryBag.toString(),
                        //             style: CommonStyles.blue12thin(),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        /* SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Close 2 Buy Discount",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              " 24",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Rs ${(double.parse(cartResponseModel.consalationTax ?? "0") + (double.parse(cartResponseModel.packingTax ?? "0.0") + double.parse(cartResponseModel.packingCharge ?? "0")) + double.parse(cartResponseModel.gstTax!)).toStringAsFixed(2)}",
                              style: CommonStyles.blue12thin(),
                            ),
                          ],
                          //  ${(double.parse((cartResponseModel.consalationTax!)) + double.parse(cartResponseModel.gstTax!)).toString()}
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  double calculatePrecentage(double percentage, double amount) {
    return (percentage / 100) * amount;
  }

  CustomDividerView _buildDivider() => CustomDividerView(
        dividerHeight: 1.0,
        color: Colors.grey[400],
      );

  addressName(dynamic typeId) {
    switch (typeId) {
      case "1":
        return "Home";
      case "2":
        return "Work";
      default:
        return "Other";
    }
  }

  UserApi? _userApi;
  // Future<UserApi> getAddress() async {
  //   return await apiServices.fetchAlbum().then((value) {
  //     setState(() {
  //       _userApi = value;
  //     });
  //   });
  // }

  setAddress() async {
    await apiService.fetchAlbum().then((value) {
      setState(() {
        _userApi = value;
      });
    });
  }

  // selectDeliveryAddress(BuildContext context) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return Wrap(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(15.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //                     child: Text(
  //                       "Select an address",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, fontSize: 18),
  //                     ),
  //                   ),
  //                   Divider(),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //                     child: GestureDetector(
  //                       onTap: () async {
  //                         final res = await Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (context) => MapSample(
  //                                 latitude: SharedPreference.latitudeValue,
  //                                 longitude: SharedPreference.longitudeValue,
  //                                 isProceed: true),
  //                           ),
  //                         );
  //                         final cartResponseModel =
  //                             Provider.of<CartListAPIProvider>(context,
  //                                     listen: false)
  //                                 .cartResponseModel!;
  //                         if (res == "pop") {
  //                           apiServices
  //                               .checkAddress(
  //                                   cartResponseModel.getAllAddressCustomer!
  //                                               .address !=
  //                                           null
  //                                       ? cartResponseModel
  //                                           .getAllAddressCustomer!.lat
  //                                       : cartResponseModel
  //                                           .retailerDetails!.first.lat,
  //                                   cartResponseModel.getAllAddressCustomer!
  //                                               .address !=
  //                                           null
  //                                       ? cartResponseModel
  //                                           .getAllAddressCustomer!.long
  //                                       : cartResponseModel
  //                                           .retailerDetails!.first.long)
  //                               .then((value) {
  //                             if (value['status'] == false) {
  //                               // selectDeliveryAddress(context);
  //                               Utils.showSnackBar(
  //                                   context: context,
  //                                   text: "No address Selected");
  //                             } else {
  //                               // showModalBottomSheet(
  //                               //     context: context,
  //                               //     builder: (context) {
  //                               //       return selectDeliveryPartner(context);
  //                               //     });
  //                               Navigator.of(context).pop("selected");

  //                               // generateTxnToken(
  //                               //   2,
  //                               //   cartResponseModel.total.toString(),
  //                               //   cartResponseModel
  //                               //       .getAllAddressCustomer!.address,
  //                               //   cartResponseModel.retailerDetails!.first.id,
  //                               // );
  //                             }
  //                           });
  //                           // getAddress();
  //                         }
  //                       },
  //                       child: Row(
  //                         children: [
  //                           Icon(Icons.add, color: swiggyOrange),
  //                           UIHelper.horizontalSpace(5),
  //                           Text(
  //                             "Add Address",
  //                             style:
  //                                 TextStyle(color: swiggyOrange, fontSize: 16),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(),
  //                   UIHelper.verticalSpaceMedium(),
  //                   Text(
  //                     "Saved Addresses".toUpperCase(),
  //                     style: TextStyle(fontSize: 14),
  //                   ),
  //                   UIHelper.verticalSpaceMedium(),
  //                   FutureBuilder<UserApi>(
  //                       future: getAddress(),
  //                       builder: (context, snapshot) {
  //                         if (snapshot.connectionState ==
  //                             ConnectionState.waiting) {
  //                           return Center(
  //                             child: CircularProgressIndicator(),
  //                           );
  //                         } else {
  //                           // final List<UserModel> _addressList =
  //                           //     snapshot.data!.get_all_address!;

  //                           return snapshot.data!.get_all_address != null
  //                               ? Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                           top: 8.0, bottom: 8.0),
  //                                       child: Text(
  //                                         "Delivers to".toUpperCase(),
  //                                         style: TextStyle(
  //                                             color: Colors.blue, fontSize: 13),
  //                                       ),
  //                                     ),
  //                                     Column(
  //                                       children: snapshot
  //                                           .data!.get_all_address!
  //                                           .map((e) {
  //                                         return InkWell(
  //                                           onTap: () async {
  //                                             final cartListAPIProvider =
  //                                                 Provider.of<
  //                                                         CartListAPIProvider>(
  //                                                     context,
  //                                                     listen: false);

  //                                             apiServices.selectAddress(
  //                                                 e.address_type_id);

  //                                             cartListAPIProvider.cartlist(
  //                                                 SharedPreference.latitude,
  //                                                 SharedPreference.longitude,
  //                                                 SharedPreference
  //                                                     .currentAddress);
  //                                             context
  //                                                 .read<
  //                                                     ProfileViewApiProvider>()
  //                                                 .getProfileView();
  //                                             Navigator.of(context)
  //                                                 .pop("selected");

  //                                             // showBottomSheet(
  //                                             //     context: context,
  //                                             //     builder: (context) =>
  //                                             //         selectDeliveryPartner(
  //                                             //             context));
  //                                           },
  //                                           child: Column(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.start,
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               ListTile(
  //                                                 contentPadding:
  //                                                     EdgeInsets.zero,
  //                                                 leading:
  //                                                     Icon(Icons.location_city),
  //                                                 title: Text(
  //                                                   addressName(
  //                                                           e.address_type_id)
  //                                                       .toString(),
  //                                                   style: TextStyle(
  //                                                       fontWeight:
  //                                                           FontWeight.w700,
  //                                                       fontSize: 15),
  //                                                 ),
  //                                                 subtitle: Column(
  //                                                   mainAxisAlignment:
  //                                                       MainAxisAlignment.start,
  //                                                   crossAxisAlignment:
  //                                                       CrossAxisAlignment
  //                                                           .start,
  //                                                   children: [
  //                                                     Text(e.address!),
  //                                                     Text(e.land_mark!),
  //                                                     Visibility(
  //                                                         visible:
  //                                                             e.floor != "",
  //                                                         child:
  //                                                             Text(e.floor!)),
  //                                                     Visibility(
  //                                                         visible:
  //                                                             e.reach != "",
  //                                                         child: Text(e.reach!))
  //                                                   ],
  //                                                 ),
  //                                                 // trailing: ,
  //                                               ),
  //                                               Divider(),
  //                                             ],
  //                                           ),
  //                                         );
  //                                       }).toList(),
  //                                     ),
  //                                   ],
  //                                 )
  //                               : Container();
  //                         }
  //                       })
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // void selectDeliveryAddressBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, vs) {
  //           return Wrap(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(15.0),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //                       child: Text(
  //                         "Select an address",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18),
  //                       ),
  //                     ),
  //                     Divider(),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //                       child: GestureDetector(
  //                         onTap: () async {
  //                           final res = await Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => MapSample(
  //                                   latitude: SharedPreference.latitudeValue,
  //                                   longitude: SharedPreference.longitudeValue,
  //                                   isProceed: true),
  //                             ),
  //                           );
  //                           if (res == "pop") {
  //                             // Navigator.of(context).pop();
  //                             getAddress();
  //                             setState(() {});
  //                           }
  //                         },
  //                         child: Row(
  //                           children: [
  //                             Icon(Icons.add, color: swiggyOrange),
  //                             UIHelper.horizontalSpace(5),
  //                             Text(
  //                               "Add Address",
  //                               style: TextStyle(
  //                                   color: swiggyOrange, fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Divider(),
  //                     UIHelper.verticalSpaceMedium(),
  //                     Text(
  //                       "Saved Addresses".toUpperCase(),
  //                       style: TextStyle(fontSize: 14),
  //                     ),
  //                     UIHelper.verticalSpaceMedium(),
  //                     FutureBuilder<UserApi>(
  //                         future: getAddress(),
  //                         builder: (context, snapshot) {
  //                           if (snapshot.connectionState ==
  //                               ConnectionState.waiting) {
  //                             return Center(
  //                               child: CircularProgressIndicator(),
  //                             );
  //                           } else {
  //                             final List<UserModel> _addressList =
  //                                 snapshot.data!.get_all_address!;

  //                             return snapshot.data!.get_all_address != null
  //                                 ? Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Padding(
  //                                         padding: const EdgeInsets.only(
  //                                             top: 8.0, bottom: 8.0),
  //                                         child: Text(
  //                                           "Delivers to".toUpperCase(),
  //                                           style: TextStyle(
  //                                               color: Colors.blue,
  //                                               fontSize: 13),
  //                                         ),
  //                                       ),
  //                                       Column(
  //                                         children: snapshot
  //                                             .data!.get_all_address!
  //                                             .map((e) {
  //                                           return InkWell(
  //                                             onTap: () async {
  //                                               final cartListAPIProvider =
  //                                                   Provider.of<
  //                                                           CartListAPIProvider>(
  //                                                       context,
  //                                                       listen: false);

  //                                               setState(() {
  //                                                 apiServices
  //                                                     .selectAddress(
  //                                                         e.address_type_id)
  //                                                     .then((value) {
  //                                                   Navigator.pop(context);
  //                                                 });
  //                                               });

  //                                               cartListAPIProvider.cartlist(
  //                                                   SharedPreference.latitude,
  //                                                   SharedPreference.longitude,
  //                                                   SharedPreference
  //                                                       .currentAddress);
  //                                               context
  //                                                   .read<
  //                                                       ProfileViewApiProvider>()
  //                                                   .getProfileView();
  //                                             },
  //                                             child: Column(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment.start,
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 ListTile(
  //                                                   contentPadding:
  //                                                       EdgeInsets.zero,
  //                                                   leading: Icon(
  //                                                       Icons.location_city),
  //                                                   title: Text(
  //                                                     addressName(
  //                                                             e.address_type_id)
  //                                                         .toString(),
  //                                                     style: TextStyle(
  //                                                         fontWeight:
  //                                                             FontWeight.w700,
  //                                                         fontSize: 15),
  //                                                   ),
  //                                                   subtitle: Column(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .start,
  //                                                     crossAxisAlignment:
  //                                                         CrossAxisAlignment
  //                                                             .start,
  //                                                     children: [
  //                                                       Text(e.address!),
  //                                                       Text(e.land_mark!),
  //                                                       Visibility(
  //                                                           visible:
  //                                                               e.floor != "",
  //                                                           child:
  //                                                               Text(e.floor!)),
  //                                                       Visibility(
  //                                                           visible:
  //                                                               e.reach != "",
  //                                                           child:
  //                                                               Text(e.reach!))
  //                                                     ],
  //                                                   ),
  //                                                   // trailing: ,
  //                                                 ),
  //                                                 Divider(),
  //                                               ],
  //                                             ),
  //                                           );
  //                                         }).toList(),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 : Container();
  //                           }
  //                         })
  //                   ],
  //                 ),
  //               )
  //             ],
  //           );
  //         });
  //       });
  // }

  Future<void> generateTxnToken(
      int mode, String amount, String? address, String? id) async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": "qDgjQf92141216125873",
      "key_secret": "k&S9tzYK&VMuwGPa",
      "website": "DEFAULT",
      "orderId": orderId,
      "amount": amount,
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
        print("TXNTOKEN+ $txnToken");
      });

      var paytmResponse = Paytm.payWithPaytm(
          mId: "qDgjQf92141216125873",
          orderId: orderId,
          txnToken: txnToken,
          txnAmount: amount,
          callBackUrl: callBackUrl,
          staging: testing);

      paytmResponse.then((value) {
        setState(() {
          loading = false;
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              setState(() {
                payment_response_status = value['response']['STATUS'];
                order_id = value['response']['ORDERID'];
                tax_amount = value['response']['TXNAMOUNT'];
                tax_date_time = value['response']['TXNDATE'];
                reference_no = value['response']['BANKTXNID'];

                if (payment_response_status == 'TXN_FAILURE') {
                  print("TXN_FAILUREresponse +$payment_response_status");
                  Navigator.pushReplacementNamed(context, 'PaymentFailure');
                } else if (payment_response_status == 'TXN_SUCCESS') {
                  print("TXN_SUCCESSresponse +$payment_response_status");
                  apiService.orderClearCart();

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PaymentSuccess(
                  //             tax_amount: tax_amount,
                  //             reference_no: reference_no,
                  //             tax_date_time: tax_date_time,
                  //             order_id: order_id,
                  //             model: data,
                  //           )),
                  // );
                }
                // (payment_response_status == 'TXNFAILURE') ? print("tacfailure") : Navigator.pushReplacementNamed(context, 'PaymentFailure');
              });
            }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }
}

class SelectDeliveryDriver extends StatefulWidget {
  const SelectDeliveryDriver({Key? key}) : super(key: key);

  @override
  State<SelectDeliveryDriver> createState() => _SelectDeliveryDriverState();
}

class _SelectDeliveryDriverState extends State<SelectDeliveryDriver> {
  int _radioSelected = 1;

  @override
  void initState() {
    _radioSelected = context
                .read<CartListAPIProvider>()
                .cartResponseModel!
                .deliveryStatus! ==
            "1"
        ? 1
        : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectDeliveryPartner(context);
  }

  selectDeliveryPartner(context) {
    final cartListAPiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Choose Delivery Partner",
                  style: CommonStyles.black12(),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 60,
                      decoration: BoxDecoration(
                          color: _radioSelected == 0
                              ? Colors.black12
                              : Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _radioSelected,
                            activeColor: Colors.blue,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              // setState(() {
                              //   _radioSelected = int.parse(value.toString());
                              // });
                              setState(() {
                                _radioSelected = int.parse(value.toString());
                              });
                              cartListAPiProvider.cartlist(
                                  SharedPreference.latitude,
                                  SharedPreference.longitude,
                                  "",
                                  deliveryPartner: "2");
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset(
                                      "assets/icons/dunzologo.png",
                                    )),
                                Utils.getSizedBox(width: 40),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('DUNZO',
                                        style: CommonStyles.black12()),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ " +
                                              cartListAPiProvider
                                                  .cartResponseModel!
                                                  .dunzoDeliveryFees!,
                                          style: CommonStyles.black12(),
                                        ),
                                        Utils.getSizedBox(width: 10),
                                        Icon(Icons.timer),
                                        Utils.getSizedBox(width: 3),
                                        Text(
                                          cartListAPiProvider.cartResponseModel!
                                              .dunzoDeliveryTime!,
                                          style: CommonStyles.black12(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Utils.getSizedBox(height: 12),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: _radioSelected == 1
                            ? Colors.black12
                            : Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio(
                            value: 1,
                            visualDensity: VisualDensity.compact,
                            groupValue: _radioSelected,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = int.parse(value.toString());
                              });
                              cartListAPiProvider.cartlist(
                                  SharedPreference.latitude,
                                  SharedPreference.longitude,
                                  "",
                                  deliveryPartner: "1");
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset(
                                      "assets/icons/qwqerlogo.png",
                                    )),
                                Utils.getSizedBox(width: 40),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'QWQER',
                                      style: CommonStyles.black12(),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ " +
                                              cartListAPiProvider
                                                  .cartResponseModel!
                                                  .quickerDeliveryFees!,
                                          style: CommonStyles.black12(),
                                        ),
                                        Utils.getSizedBox(width: 10),
                                        Icon(Icons.timer),
                                        Utils.getSizedBox(width: 3),
                                        Text(
                                          cartListAPiProvider.cartResponseModel!
                                              .quickerDeliveryTime!,
                                          style: CommonStyles.black12(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  showLoadDialog(context);
                  if (_radioSelected == 1) {
                    await cartListAPiProvider.cartlist(
                        SharedPreference.latitude,
                        SharedPreference.longitude,
                        "",
                        deliveryPartner: "1");

                    Navigator.of(context).pop();
                    Navigator.of(context).pop("selected");
                  } else if (_radioSelected == 0) {
                    await cartListAPiProvider.cartlist(
                        SharedPreference.latitude,
                        SharedPreference.longitude,
                        "",
                        deliveryPartner: "2");

                    Navigator.of(context).pop();
                    Navigator.of(context).pop("selected");
                  } else {
                    Utils.showSnackBar(
                        context: context,
                        text: "Error Selecting delivery partner.");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }

                  // await cartListAPiProvider.cartlist(
                  //     SharedPreference.latitude, SharedPreference.longitude, "",
                  //     deliveryPartner: "1");

                  // generateTxnToken(
                  //   2,
                  //   cartListAPiProvider.cartResponseModel!.total.toString(),
                  //   cartListAPiProvider
                  //       .cartResponseModel!.getAllAddressCustomer!.address,
                  //   cartListAPiProvider
                  //       .cartResponseModel!.retailerDetails!.first.id,
                  // );
                  // generateTxnToken(
                  //   2,
                  //   cartResponseModel.total.toString(),
                  //   cartResponseModel
                  //       .getAllAddressCustomer!.address,
                  //   cartResponseModel.retailerDetails!.first.id,
                  // );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Select Delivery Partner",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class ProductListCartListWidget extends StatefulWidget {
  const ProductListCartListWidget(
      {Key? key, required this.cartResponseModel, required this.index})
      : super(key: key);
  final CartResponseModel cartResponseModel;
  final int index;
  @override
  State<ProductListCartListWidget> createState() =>
      _ProductListCartListWidgetState();
}

class _ProductListCartListWidgetState extends State<ProductListCartListWidget> {
  Future restypevalue(String value) async {
    final cartListAPIProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    await context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
        cartListAPIProvider.cartResponseModel!.retailerDetails!.first.id!,
        SharedPreference.longitude.toString(),
        SharedPreference.latitude.toString(),
        value);
  }

  TextEditingController restaurantInstruction = TextEditingController();
  final restaurantInstructionKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.none,
      shadowColor: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: returnWidget(),
    );
  }

  returnWidget() {
    final cartResponseModel = Provider.of<CartListAPIProvider>(context);
    if (cartResponseModel.cartResponseModel!.productDetails!.length ==
        widget.index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Form(
          key: restaurantInstructionKey,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.always,
            decoration: const InputDecoration(
                icon: Icon(Icons.message),
                hintText: 'Write instruction for restaurant',
                border: InputBorder.none),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    VegBadgeView(),
                    UIHelper.horizontalSpaceMedium(),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cartResponseModel
                                .productDetails![widget.index].menuName!
                                .toUpperCase(),
                            style: CommonStyles.black11(),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            widget.cartResponseModel
                                .productDetails![widget.index].currentPrice!,
                            style: CommonStyles.black11(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: RadialGradient(colors: [
                            Colors.lightBlue.withOpacity(0.8),
                            Colors.blue.withOpacity(0.8)
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Icon(FontAwesomeIcons.minus,
                                  size: 16, color: Colors.white),
                            ),
                            onTap: () async {
                              if (widget
                                      .cartResponseModel
                                      .productDetails![widget.index]
                                      .quantity! ==
                                  "1") {
                                setState(() {
                                  isLoading = true;
                                });
                                apiService
                                    .addToCart(
                                        context,
                                        widget
                                            .cartResponseModel
                                            .productDetails![widget.index]
                                            .menuId,
                                        "-1",
                                        "0")
                                    .whenComplete(() {
                                  restypevalue('3').then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                  context.read<CartListAPIProvider>().cartlist(
                                      SharedPreference.latitude,
                                      SharedPreference.longitude,
                                      "");
                                });
                              } else {
                                setState(() {
                                  isLoading = true;
                                });

                                apiService
                                    .addToCart(
                                        context,
                                        widget
                                            .cartResponseModel
                                            .productDetails![widget.index]
                                            .menuId,
                                        "-1",
                                        "1")
                                    .whenComplete(() {
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
                              }
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          isLoading
                              ? SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: Center(
                                    child: Utils.showLoadingFittedBox(),
                                  ),
                                )
                              : AvatarGlow(
                                  endRadius: 20.0,
                                  child: Text(
                                    "${widget.cartResponseModel.productDetails![widget.index].quantity!}",
                                    style: CommonStyles.whiteText12BoldW500(),
                                  ),
                                ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              restypevalue('3').then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                              apiService
                                  .addToCart(
                                      context,
                                      widget.cartResponseModel
                                          .productDetails![widget.index].menuId,
                                      "+1",
                                      "1")
                                  .then((value) {
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
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              UIHelper.horizontalSpaceSmall(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      apiService
                          .addToCart(
                              context,
                              widget.cartResponseModel
                                  .productDetails![widget.index].menuId,
                              "-1",
                              "0")
                          .then((value) {
                        context.read<CartListAPIProvider>().cartlist(
                            SharedPreference.latitude,
                            SharedPreference.longitude,
                            "");
                        // _post = apiServices.modelcartlist(
                        //     context,
                        //     SharedPreference.latitudeValue,
                        //     SharedPreference.longitudeValue,
                        //     "");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: swiggyOrange,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ),

                  // UIHelper.verticalSpaceSmall(),
                  // Text(
                  //   productlist[index].total_price,
                  //   style: Theme.of(context).textTheme.bodyText1,
                  // ),
                ],
              ),
            ],
          ),
          Visibility(
              visible: widget.cartResponseModel.productDetails![widget.index]
                  .adonList!.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 3.0, top: 6, bottom: 6),
                    child: Text(
                      'Add-ons ',
                      style: CommonStyles.black11(),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cartResponseModel
                          .productDetails![widget.index].adonList!.length,
                      itemBuilder: (context, addonIndex) {
                        return SizedBox(
                          width: 90,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 0, bottom: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget
                                      .cartResponseModel
                                      .productDetails![widget.index]
                                      .adonList![addonIndex]
                                      .adonName!,
                                  style: CommonStyles.blackw54s9Thin(),
                                ),
                                Text(
                                  "\t Rs." +
                                      widget
                                          .cartResponseModel
                                          .productDetails![widget.index]
                                          .adonList![addonIndex]
                                          .salePrice!,
                                  style: CommonStyles.blackw54s9Thin(),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              )),
        ],
      ),
    );
  }
}

class SelectDeliveryAddress extends StatefulWidget {
  const SelectDeliveryAddress({Key? key}) : super(key: key);

  @override
  _SelectDeliveryPartnerState createState() => _SelectDeliveryPartnerState();
}

class _SelectDeliveryPartnerState extends State<SelectDeliveryAddress> {
  addressName(dynamic typeId) {
    switch (typeId) {
      case "1":
        return "Home";
      case "2":
        return "Work";
      default:
        return "Other";
    }
  }

  UserApi? _userApi;

  @override
  void initState() {
    setAddress();
    super.initState();
  }

  setAddress() async {
    await apiService.fetchAlbum().then((value) {
      setState(() {
        _userApi = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Text(
                  "Select an address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: GestureDetector(
                  onTap: () async {
                    final res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapSample(
                            latitude: SharedPreference.latitudeValue,
                            longitude: SharedPreference.longitudeValue,
                            isProceed: true),
                      ),
                    );
                    if (res == 'pop') {
                      setAddress();
                    } else {
                      Utils.showSnackBar(
                          context: context, text: "No location selected");
                    }
                    // if (res == "pop") {
                    //   await apiServices
                    //       .checkAddress(
                    //           cartResponseModel
                    //                       .getAllAddressCustomer!.address !=
                    //                   null
                    //               ? cartResponseModel.getAllAddressCustomer!.lat
                    //               : cartResponseModel
                    //                   .retailerDetails!.first.lat,
                    //           cartResponseModel
                    //                       .getAllAddressCustomer!.address !=
                    //                   null
                    //               ? cartResponseModel
                    //                   .getAllAddressCustomer!.long
                    //               : cartResponseModel
                    //                   .retailerDetails!.first.long)
                    //       .then((value) {
                    //     if (value['status'] == false) {
                    //       // selectDeliveryAddress(context);
                    //       Utils.showSnackBar(
                    //           context: context, text: "No address Selected");
                    //     } else {
                    //       // showModalBottomSheet(
                    //       //     context: context,
                    //       //     builder: (context) {
                    //       //       return selectDeliveryPartner(context);
                    //       //     });

                    //       Navigator.of(context).pop();

                    //       // generateTxnToken(
                    //       //   2,
                    //       //   cartResponseModel.total.toString(),
                    //       //   cartResponseModel
                    //       //       .getAllAddressCustomer!.address,
                    //       //   cartResponseModel.retailerDetails!.first.id,
                    //       // );
                    //     }
                    //   });
                    // }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, color: swiggyOrange),
                      UIHelper.horizontalSpace(5),
                      Text(
                        "Add Address",
                        style: TextStyle(color: swiggyOrange, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              UIHelper.verticalSpaceMedium(),
              Text(
                "Saved Addresses".toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
              UIHelper.verticalSpaceMedium(),
              _userApi == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            "Delivers to".toUpperCase(),
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                        ),
                        Column(
                          children: _userApi!.get_all_address!.map((e) {
                            return InkWell(
                              onTap: () async {
                                final cartListAPIProvider =
                                    Provider.of<CartListAPIProvider>(context,
                                        listen: false);
                                showLoadDialog(context);
                                await apiService
                                    .selectAddress(e.address_type_id);
                                await cartListAPIProvider.cartlist(
                                    SharedPreference.latitude,
                                    SharedPreference.longitude,
                                    "");
                                await context
                                    .read<ProfileViewApiProvider>()
                                    .getProfileView();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop("selected");

                                // showBottomSheet(
                                //     context: context,
                                //     builder: (context) =>
                                //         selectDeliveryPartner());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.location_city),
                                    title: Text(
                                      addressName(e.address_type_id).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.address!),
                                        Text(e.land_mark!),
                                        Visibility(
                                            visible: e.floor != "",
                                            child: Text(e.floor!)),
                                        Visibility(
                                            visible: e.reach != "",
                                            child: Text(e.reach!))
                                      ],
                                    ),
                                    // trailing: ,
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
              // FutureBuilder<UserApi>(
              //     future: getAddress(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else {
              //         // final List<UserModel> _addressList =
              //         //     snapshot.data!.get_all_address!;

              //         return snapshot.data!.get_all_address != null
              //             ?
              //             : Container();
              //       }
              //     })
            ],
          ),
        )
      ],
    );
  }
}

class ProceedToPay extends StatefulWidget {
  const ProceedToPay({Key? key, this.selectedDeliveryPartner})
      : super(key: key);
  final String? selectedDeliveryPartner;
  @override
  _ProceedToPayState createState() => _ProceedToPayState();
}

class _ProceedToPayState extends State<ProceedToPay> {
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    final cartListAPIProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    var options = {
      'key': 'rzp_test_Yl8WrdtstNbgBQ',
      'amount':
          (double.parse(cartListAPIProvider.cartResponseModel!.total!) * 100)
              .toString(),
      'name': 'Close To Buy',
      'description': "Food And More",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': cartListAPIProvider
                .cartResponseModel!.customerDetails!.first.mobile ??
            context.read<LoggedInUser>().phoneNo,
        'email': context
                .read<ProfileViewApiProvider>()
                .profileViewResponseModel!
                .userDetails!
                .email ??
            context.read<LoggedInUser>().email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var rng = Random();
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    final cartListAPIProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    final profileViewAPIProvider =
        Provider.of<ProfileViewApiProvider>(context, listen: false);

    print(" ===================== - - - - - - -  Payment ID" +
        response.orderId.toString());

    print(" ===================== - - - - - - -  RESPONSE ID ID" +
        response.paymentId.toString());

    final placeOrderResponseModel = PlaceOrderRequestModel(
        userId: ApiServices.userId!,
        itemTotal: cartListAPIProvider.cartResponseModel!.total!,
        deliveryFee: cartListAPIProvider.cartResponseModel!.deliveryFee!,
        parcelCharges:
            (double.parse(cartListAPIProvider.cartResponseModel!.packingTax!))
                .toString(),
        gstTax: cartListAPIProvider.cartResponseModel!.gstTax!,
        convenienceCharge:
            cartListAPIProvider.cartResponseModel!.consalationTax!,
        taxTotal:
            (double.parse(cartListAPIProvider.cartResponseModel!.gstTax!) +
                    double.parse(
                        cartListAPIProvider.cartResponseModel!.packingTax!))
                .toString(),
        total: cartListAPIProvider.cartResponseModel!.total!,
        deliveryFees: cartListAPIProvider.cartResponseModel!.deliveryFee!,
        address: cartListAPIProvider
            .cartResponseModel!.customerDetails!.first.address!,
        lat: cartListAPIProvider.cartResponseModel!.customerDetails!.first.lat!,
        long:
            cartListAPIProvider.cartResponseModel!.customerDetails!.first.long!,
        outletId:
            cartListAPIProvider.cartResponseModel!.retailerDetails!.first.id!,
        deliveryPartner: cartListAPIProvider.cartResponseModel!.deliveryStatus!,
        deliveryTime:
            cartListAPIProvider.cartResponseModel!.quickerDeliveryTime!,
        transactionId: "C2BORDER" + rng.nextInt(100000 - 100).toString(),
        paymentId: "C2BPAYMENTID" + rng.nextInt(100000 - 100).toString(),
        signatureId: "SIGNATURE-NA");

    final placeOrderResult =
        await apiService.placeOrder(placeOrderResponseModel);
    if (placeOrderResult['status'] == true) {
      apiService.clearCart();
      // context.read<CartListAPIProvider>().cartlist();
      print("orderPlaced successfully");
      Navigator.of(context).pop("clear");
    } else {
      Fluttertoast.showToast(
          msg: "ORDER PLACING FAILED " + response.paymentId!,
          toastLength: Toast.LENGTH_SHORT);
      print("orderPlaced Failed");
      Navigator.of(context).pop();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    PaymentSuccessResponse response =
        PaymentSuccessResponse("paymentId", "orderId", "signature");
    // Fluttertoast.showToast(
    //     msg: "Error the payment is not successful !",
    //     toastLength: Toast.LENGTH_SHORT);
    // var rng = Random();
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.message!, toastLength: Toast.LENGTH_SHORT);

    // final cartListAPIProvider =
    //     Provider.of<CartListAPIProvider>(context, listen: false);
    // final profileViewAPIProvider =
    //     Provider.of<ProfileViewApiProvider>(context, listen: false);

    // final placeOrderResponseModel = PlaceOrderRequestModel(
    //     userId: ApiServices.userId!,
    //     itemTotal: cartListAPIProvider.cartResponseModel!.total!,
    //     deliveryFee: cartListAPIProvider.cartResponseModel!.deliveryFee!,
    //     parcelCharges:
    //         (double.parse(cartListAPIProvider.cartResponseModel!.packingTax!))
    //             .toString(),
    //     gstTax: cartListAPIProvider.cartResponseModel!.gstTax!,
    //     convenienceCharge:
    //         cartListAPIProvider.cartResponseModel!.consalationTax!,
    //     taxTotal:
    //         (double.parse(cartListAPIProvider.cartResponseModel!.gstTax!) +
    //                 double.parse(
    //                     cartListAPIProvider.cartResponseModel!.packingTax!))
    //             .toString(),
    //     total: cartListAPIProvider.cartResponseModel!.total!,
    //     deliveryFees: cartListAPIProvider.cartResponseModel!.deliveryFee!,
    //     address: cartListAPIProvider
    //         .cartResponseModel!.customerDetails!.first.address!,
    //     lat: cartListAPIProvider.cartResponseModel!.customerDetails!.first.lat!,
    //     long:
    //         cartListAPIProvider.cartResponseModel!.customerDetails!.first.long!,
    //     outletId:
    //         cartListAPIProvider.cartResponseModel!.retailerDetails!.first.id!,
    //     deliveryPartner: cartListAPIProvider.cartResponseModel!.deliveryStatus!,
    //     deliveryTime:
    //         cartListAPIProvider.cartResponseModel!.quickerDeliveryTime!,
    //     transactionId: "C2BORDER" + rng.nextInt(100000 - 100).toString(),
    //     paymentId: "C2BPAYMENTID" + rng.nextInt(100000 - 100).toString(),
    //     signatureId: "SIGNATURE-NA");
    // print("user id---------------------" + placeOrderResponseModel.userId);
    // print(
    //     "item total---------------------" + placeOrderResponseModel.itemTotal);
    // print("delivery fee---------------------" +
    //     placeOrderResponseModel.deliveryFee);
    // print("parcel charges---------------------" +
    //     placeOrderResponseModel.parcelCharges);
    // print("gst tax---------------------" + placeOrderResponseModel.gstTax);
    // print("convenience---------------------" +
    //     placeOrderResponseModel.convenienceCharge);
    // print("tax total---------------------" + placeOrderResponseModel.taxTotal);
    // print("total---------------------" + placeOrderResponseModel.total);
    // print("delivery fee---------------------" +
    //     placeOrderResponseModel.deliveryFee);
    // print("address---------------------" + placeOrderResponseModel.address);
    // print("lat ---------------------" + placeOrderResponseModel.lat);
    // print("long ---------------------" + placeOrderResponseModel.long);
    // print("delivery---------------------" +
    //     placeOrderResponseModel.deliveryPartner);
    // print("outlet ---------------------" + placeOrderResponseModel.outletId);
    // print("delivery time---------------------" +
    //     placeOrderResponseModel.deliveryTime);
    // print("transaction id---------------------" +
    //     placeOrderResponseModel.transactionId);
    // print(
    //     "payment id---------------------" + placeOrderResponseModel.paymentId);

    // Utils.showLoaderDialog(context);
    // final placeOrderResult =
    //     await apiServices.placeOrder(placeOrderResponseModel);
    // if (placeOrderResult['status'] == true) {
    //   print("orderPlaced successfully");
    //   Navigator.of(context).pop("clear");
    //   Navigator.of(context).pop("clear");
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "ORDER PLACING FAILED " + response.message!,
    //       toastLength: Toast.LENGTH_SHORT);
    //   print("orderPlaced Failed");
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pop();
    // }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ValidateSuccessTransactionDetails(
            paymentSuccessResponse: response)));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    final cartListApiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    if (cartListApiProvider.ifLoading) {
      return Container(
          height: 60,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ));
    }
    final cartResponseModel = cartListApiProvider.cartResponseModel!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
              height: 60,
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: Center(
                child: Text("Total Rs." + cartResponseModel.total.toString(),
                    style: CommonStyles.black12()),
              )),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              apiService
                  .checkAddress(
                      cartResponseModel.getAllAddressCustomer!.address != null
                          ? cartResponseModel.getAllAddressCustomer!.lat
                          : cartResponseModel.retailerDetails!.first.lat,
                      cartResponseModel.getAllAddressCustomer!.address != null
                          ? cartResponseModel.getAllAddressCustomer!.long
                          : cartResponseModel.retailerDetails!.first.long)
                  .then((value) {
                if (value['status'] == false) {
                } else {
                  //Proceed to pay done
                  openCheckout();
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              color: Colors.green,
              height: 60.0,
              child: Text(
                'PROCEED TO PAY',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),

        // payment_response != null
        //     ? Text('Response: $payment_response\n')
        //     : Container(),
      ],
    );
  }
}

class ValidateSuccessTransactionDetails extends StatefulWidget {
  const ValidateSuccessTransactionDetails(
      {Key? key, required this.paymentSuccessResponse})
      : super(key: key);
  final PaymentSuccessResponse paymentSuccessResponse;
  @override
  State<ValidateSuccessTransactionDetails> createState() =>
      _ValidateSuccessTransactionDetailsState();
}

class _ValidateSuccessTransactionDetailsState
    extends State<ValidateSuccessTransactionDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));

    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _paymentSuccess = true;
      });
      _animationController.repeat();
    }).whenComplete(() {
      makePayment();
      Future.delayed(Duration(seconds: 1)).whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  makePayment() async {
    Fluttertoast.showToast(
        msg: "Error the payment is not successful !",
        toastLength: Toast.LENGTH_SHORT);
    var rng = Random();
    Fluttertoast.showToast(
        msg: "SUCCESS: " + widget.paymentSuccessResponse.orderId!,
        toastLength: Toast.LENGTH_SHORT);

    final cartListAPIProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    final profileViewAPIProvider =
        Provider.of<ProfileViewApiProvider>(context, listen: false);

    final placeOrderResponseModel = PlaceOrderRequestModel(
        userId: ApiServices.userId!,
        itemTotal: cartListAPIProvider.cartResponseModel!.total!,
        deliveryFee: cartListAPIProvider.cartResponseModel!.deliveryFee!,
        parcelCharges:
            (double.parse(cartListAPIProvider.cartResponseModel!.packingTax!))
                .toString(),
        gstTax: cartListAPIProvider.cartResponseModel!.gstTax!,
        convenienceCharge:
            cartListAPIProvider.cartResponseModel!.consalationTax!,
        taxTotal:
            (double.parse(cartListAPIProvider.cartResponseModel!.gstTax!) +
                    double.parse(
                        cartListAPIProvider.cartResponseModel!.packingTax!))
                .toString(),
        total: cartListAPIProvider.cartResponseModel!.total!,
        deliveryFees: cartListAPIProvider.cartResponseModel!.deliveryFee!,
        address: cartListAPIProvider
            .cartResponseModel!.customerDetails!.first.address!,
        lat: cartListAPIProvider.cartResponseModel!.customerDetails!.first.lat!,
        long:
            cartListAPIProvider.cartResponseModel!.customerDetails!.first.long!,
        outletId:
            cartListAPIProvider.cartResponseModel!.retailerDetails!.first.id!,
        deliveryPartner: cartListAPIProvider.cartResponseModel!.deliveryStatus!,
        deliveryTime:
            cartListAPIProvider.cartResponseModel!.quickerDeliveryTime!,
        transactionId: "C2BORDER" + rng.nextInt(100000 - 100).toString(),
        paymentId: "C2BPAYMENTID" + rng.nextInt(100000 - 100).toString(),
        signatureId: "SIGNATURE-NA");
    print("user id---------------------" + placeOrderResponseModel.userId);
    print(
        "item total---------------------" + placeOrderResponseModel.itemTotal);
    print("delivery fee---------------------" +
        placeOrderResponseModel.deliveryFee);
    print("parcel charges---------------------" +
        placeOrderResponseModel.parcelCharges);
    print("gst tax---------------------" + placeOrderResponseModel.gstTax);
    print("convenience---------------------" +
        placeOrderResponseModel.convenienceCharge);
    print("tax total---------------------" + placeOrderResponseModel.taxTotal);
    print("total---------------------" + placeOrderResponseModel.total);
    print("delivery fee---------------------" +
        placeOrderResponseModel.deliveryFee);
    print("address---------------------" + placeOrderResponseModel.address);
    print("lat ---------------------" + placeOrderResponseModel.lat);
    print("long ---------------------" + placeOrderResponseModel.long);
    print("delivery---------------------" +
        placeOrderResponseModel.deliveryPartner);
    print("outlet ---------------------" + placeOrderResponseModel.outletId);
    print("delivery time---------------------" +
        placeOrderResponseModel.deliveryTime);
    print("transaction id---------------------" +
        placeOrderResponseModel.transactionId);
    print(
        "payment id---------------------" + placeOrderResponseModel.paymentId);

    Utils.showLoaderDialog(context);
    final placeOrderResult =
        await apiService.placeOrder(placeOrderResponseModel);
    if (placeOrderResult['status'] == true) {
      print("orderPlaced successfully");
      Navigator.of(context).pop("clear");
      Navigator.of(context).pop("clear");
    } else {
      Fluttertoast.showToast(
          msg: "ORDER PLACING FAILED ", toastLength: Toast.LENGTH_SHORT);
      print("orderPlaced Failed");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  bool _paymentSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Hold on while we confirm your payment status!",
                    style: CommonStyles.blue13(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      LoadingIndicator(
                          indicatorType: Indicator.circleStrokeSpin,

                          /// Required, The loading type of the widget
                          colors: const [Colors.white],

                          /// Optional, The color collections
                          strokeWidth: 6,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.transparent,

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.blue

                          /// Optional, the stroke backgroundColor
                          ),
                      Visibility(
                        visible: _paymentSuccess,
                        child: Center(
                          child: AnimatedCheck(
                            progress: _animation,
                            color: Colors.blueAccent,
                            size: 400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _paymentSuccess,
                    child: Center(
                        child: Text(
                      "Success Payment",
                      style: CommonStyles.blue14Accent(),
                    )),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
