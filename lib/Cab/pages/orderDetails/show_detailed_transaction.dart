// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:loading_animations/loading_animations.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../Services/order_specific_api_provider.dart';
// import '../../common/common_styles.dart';
// import '../../common/utils.dart';
// import '../bookPage/book_vehicle.dart';

// class ShowDetailedTransaction extends StatefulWidget {
//   const ShowDetailedTransaction({Key? key, required this.orderId})
//       : super(key: key);
//   final String orderId;
//   @override
//   State<ShowDetailedTransaction> createState() =>
//       _ShowDetailedTransactionState();
// }

// class _ShowDetailedTransactionState extends State<ShowDetailedTransaction> {
//   @override
//   void initState() {
//     context.read<OrderSpecificAPIProvider>().orderSpecifiData(widget.orderId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: buildBody(),
//     );
//   }

//   buildBody() {
//     final orderHistoryAPIProvider =
//         Provider.of<OrderSpecificAPIProvider>(context);

//     if (orderHistoryAPIProvider.ifLoading) {
//       print("Loading ---------------");
//       return SizedBox(
//         child: Utils.getCenterLoading(),
//         height: 400,
//         width: 300,
//       );
//     } else if (orderHistoryAPIProvider.error) {
//       print("Loading Error---------------");

//       return SizedBox(
//         height: 400,
//         width: 300,
//         child: Utils.showErrorMessage(orderHistoryAPIProvider.errorMessage),
//       );
//     } else if (orderHistoryAPIProvider.orderSpecificModel == null ||
//         orderHistoryAPIProvider.orderSpecificModel!.status! == "0") {
//       print("Loading else if---------------");

//       return Utils.showErrorMessage(
//           orderHistoryAPIProvider.orderSpecificModel!.message!);
//     }
//     List<Model> list = [];

//     list.add(Model(
//         orderHistoryAPIProvider
//             .orderSpecificModel!.orderHistory!.tripDetails!.fromAddress!,
//         Colors.green));
//     list.add(Model(
//         orderHistoryAPIProvider
//             .orderSpecificModel!.orderHistory!.tripDetails!.toAddress!,
//         Colors.red));

//     print("Success ----///....;, ---------------");

//     // return LayoutBuilder(
//     //     builder: (BuildContext context, BoxConstraints constraints) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.orderStatus ==
//                   "1"
//               ? Center(
//                   child: SizedBox(
//                       height: 200,
//                       width: deviceWidth(context),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           LoadingRotating.square(
//                             borderSize: 10,
//                           ),
//                           Utils.getSizedBox(height: 40),
//                           Text(
//                             'Waiting for Driver Response',
//                             style: CommonStyles.black1254thin(),
//                           )
//                         ],
//                       )))
//               : orderHistoryAPIProvider
//                           .orderSpecificModel!.orderHistory!.orderStatus ==
//                       "2"
//                   ? Center(
//                       child: SizedBox(
//                           height: 200,
//                           width: deviceWidth(context),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.cancel_presentation,
//                                 size: 50,
//                               ),
//                               Utils.getSizedBox(height: 10),
//                               Text(
//                                 'Cancelled Order',
//                                 style: CommonStyles.black1254thin(),
//                               )
//                             ],
//                           )))
//                   : SizedBox(
//                       height: 400,
//                       width: deviceWidth(context),
//                       child: Container()
//                       //   MapPage(
//                       //     orderId: widget.orderId,
//                       //     // sourceLocation: LatLng(
//                       //     //     double.parse(orderHistoryAPIProvider
//                       //     //         .orderHistoryResponse!
//                       //     //         .orderHistory![widget.index]
//                       //     //         .tripDetails!
//                       //     //         .toLat!),
//                       //     //     double.parse(orderHistoryAPIProvider
//                       //     //         .orderHistoryResponse!
//                       //     //         .orderHistory![widget.index]
//                       //     //         .tripDetails!
//                       //     //         .toLong!)),
//                       //     // destinationLocation: LatLng(
//                       //     //     double.parse(orderHistoryAPIProvider
//                       //     //         .orderHistoryResponse!
//                       //     //         .orderHistory![widget.index]
//                       //     //         .tripDetails!
//                       //     //         .fromLat!),
//                       //     //     double.parse(orderHistoryAPIProvider
//                       //     //         .orderHistoryResponse!
//                       //     //         .orderHistory![widget.index]
//                       //     //         .tripDetails!
//                       //     //         .fromLong!)),
//                       //   ),
//                       ),

