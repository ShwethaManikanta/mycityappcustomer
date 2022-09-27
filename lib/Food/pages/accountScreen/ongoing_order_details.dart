import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/Services/ongoing_order_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../CommonWidgets/utils.dart';
import '../ui_helper.dart';

class OngoingOrderDetailsPage extends StatefulWidget {
  const OngoingOrderDetailsPage({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  State<OngoingOrderDetailsPage> createState() =>
      _OngoingOrderDetailsPageState();
}

class _OngoingOrderDetailsPageState extends State<OngoingOrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomNavigationBarOngoingOrderDetails(),
      body: GoogleMapsScreenOrderDetails(),
    );
  }

  bottomNavigationBarOngoingOrderDetails() {
    final ongoingOrderHistoryProvider =
        Provider.of<OngoingOrderAPIProvider>(context);
    if (ongoingOrderHistoryProvider.ifLoading) {
      print("Loading Details");
      return Center(
        child: Utils.showLoading(),
      );
    } else if (ongoingOrderHistoryProvider.error) {
      print("Error Found");

      return Utils.showErrorMessage(ongoingOrderHistoryProvider.errorMessage);
    } else if (ongoingOrderHistoryProvider.orderHistoryResponseModel != null &&
        ongoingOrderHistoryProvider.orderHistoryResponseModel!.status == '0') {
      print("Status is 0");

      return Utils.showErrorMessage(
          ongoingOrderHistoryProvider.orderHistoryResponseModel!.message!);
    } else {
      print("Success Status");

      return Container(
        height: deviceHeight(context) * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ORDER ID " +
                        "#C2BPDOID0" +
                        ongoingOrderHistoryProvider.orderHistoryResponseModel!
                            .orderOngoing![widget.index].id!,
                    style: CommonStyles.black11(),
                  ),
                  // Utils.getSizedBox(height: 5),
                  // Text(
                  //   "11:40 PM",
                  //   style: CommonStyles.black10Thin(),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "To " +
                    ongoingOrderHistoryProvider.orderHistoryResponseModel!
                        .orderOngoing![widget.index].address!,
                overflow: TextOverflow.clip,
                style: CommonStyles.black12(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery in 10 mins",
                    style: CommonStyles.blackS15(),
                  ),
                  Utils.getSizedBox(height: 5),
                  LinearProgressIndicator(
                    value: 0.2,
                    backgroundColor: Colors.black54,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black54, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All items are packed",
                          style: CommonStyles.black11(),
                        ),
                        InkWell(
                            onTap: () {
                              showDeliveryItemsBottomSheet();
                            },
                            child: Text(
                              "See all items",
                              style: CommonStyles.blue11(),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: Colors.brown,
                              ),
                              Utils.getSizedBox(width: 5),
                              RichText(
                                  text: TextSpan(
                                      children: [
                                    TextSpan(
                                        text: "ready for pick up ",
                                        style: CommonStyles.black10Thin())
                                  ],
                                      text: "Order ",
                                      style: CommonStyles.black54s10Thin())),
                            ],
                          ),
                        ),
                        Divider(
                          height: 0.5,
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Icon(Icons.image),
                              Utils.getSizedBox(width: 5),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                          maxLines: 3,
                                          text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        " is waiting at the store to pickup your order",
                                                    style: CommonStyles
                                                        .black10Thin())
                                              ],
                                              text: "Arun Arun S",
                                              style: CommonStyles
                                                  .black54s10Thin())),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.call),
                                      padding: EdgeInsets.zero,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            "Your delivery items are kept neat and clean!",
                            style: CommonStyles.black54s10Thin(),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  showDeliveryItemsBottomSheet() {
    final ongoingOrderHistoryProvider =
        Provider.of<OngoingOrderAPIProvider>(context, listen: false);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 4),
                  child: Text(
                    "Ordered Items",
                    style: CommonStyles.blue12thin(),
                  ),
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.40,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: ScrollPhysics(),
                    children: ongoingOrderHistoryProvider
                        .orderHistoryResponseModel!
                        .orderOngoing![widget.index]
                        .productDetails!
                        .map((e) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      ongoingOrderHistoryProvider
                                              .orderHistoryResponseModel!
                                              .menuProfileurl! +
                                          e.productImage!),
                                ),
                                UIHelper.horizontalSpaceExtraSmall(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      e.productName!,
                                      style: CommonStyles.black11(),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      children: [
                                        Text(
                                          "${e.qty} Qty",
                                          style: CommonStyles.black10Thin(),
                                        ),
                                        Text(
                                          " - ",
                                        ),
                                        Text(
                                          "Rs. " + e.price.toString(),
                                          style: CommonStyles.black10Thin(),
                                        ),
                                      ],
                                    ),

                                    // CustomDividerView(dividerHeight: 1.5, color: Colors.black)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.blue,
                      minWidth: deviceWidth(context) * 0.8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ok",
                          style: CommonStyles.whiteText12BoldW500(),
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

class GoogleMapsScreenOrderDetails extends StatefulWidget {
  const GoogleMapsScreenOrderDetails({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreenOrderDetails> createState() =>
      _GoogleMapsScreenOrderDetailsState();
}

class _GoogleMapsScreenOrderDetailsState
    extends State<GoogleMapsScreenOrderDetails> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  buildMap() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);
    return SizedBox(
      height: deviceHeight(context) * 0.5,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        // polylines: Set<Polyline>.of(homePageProvider.polylines.values),
        onMapCreated: _onMapCreated,
        // markers: Set<Marker>.of(homePageProvider.markerSet),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: true,
      ),
    );
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    // final homePageProvider =
    //     Provider.of<HomePageProvider>(context, listen: false);
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));

    // _controller = _cntlr;
    // _location.onLocationChanged.listen((l) {
    //   _controller!.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
    //     ),
    //   );
    // });

    // homePageProvider.googleMapController = _cntlr;
    // homePageProvider.addMarkers(
    //     markerId: "Destination Marker",
    //     latitude: widget.toLatitude,
    //     longitude: widget.toLongitude);
    // homePageProvider.getDistance(widget.toLatitude, widget.toLongitude);
  }
}
