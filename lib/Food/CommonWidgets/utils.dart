import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/pages/custom_divider_view.dart';


CustomDividerView buildDivider() => CustomDividerView(
      dividerHeight: 1.0,
      color: Colors.grey[400],
    );

class Utils {
  static getSizedBox({double width = 0, double height = 10}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Widget showLoading() {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        strokeWidth: 1,
      ),
    );
  }

  static Widget showLoadingWithColor(Color color) {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: color,
      ),
    );
  }

  static Widget showLoadingCustomText(String text, BuildContext context) {
    return SizedBox(
      height: 80,
      width: deviceWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 1,
          ),
          Utils.getSizedBox(height: 10),
          Text(
            text,
            style: CommonStyles.black57S14(),
          )
        ],
      ),
    );
  }

  static Widget showLoadingFittedBox() {
    return FittedBox(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: Colors.white,
      ),
    );
  }

  static Widget showErrorMessage(String errMessage) {
    return Center(
        child: Text(
      errMessage,
      style: CommonStyles.red12(),
    ));
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Sending OTP...")),
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
    return Divider(
      color: Colors.black,
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
        title: Text(
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
            child: Text('OK!'),
          )
        ],
      ),
    );
  }
}

showLoadDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Container(
            padding: EdgeInsets.only(left: 10), child: Text("Loading...")),
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

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