//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               icon: const Icon(
//                 Icons.close,
//                 size: 18,
//                 color: Colors.brown,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           // Row(
//           //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                     children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           height: 30,
//                           width: 30,
//                           decoration: const BoxDecoration(
//                               color: Colors.white, shape: BoxShape.circle),
//                           child: CachedNetworkImage(
//                             fit: BoxFit.fill,
//                             width: 30,
//                             height: 30,
//                             imageUrl: orderHistoryAPIProvider
//                                     .orderSpecificModel!.vehicleBaseurl! +
//                                 orderHistoryAPIProvider.orderSpecificModel!
//                                     .orderHistory!.vechileDetails!.image!,
//                           ),
//                         ),
//                         Utils.getSizedBox(width: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                                 orderHistoryAPIProvider.orderSpecificModel!
//                                     .orderHistory!.bookedDate!,
//                                 style: CommonStyles.black12()),
//                             Text(
//                               orderHistoryAPIProvider.orderSpecificModel!
//                                   .orderHistory!.vechileDetails!.wheeler!,
//                               style: CommonStyles.black1254W700(),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "₹ " +
//                           orderHistoryAPIProvider.orderSpecificModel!
//                               .orderHistory!.tripDetails!.total!,
//                       style: CommonStyles.blue12(),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       child: Container(
//                           color: Colors.white,
//                           child: ListView.builder(
//                               itemCount: list.length,
//                               shrinkWrap: true,
//                               primary: false,
//                               itemBuilder: (con, ind) {
//                                 return ind != 0
//                                     ? Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                             Row(children: [
//                                               Column(
//                                                 children: List.generate(
//                                                   2,
//                                                   (ii) => Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 9,
//                                                               right: 10,
//                                                               top: 5,
//                                                               bottom: 5),
//                                                       child: Container(
//                                                         height: 3,
//                                                         width: 2,
//                                                         color: Colors.grey,
//                                                       )),
//                                                 ),
//                                               ),
//                                               // Expanded(
//                                               //     child: Container(
//                                               //   color: Colors.grey.withAlpha(60),
//                                               //   height: 0.5,
//                                               //   padding: EdgeInsets.only(
//                                               //     left: 10,
//                                               //     right: 20,
//                                               //   ),
//                                               // ))
//                                             ]),
//                                             Row(children: [
//                                               Icon(
//                                                 Icons.location_on,
//                                                 color: list[ind].color,
//                                                 size: 20,
//                                               ),
//                                               Utils.getSizedBox(width: 10),
//                                               Flexible(
//                                                 child: Text(list[ind].address,
//                                                     maxLines: 3,
//                                                     style: CommonStyles.red9()),
//                                               )
//                                             ]),
//                                           ])
//                                     : Row(children: [
//                                         Icon(
//                                           Icons.location_on,
//                                           color: list[ind].color,
//                                           size: 20,
//                                         ),
//                                         Utils.getSizedBox(width: 10),
//                                         Flexible(
//                                           child: Text(list[ind].address,
//                                               maxLines: 3,
//                                               style: CommonStyles.green9()),
//                                         )
//                                       ]);
//                               })),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                             orderHistoryAPIProvider.orderSpecificModel!
//                                 .orderHistory!.tripDetails!.transactionId!,
//                             textAlign: TextAlign.start,
//                             style: CommonStyles.black10thin()),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.map, size: 18, color: Colors.brown),
//                         TextButton(
//                             onPressed: () async {
//                               launchMapsUrl(
//                                   orderHistoryAPIProvider.orderSpecificModel!
//                                       .orderHistory!.tripDetails!.fromLat,
//                                   orderHistoryAPIProvider.orderSpecificModel!
//                                       .orderHistory!.tripDetails!.fromLong!,
//                                   orderHistoryAPIProvider.orderSpecificModel!
//                                       .orderHistory!.tripDetails!.toLat,
//                                   orderHistoryAPIProvider.orderSpecificModel!
//                                       .orderHistory!.tripDetails!.toLong);
//                             },
//                             child: Text(
//                               'Show In Map',
//                               style: CommonStyles.blue12(),
//                             )),
//                       ],
//                     )
//                   ],
//                 ),
//                 Utils.getSizedBox(height: 10),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Status : ",
//                             style: CommonStyles.black1154(),
//                           ),
//                           Utils.getSizedBox(width: 5),
//                           getIconAccordingToStatus(orderHistoryAPIProvider
//                               .orderSpecificModel!.orderHistory!.orderStatus),
//                           Utils.getSizedBox(width: 5),
//                           Text(
//                               orderHistoryAPIProvider.orderSpecificModel!
//                                   .orderHistory!.orderLabel!,
//                               style: CommonStyles.black10thin()),
//                           // Text(
//                           //   "₹ " +
//                           //       orderHistoryAPIProvider
//                           //           .orderHistoryResponse!
//                           //           .orderHistory![index]
//                           //           .tripDetails!
//                           //           .payedAmt!,
//                           //   style: CommonStyles.black12(),
//                           // )
//                         ],
//                       ),
//                     ]),
//                 Utils.getSizedBox(height: 10),
//                 if (orderHistoryAPIProvider
//                         .orderSpecificModel!.orderHistory!.bookType ==
//                     "2")
//                   showBillScreen(),
//                 Utils.getSizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: okButton(),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget getIconAccordingToStatus(status) {
//     switch (status) {
//       case "1":
//         return const Icon(
//           Icons.timelapse,
//           color: Colors.blue,
//           size: 18,
//         );
//       case "2":
//         return const Icon(
//           Icons.cancel_presentation_outlined,
//           color: Colors.red,
//           size: 18,
//         );
//       case "3":
//         return const Icon(
//           Icons.done_all_sharp,
//           color: Colors.green,
//           size: 18,
//         );
//       case "4":
//         return const Icon(
//           Icons.delivery_dining_rounded,
//           color: Colors.yellow,
//           size: 18,
//         );
//     }
//     return const Icon(
//       Icons.keyboard_capslock_outlined,
//       color: Colors.green,
//       size: 18,
//     );
//   }

