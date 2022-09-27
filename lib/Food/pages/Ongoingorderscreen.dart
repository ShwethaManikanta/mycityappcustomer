import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycityapp/Food/Models/OrderDetails.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';

class OngoingOrders extends StatefulWidget {
  final String? orderId;

  const OngoingOrders({Key? key, this.orderId}) : super(key: key);

  @override
  _OngoingOrdersState createState() => _OngoingOrdersState();
}

class _OngoingOrdersState extends State<OngoingOrders> {
  GoogleMapController? mapController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        buildData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildData();
  }

  Widget buildData() {
    return FutureBuilder<OrderDetails?>(
        future: apiService.getOrderList(context, widget.orderId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(150.0), // here the desired height
                    child: AppBar(
                      backgroundColor: swiggyOrange,
                      centerTitle: true,
                      flexibleSpace: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 50, right: 50),
                        child: Center(
                            child: ListView.builder(
                                itemCount: snapshot.data!.getOrderList!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Text(
                                        "Order from".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                      Text(
                                        snapshot.data!.getOrderList![index]
                                            .customerName!.customerName!,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot
                                            .data!.getOrderList![index].status!,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.orangeAccent
                                                  .withOpacity(0.3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: snapshot
                                                        .data!
                                                        .getOrderList![index]
                                                        .status !=
                                                    "Delivered Your Order"
                                                ? Text(
                                                    "Arriving within " +
                                                        snapshot
                                                            .data!
                                                            .getOrderList![
                                                                index]
                                                            .hotelDetails!
                                                            .deliveryTime!,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    "Enjoy,Taste your ordered foods",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                          )),
                                    ],
                                  );
                                })),
                      ),
                    )),
                body: ListView.builder(
                    itemCount: snapshot.data!.getOrderList!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 350,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(10.7905, 78.7047),
                                zoom: 5,
                              ),
                              zoomControlsEnabled: true,
                              myLocationEnabled: true,
                              tiltGesturesEnabled: false,
                              compassEnabled: false,
                              scrollGesturesEnabled: false,
                              zoomGesturesEnabled: false,
                              onMapCreated: _onMapCreated,
                              // markers: Set<Marker>.of(markers.values),
                              // polylines: Set<Polyline>.of(polylines.values),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Restaurant details: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: swiggyOrange,
                                      fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.getOrderList![i]
                                          .hotelDetails!.outletName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FlutterPhoneDirectCaller.callNumber(
                                              snapshot.data!.getOrderList![i]
                                                  .hotelDetails!.mobile!);
                                        },
                                        icon: Icon(Icons.phone))
                                  ],
                                ),
                                Text(
                                  snapshot.data!.getOrderList![i].hotelDetails!
                                      .outletAddress!,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: snapshot
                                  .data!.getOrderList![i].productDetails!
                                  .map((e) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.productName!),
                                    Text("Rs. " + e.price.toString()),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery boy details: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: swiggyOrange,
                                      fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.getOrderList![i]
                                          .driverDetails!.deliveryBoyName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FlutterPhoneDirectCaller.callNumber(
                                              snapshot.data!.getOrderList![i]
                                                  .driverDetails!.mobile!);
                                        },
                                        icon: Icon(Icons.phone))
                                  ],
                                ),
                                Text(
                                  "Vehicle no: " +
                                      snapshot.data!.getOrderList![i]
                                          .driverDetails!.vehicleNo!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }
}
