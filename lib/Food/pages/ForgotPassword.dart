import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';

class ForgortPassword1 extends StatefulWidget {
  @override
  _ForgortPassword1State createState() => _ForgortPassword1State();
}

class _ForgortPassword1State extends State<ForgortPassword1> {
  TextEditingController mobileNumber = TextEditingController();
  String? otp;
  String? userId;
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/1617019294280.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Contact Number".toUpperCase(),
                    style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: mobileNumber,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile number",
                      hintStyle: TextStyle(color: Colors.black26),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange[600]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange[900]!,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: PinFieldAutoFill(
                //       decoration: UnderlineDecoration(
                //         textStyle: TextStyle(fontSize: 20, color: Colors.black),
                //         colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                //       ),
                //       currentCode: "",
                //       onCodeSubmitted: (val) {},
                //       //code submitted callback
                //       onCodeChanged: (val) {},
                //       //code changed callback
                //       codeLength: 4 //code length, default 6
                //       ),
                // ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      CoolAlert.show(
                          context: context, type: CoolAlertType.loading);
                      apiService
                          .getOtp(
                        mobileNumber.value.text,
                      )
                          .then((value) {
                        Navigator.pop(context);
                        if (value["status"]) {
                          setState(() {
                            otp = value["otp"];
                            userId = value["user_id"];
                          });
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            title: "Success",
                            text: "${value['message']}",
                          );
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Failed",
                            text: "${value['msg']}",
                          );
                        }
                      });
                    },
                    child: Text("Send OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.orange[900]),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ),
                ),
                otp == null
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "OTP".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: otpController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Enter OTP",
                                hintStyle: TextStyle(color: Colors.black26),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[600]!,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[900]!,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "New Password".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: newPassword,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Enter New Password",
                                hintStyle: TextStyle(color: Colors.black26),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[600]!,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[900]!,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "Confirm Password".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: confirmPassword,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Confirm New Password",
                                hintStyle: TextStyle(color: Colors.black26),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[600]!,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange[900]!,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {
                                if (otp == otpController.value.text) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.loading);
                                  apiService
                                      .resetPassword(
                                    userId!,
                                    newPassword.value.text,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                    if (value["status"]) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        title: "Success",
                                        text: "${value['msg']}",
                                      ).then((value) {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        title: "Failed",
                                        text: "${value['msg']}",
                                      );
                                    }
                                  });
                                } else {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    title: "Incorrect",
                                    text: "Please enter correct OTP.",
                                  );
                                }
                              },
                              child: Text("Reset",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color?>(
                                          Colors.orange[900]),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Remember Password?",
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text("Log In",
                            style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