//   Widget okButton() {
//     return MaterialButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       color: Colors.red,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Center(
//           child: Text(
//         "Ok!",
//         style: CommonStyles.white12(),
//       )),
//     );
//   }

//   static void launchMapsUrl(sourceLatitude, sourceLongitude,
//       destinationLatitude, destinationLongitude) async {
//     String mapOptions = [
//       'saddr=$sourceLatitude,$sourceLongitude',
//       'daddr=$destinationLatitude,$destinationLongitude',
//       'travelmode=driving',
//       'dir_action=navigate'
//     ].join('&');

//     final url = 'https://www.google.com/maps?$mapOptions';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   showBillScreen() {
//     final orderHistoryAPIProvider =
//         Provider.of<OrderSpecificAPIProvider>(context, listen: false);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Vehicle Charges",
//               style: CommonStyles.black1154(),
//             ),
//             Text(
//               "₹ " +
//                   orderHistoryAPIProvider.orderSpecificModel!.orderHistory!
//                       .tripDetails!.vehicleCharge!,
//               style: CommonStyles.blue12thin(),
//             ),
//           ],
//         ),
//         Utils.getSizedBox(height: 10),
//         Visibility(
//           visible: orderHistoryAPIProvider.orderSpecificModel!.orderHistory!
//                       .tripDetails!.labourQty! !=
//                   "0" &&
//               orderHistoryAPIProvider.orderSpecificModel!.orderHistory!
//                       .tripDetails!.labourQty !=
//                   null,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Helper Charges (${orderHistoryAPIProvider.orderSpecificModel!.orderHistory!.tripDetails!.labourQty} Helpers)",
//                     style: CommonStyles.black1154(),
//                   ),
//                   Text(
//                     "₹ " +
//                         orderHistoryAPIProvider.orderSpecificModel!
//                             .orderHistory!.tripDetails!.labourPrice!,
//                     style: CommonStyles.blue12thin(),
//                   ),
//                 ],
//               ),
//               Utils.getSizedBox(height: 10),
//             ],
//           ),
//         ),
//         Visibility(
//           visible: orderHistoryAPIProvider
//                   .orderSpecificModel!.orderHistory!.tripDetails!.stateStatus !=
//               "0",
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Outstation Charges",
//                     style: CommonStyles.black1154(),
//                   ),
//                   Text(
//                     "₹ " +
//                         orderHistoryAPIProvider.orderSpecificModel!
//                             .orderHistory!.tripDetails!.statePrice!,
//                     style: CommonStyles.blue12thin(),
//                   ),
//                 ],
//               ),
//               Utils.getSizedBox(height: 10),
//             ],
//           ),
//         ),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "GST Amount ",
//               style: CommonStyles.black1154(),
//             ),
//             if (orderHistoryAPIProvider
//                     .orderSpecificModel!.orderHistory!.bookType ==
//                 "2")
//               Text(
//                 "₹ " +
//                     getGstPercerntage(
//                         double.parse(orderHistoryAPIProvider.orderSpecificModel!
//                             .orderHistory!.tripDetails!.gst!),
//                         (double.parse(orderHistoryAPIProvider
//                                     .orderSpecificModel!
//                                     .orderHistory!
//                                     .tripDetails!
//                                     .vehicleCharge!) +
//                                 double.parse(orderHistoryAPIProvider
//                                     .orderSpecificModel!
//                                     .orderHistory!
//                                     .tripDetails!
//                                     .statePrice!) +
//                                 double.parse(orderHistoryAPIProvider
//                                     .orderSpecificModel!
//                                     .orderHistory!
//                                     .tripDetails!
//                                     .labourPrice!))
//                             .toString()),
//                 style: CommonStyles.blue12thin(),
//               ),
//           ],
//         ),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //   children: [
//         //     Text(
//         //       "Gst Tax (${ orderHistoryAPIProvider.orderHistoryResponse!
//         //               .orderHistory![widget.index].tripDetails!.gst!} %)",
//         //       style: CommonStyles.blue12thin(),
//         //     ),
//         //     Text(
//         //       "₹ " +
//         //           (double.parse( orderHistoryAPIProvider.orderHistoryResponse!
//         //               .orderHistory![widget.index].tripDetails!.) -
//         //                   double.parse(vehicleCategoriesAPIProvider
//         //                       .vehicleCategoriesResponseModel!
//         //                       .vehicleList![widget.index]
//         //                       .withoutGst!))
//         //               .toStringAsFixed(2),
//         //       style: CommonStyles.blue12thin(),
//         //     ),
//         //   ],
//         // ),
//         // Utils.getSizedBox(height: 10),
//         // buildDivider(),
//         Utils.getSizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text("Paid Amount", style: CommonStyles.black12()),
//             Text(
//                 "₹ "
//                 "${orderHistoryAPIProvider.orderSpecificModel!.orderHistory!.tripDetails!.paidAmt!}",
//                 style: CommonStyles.blue12())
//           ],
//         ),
//         Utils.getSizedBox(height: 10),

