import 'package:flutter/material.dart';
import 'package:mycityapp/Food/pages/cart/modelcartscreen.dart';

import 'app_colors.dart';

class PaymentFailure extends StatefulWidget {
  final String? title;
  const PaymentFailure({Key? key, this.title}) : super(key: key);

  @override
  _PaymentFailureState createState() => _PaymentFailureState();
}

class _PaymentFailureState extends State<PaymentFailure> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.popAndPushNamed(context, 'Home')
            .then((value) => value as bool);
      } as Future<bool> Function()?,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://st2.depositphotos.com/33945136/41968/v/950/depositphotos_419680874-stock-illustration-icon-payment-failed-cancel-card.jpg"),
                      fit: BoxFit.contain)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModelCartScreen("")),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: swiggyOrange),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Go to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
