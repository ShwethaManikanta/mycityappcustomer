import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/PaymentOffersModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/available_coupon.dart';
import 'package:mycityapp/Food/pages/cart/modelcartscreen.dart';
import 'package:mycityapp/Food/pages/custom_divider_view.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';

class PaymentOffersCouponView extends StatelessWidget {
  final String totalPrice;
  final bool appbar;

  PaymentOffersCouponView(this.totalPrice, this.appbar);

  @override
  Widget build(BuildContext context) {
    final coupons = AvailableCoupon.getAvailableCoupons();

    return Scaffold(
      appBar: appbar
          ? AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              title: Text(
                "APPLY COUPONS",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
          : null,
      body: FutureBuilder<PaymentOfferModel>(
          future: apiService.paymentcoupon(totalPrice),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: "Enter Coupon Code",
                    //       suffixText: "APPLY",
                    //       suffixStyle: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    //       hintText: "Avalilable Coupon Code",
                    //     ),
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15.0),
                      height: 40.0,
                      color: Colors.grey[200],
                      child: Text('Available Coupons'.toUpperCase(),
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.payment_offers!.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      border:
                                          Border.all(color: Colors.grey[400]!),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/food1.jpg',
                                          height: 10.0,
                                          width: 10.0,
                                          fit: BoxFit.cover,
                                        ),
                                        UIHelper.horizontalSpaceMedium(),
                                        Text(
                                            snapshot
                                                .data!
                                                .payment_offers![index]
                                                .coupon_name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2)
                                      ],
                                    ),
                                  ),
                                  snapshot.data!.payment_offers![index]
                                              .apply_status !=
                                          0
                                      ? GestureDetector(
                                          onTap: () {
                                            print(
                                                "coupon name:+${snapshot.data!.payment_offers![index].coupon_name}");
                                            apiService.modelcartlist(
                                                context,
                                                SharedPreference.latitudeValue,
                                                SharedPreference.longitudeValue,
                                                snapshot
                                                    .data!
                                                    .payment_offers![index]
                                                    .coupon_name);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ModelCartScreen(snapshot
                                                          .data!
                                                          .payment_offers![
                                                              index]
                                                          .coupon_name)),
                                            );
                                          },
                                          child: Text(
                                            "Apply".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Text(
                                          "Apply".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                snapshot.data!.payment_offers![index]
                                        .percentage_amount! +
                                    " Percentage amount",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              CustomDividerView(
                                dividerHeight: 1.0,
                                color: Colors.grey,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              Text(
                                "Use code " +
                                    snapshot.data!.payment_offers![index]
                                        .coupon_name! +
                                    "& get " +
                                    snapshot.data!.payment_offers![index]
                                        .percentage_amount! +
                                    " discount" +
                                    " upto Rs." +
                                    snapshot
                                        .data!.payment_offers![index].up_to!,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              InkWell(
                                child: Text(
                                  '+ MORE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