//         buildDivider(),
//         Utils.getSizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text("Total Amount", style: CommonStyles.black12()),
//             Text(
//                 "₹ "
//                 "${orderHistoryAPIProvider.orderSpecificModel!.orderHistory!.tripDetails!.total!}",
//                 style: CommonStyles.blue12())
//           ],
//         ),

//         Utils.getSizedBox(height: 10),

//         buildDivider(),
//         Utils.getSizedBox(height: 10),
//         if (orderHistoryAPIProvider
//                 .orderSpecificModel!.orderHistory!.bookType ==
//             "2")
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Amount To Pay", style: CommonStyles.black12()),
//               Text(
//                   "₹ "
//                   "${((double.parse(orderHistoryAPIProvider.orderSpecificModel!.orderHistory!.tripDetails!.total!) - double.parse(orderHistoryAPIProvider.orderSpecificModel!.orderHistory!.tripDetails!.paidAmt!)).toStringAsFixed(2))}",
//                   style: CommonStyles.blue12())
//             ],
//           ),
//         Utils.getSizedBox(height: 10),
//         Visibility(
//           visible: orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.orderStatus !=
//                   "1" &&
//               orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.orderStatus !=
//                   "2" &&
//               orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.orderStatus !=
//                   "3" &&
//               orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.tripDetails!.total !=
//                   orderHistoryAPIProvider
//                       .orderSpecificModel!.orderHistory!.tripDetails!.paidAmt!,
//           child: RemainingPaymentAmount(
//             toPayAmount: (double.parse(orderHistoryAPIProvider
//                         .orderSpecificModel!
//                         .orderHistory!
//                         .tripDetails!
//                         .total!) -
//                     double.parse(orderHistoryAPIProvider.orderSpecificModel!
//                         .orderHistory!.tripDetails!.paidAmt!))
//                 .toStringAsFixed(2),
//           ),
//         ),

