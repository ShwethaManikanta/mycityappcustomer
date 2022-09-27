import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildDetailsBottomBar(
  BuildContext context,
  Map hotel,
  Color defaultColor,
  Color secondColor,
  Size size,
) {
  return Padding(
    padding: EdgeInsets.only(
      top: size.height * 0.01,
      left: size.width * 0.08,
      right: size.width * 0.08,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
/*            Text(
              'Total Price',
              style: GoogleFonts.poppins(
                color: defaultColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  "\$ ${hotel['price']}",
                  style: GoogleFonts.poppins(
                    color: defaultColor,
                    fontSize: size.height * 0.035,
                    fontWeight: FontWeight.w600,
                    wordSpacing: -3.5,
                  ),
                ),
                Text(
                  ' /day',
                  style: GoogleFonts.poppins(
                    color: defaultColor.withOpacity(0.8),
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),*/
          ],
        ),
        InkWell(
          onTap: () async {
            await showAlertDialog(context);
          }, //TODO: add book now action
          child: Container(
            width: size.width * 0.35,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              child: Text(
                'Book Now',
                style: GoogleFonts.lato(
                  color: secondColor,
                  fontSize: size.height * 0.02,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Message from Admin"),
    content: Text("You will receive a call from Admin !!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
