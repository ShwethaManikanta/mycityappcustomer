import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycityapp/Food/Models/newcartmodel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';

class PaymentSuccess extends StatefulWidget {
  final String? tax_amount;
  final String? order_id;
  final String? tax_date_time;
  final String? reference_no;
  final CartNewModel? model;

  const PaymentSuccess(
      {Key? key,
      this.tax_amount,
      this.reference_no,
      this.tax_date_time,
      this.order_id,
      this.model})
      : super(key: key);

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormate = DateFormat('dd-MM-yyyy hh:mm:ss')
        .format(DateTime.parse(widget.tax_date_time!));

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, 'CartScreen');
                    },
                    icon: Icon(Icons.arrow_back))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://thumbs.dreamstime.com/b/payment-successful-template-vector-art-success-ful-206586442.jpg"),
                    fit: BoxFit.fill)),
          ),
          Text("Rs. ${widget.tax_amount}",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: swiggyOrange)),
          UIHelper.verticalSpaceLarge(),
          Text("ORDERID: ${widget.order_id}"),
          UIHelper.verticalSpaceMedium(),
          Text(dateFormate.toString()),
          UIHelper.verticalSpaceMedium(),
          Text("Ref. No. : ${widget.reference_no}"),
          UIHelper.verticalSpaceMedium(),
          GestureDetector(
            onTap: () {
              apiService
                  .buyProduct(
                context,
                widget.model!.subTotal,
                widget.model!.deliveryFee,
                widget.model!.taxes,
                widget.model!.total.toString(),
                widget.model!.getAllAddressCustomer!.address,
                widget.model!.retailerDetails!.first.id,
                SharedPreference.latitudeValue,
                SharedPreference.longitudeValue,
              )
                  .then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPlaced()),
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: swiggyOrange!.withOpacity(0.8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Buy your Order",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({Key? key}) : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, 'Home');
                    },
                    icon: Icon(Icons.arrow_back))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "http://www.daecontrols.com/images/onepage/order-received.jpg"),
                    fit: BoxFit.fitHeight)),
          ),
          Text(
            "Yay! Order Recieved",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          UIHelper.verticalSpaceMedium(),
          Text(
            "Your order will be delivered shortly. Keep foodieing!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
