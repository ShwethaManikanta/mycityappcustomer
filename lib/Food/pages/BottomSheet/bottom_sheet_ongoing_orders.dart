import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Services/ongoing_order_api.dart';
import 'package:mycityapp/Food/Services/order_history_api_provider.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:provider/provider.dart';

import '../../CommonWidgets/common_styles.dart';
import '../../CommonWidgets/screen_width_and_height.dart';
import '../cart/modelcartscreen.dart';

// class BottomCartSheetOnGoingOrder extends StatefulWidget {
//   const BottomCartSheetOnGoingOrder({Key? key}) : super(key: key);

//   @override
//   _BottomCartSheetState createState() => _BottomCartSheetState();
// }

// class _BottomCartSheetState extends State<BottomCartSheetOnGoingOrder> {
//   @override
//   void initState() {
//     if (context.read<OngoingOrderAPIProvider>().orderHistoryResponseModel ==
//         null) {
//       context.read<OngoingOrderAPIProvider>().getOrderHistory();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ongoingOrderHistory = Provider.of<OngoingOrderAPIProvider>(context);
//     // print(
//     //     "bottom sheet -- - - - - - -- - - - - - - - - - -          -----------");
//     if (ongoingOrderHistory.orderHistoryResponseModel == null) {
//       // print("------- Cart List Response is status 0 -_____----" +
//       //     cartListAPIProvider.cartResponseModel.toString());

//       return SizedBox(
//         height: 0,
//         width: 0,
//       );
//     } else if (ongoingOrderHistory.orderHistoryResponseModel!.status == "0") {
//       print("------- Cart List Response is status 0 -_____----");
//       return SizedBox(
//         height: 0,
//         width: 0,
//       );
//     } else if (ongoingOrderHistory
//         .orderHistoryResponseModel!.orderOngoing!.isEmpty) {
//       print("------- Cart List Response is status 0 -_____----");
//       return SizedBox(
//         height: 0,
//         width: 0,
//       );
//     } else {
//       // return ListView.builder(
//       //     shrinkWrap: true,
//       //     itemCount: 1,
//       //     itemBuilder: (context, index) {
//       //       return Column(
//       //         children: [
//       return Container(
//         height: 50,
//         width: deviceWidth(context),
//         decoration: BoxDecoration(
//           // color: Colors.green,
//           gradient: LinearGradient(
//               colors: [Colors.indigo, Colors.blue, Colors.indigo]),
//           /*  borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8), topRight: Radius.circular(8))*/
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Total Items " +
//                         ongoingOrderHistory.orderHistoryResponseModel!
//                             .orderOngoing!.first.productDetails!.length
//                             .toString(),
//                     style: CommonStyles.whiteText12BoldW500(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8),
//                     child: Container(width: 1, color: Colors.white),
//                   ),
//                   Text(
//                     "Rs. " +
//                         ongoingOrderHistory.orderHistoryResponseModel!
//                             .orderOngoing!.first.total
//                             .toString(),
//                     style: CommonStyles.whiteText12BoldW500(),
//                   )
//                 ],
//               ),
//               TextButton(
//                   onPressed: () {
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: (context) => ModelCartScreen("")));
//                   },
//                   child: Text(
//                     "View Details",
//                     style: CommonStyles.whiteText12BoldW500(),
//                   ))
//             ],
//           ),
//         ),
//       );
//       //     ],
//       //   );
//       // });
//     }
//   }
// }

// // class BottomCartSheetAllRestaurant extends StatefulWidget {
// //   const BottomCartSheetAllRestaurant({Key? key}) : super(key: key);

// //   @override
// //   _BottomCartSheetAllRestaurantState createState() =>
// //       _BottomCartSheetAllRestaurantState();
// // }

// // class _BottomCartSheetAllRestaurantState
// //     extends State<BottomCartSheetAllRestaurant> {
// //   @override
// //   void initState() {
// //     if (context.read<CartListAPIProvider>().cartResponseModel == null) {
// //       context
// //           .read<CartListAPIProvider>()
// //           .cartlist(SharedPreference.latitude, SharedPreference.longitude, "");
// //     }
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);
// //     if (cartListAPIProvider.cartResponseModel == null) {
// //       return SizedBox(
// //         height: 0,
// //         width: 0,
// //       );
// //     } else if (cartListAPIProvider.cartResponseModel!.status == "0") {
// //       print("------- Cart List Response is status 0 -_____----");
// //       return SizedBox(
// //         height: 0,
// //         width: 0,
// //       );
// //     }
// //     return ListView.builder(
// //         shrinkWrap: true,
// //         itemCount: 1,
// //         itemBuilder: (context, index) {
// //           return Column(
// //             children: [
// //               Container(
// //                 height: 50,
// //                 width: deviceWidth(context),
// //                 decoration: BoxDecoration(
// //                     color: Colors.green,
// //                     borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(8),
// //                         topRight: Radius.circular(8))),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           Text(
// //                             "Total Items " +
// //                                 cartListAPIProvider
// //                                     .cartResponseModel!.productDetails!.length
// //                                     .toString(),
// //                             style: CommonStyles.whiteText12BoldW500(),
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.only(left: 8.0, right: 8),
// //                             child: Container(width: 1, color: Colors.white),
// //                           ),
// //                           Text(
// //                             "Rs. " +
// //                                 cartListAPIProvider.cartResponseModel!.subTotal!
// //                                     .toString(),
// //                             style: CommonStyles.whiteText12BoldW500(),
// //                           )
// //                         ],
// //                       ),
// //                       TextButton(
// //                           onPressed: () {
// //                             Navigator.of(context).push(MaterialPageRoute(
// //                                 builder: (context) => ModelCartScreen("")));
// //                           },
// //                           child: Text(
// //                             "View Cart",
// //                             style: CommonStyles.whiteText12BoldW500(),
// //                           ))
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           );
// //         });
// //   }
// // }