//         Utils.getSizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Flexible(
//               child: Text(
//                   "*Waiting Charges (Only applicable when loading and unloading time exceeds 2 hrs) ",
//                   // "₹ ${ orderHistoryAPIProvider
//                   //           .orderHistoryResponse!
//                   //           .orderHistory![widget.index]
//                   //           .!}.",
//                   maxLines: 3,
//                   style: CommonStyles.blackw54s9Thin()),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }

//   String getGstPercerntage(double percentage, String amount) {
//     return ((double.parse(amount) * percentage) / 100).toString();
//   }
// }

// class RemainingPaymentAmount extends StatefulWidget {
//   const RemainingPaymentAmount({Key? key, required this.toPayAmount})
//       : super(key: key);
//   final String toPayAmount;
//   @override
//   State<RemainingPaymentAmount> createState() => _RemainingPaymentAmountState();
// }

// class _RemainingPaymentAmountState extends State<RemainingPaymentAmount> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     super.initState();

//     // list.add(Model("Vijayawada", Colors.blue));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       color: Colors.green,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Center(
//           child: Text(
//         "Make payment of ₹ ${widget.toPayAmount} ",
//         style: CommonStyles.white12(),
//       )),
//     );
//   }

//   Future openCheckout() async {
//     var options = {
//       'key': 'rzp_live_ILgsfZCZoFIKMb',
//       'amount': widget.toPayAmount,
//       'name': 'Garudayaan Logistics.',
//       'description': 'Vehicle Boking',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Navigator.of(context).pop("success");
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId!,
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Navigator.of(context).pop("failed");

//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!,
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   bool _paymentCompleted = false;

//   buildPaymentFuture() async {
//     // _animationController.reset();
//     // await Future.delayed(const Duration(seconds: 2)).then((value) {
//     //   setState(() {
//     //     _paymentCompleted = true;
//     //   });
//     // });

//     // print("=----" + categoryId);
//     // print("=====" + categoryQuantity);

//     openCheckout().whenComplete(() async {
//       //Show Successful payed ramainging amount

//       // final bookVehicleRequestModel = BookVehicleRequestModel(
//       //     customerName: widget.pickupContactName,
//       //     distance: widget.vehicleList.totalKm!,
//       //     duration: widget.vehicleList.time!,
//       //     fromAddress: SharedPreference.address!,
//       //     vehicleCharge: widget.vehicleList.vehiclePrice!,
//       //     fromLat: SharedPreference.latitude!.toString(),
//       //     fromLong: SharedPreference.longitude!.toString(),
//       //     labourQuantity: widget.vehicleList.labourQty!,
//       //     labourPrice: widget.vehicleList.labourTotal!,
//       //     categoryId: categoryId,
//       //     categoryQuantity: categoryQuantity,
//       //     gst: widget.vehicleList.gst!,
//       //     statePrice: widget.vehicleList.outerCharge!,
//       //     stateStatus: widget.vehicleList.outerState!,
//       //     customerMobile: widget.pickupContactPhone,
//       //     paidAmount: getPriceFromPercentage(
//       //             vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
//       //                 .vehicleList![widget.vehicleSelectedIndex].totalPrice!,
//       //             30)
//       //         .toStringAsFixed(2),
//       //     toAddress: widget.toAddress,
//       //     toLat: widget.toLatitude.toString(),
//       //     toLong: widget.toLongitude.toString(),
//       //     total: widget.vehicleList.totalPrice!,
//       //     transactionId: "GYA000" + rand.nextInt(2000).toString(),
//       //     userId: ApiServices.userId!,
//       //     vehicleTypeId: widget.vehicleList.id!);
//       // await context
//       //     .read<BookVehicleAPIProvider>()
//       //     .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
//       //     .then((value) {
//       //   // showAboutDialog(context: context)
//       //   Utils.bookingSuccess(context);
//       //   context.read<OrderHistoryAPIProvider>().getOrders();
//       //   // Navigator.of(context).push(MaterialPageRoute(
//       //   //     builder: (context) => SuccessfulBookingScreen(
//       //   //           driverLatitude: double.parse(context
//       //   //               .read<BookVehicleAPIProvider>()
//       //   //               .vehicleCategoriesResponseModel!
//       //   //               .tripDetails!
//       //   //               .toLat!),
//       //   //           driverLongitude: double.parse(context
//       //   //               .read<BookVehicleAPIProvider>()
//       //   //               .vehicleCategoriesResponseModel!
//       //   //               .tripDetails!
//       //   //               .toLong!),
//       //   //         )));
//       // });
//     });
//   }
// }
