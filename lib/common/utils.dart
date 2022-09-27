import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/pages/orderPage/order_page.dart';
import 'package:mycityapp/common/custom_divider.dart';
import 'common_styles.dart';

CustomDividerView buildDivider() => CustomDividerView(
      dividerHeight: 1.0,
      color: Colors.grey[400],
    );

class Utils {
  static getSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static thinDivider() {
    return const Divider(
      color: Colors.black26,
      height: 1,
      thickness: 0.7,
    );
  }

  static getCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: Colors.black45,
      ),
    );
  }

  static getThinCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: Colors.blue,
      ),
    );
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSendingOTP(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Sending OTP...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget showErrorMessage(String errMessage) {
    return Center(
        child: Text(
      errMessage,
      style: CommonStyles.red12(),
    ));
  }

  static showBookingVehicle(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Booking Vehicle...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget dividerThin() {
    return const Divider(
      color: Colors.blue,
      height: 5,
      thickness: 0.5,
    );
  }

  static showSnackBar({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: CommonStyles.whiteText12BoldW500(),
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Error Occured',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          message,
          style: CommonStyles.errorTextStyleStyle(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }

  static bookingSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Booking Successful!',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          " You can check this booking staus on Orders Page!!",
          style: CommonStyles.green12(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OrderPage()));
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }
}

showLoadDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text("Loading...")),
      ],
    ),
  );
  return showDialog(
    barrierDismissible: false,
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
