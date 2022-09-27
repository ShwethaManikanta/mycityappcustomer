/*
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodie/CommonWidgets/common_styles.dart';
import 'package:foodie/CommonWidgets/screen_width_and_height.dart';
import 'package:foodie/CommonWidgets/utils.dart';
import 'package:foodie/pages/login/phoneVerification/verifyScreen.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../Services/firebase_auth_service.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  PersonalDetailsPageState createState() {
    return PersonalDetailsPageState();
  }
}

class PersonalDetailsPageState extends State<PersonalDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final loginAPIProvider = Provider.of<LoginAPIProvider>(context);
    // final sharedPreferenceProvider =
    //     Provider.of<SharedPreferencesProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PhoneLoginWithPersonalDetailsFragment(),
          // TermsAndConditionsSegment()
        ],
      ),
    );
  }
}

class PhoneLoginWithPersonalDetailsFragment extends StatefulWidget {
  const PhoneLoginWithPersonalDetailsFragment({Key? key}) : super(key: key);

  @override
  _PhoneLoginFragmentState createState() => _PhoneLoginFragmentState();
}

class _PhoneLoginFragmentState
    extends State<PhoneLoginWithPersonalDetailsFragment> {
  bool _obscureText = true;
  String? deviceToken;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  String phoneNo = "Your number here";
  String? smsCode;

  TextEditingController _phoneController = TextEditingController();

  MobileNumberPicker mobileNumber = MobileNumberPicker();
  static MobileNumber mobileNumberObject = MobileNumber();

  TextEditingController mobileNumberController = TextEditingController();
  final mobileNumberKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WidgetsBinding.instance!
          .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
      mobileNumber.getMobileNumberStream.listen((MobileNumber? event) {
        if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
          setState(() {
            mobileNumberObject = event!;
            _phoneController = TextEditingController(
                text: mobileNumberObject.phoneNumber!.toString());
          });
        }
      });
    }
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  verifyPhone(BuildContext context) async {
    final firebaseAuthServiceProvider =
        Provider.of<FirebaseAuthService>(context, listen: false);

    try {
      await firebaseAuthServiceProvider
          .signInWithPhoneNumberPersonalDetails(
            "+91",
            "+91" + _phoneController.text.toString(),
            context,
          )
          .then((value) => () {})
          .catchError((e) {
        print("eroor" + e.toString());
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        Utils.showErrorDialog(context, errorMsg);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyScreen(
                phoneNumber: _phoneController.text,
                lateLogin: true,
                userName: name.text,
              )));
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(FontAwesomeIcons.arrowLeft))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "Step 1 of 2 : Add Personal Details",
                  style: CommonStyles.black12(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "Adding these details is a one time process. Next time, checkout will be a breeze",
                  maxLines: 2,
                  style: CommonStyles.blackw54s9Thin(),
                ),
              ),

              // SizedBox(
              //   height: 15,
              // ),

              // Form(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10.0, right: 10),
              //     child: TextFormField(
              //       controller: name,
              //       decoration: InputDecoration(
              //           hintStyle: CommonStyles.blackw54s9Thin(),
              //           hintText: "Name"),
              //       validator: (value) {
              //         if (value!.isEmpty || value.length < 2) {
              //           return "Minimum Length is 2";
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              //   key: nameKey,
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Text(
              //     "Phone Number".toUpperCase(),
              //     style: TextStyle(
              //         color: Colors.orange[900],
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.5, bottom: 5.5, right: 5.5, left: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: CountryCodePicker(
                        padding: EdgeInsets.all(4),
                        onChanged: print,
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'IN',
                        favorite: ['+91', 'IN'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,

                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextFormField(
                          autofocus: true,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.length < 10 || value.length > 10) {
                              return "Please Enter Valid Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIconConstraints:
                                BoxConstraints(minHeight: 0, minWidth: 0),
                            // prefixText: "+91",
                            hintText: "Enter Phone number",
                            hintStyle: TextStyle(color: Colors.black26),
                            // labelStyle: TextStyle(color: Colors.black),
                            prefixStyle: CommonStyles.black12(),
                            counterText: "",
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.orange[600]!,
                            //   ),
                            // ),
                            // prefix: Padding(
                            //   padding: const EdgeInsets.only(
                            //       right: 6.0, bottom: 3),
                            //   child: Column(
                            //     crossAxisAlignment:
                            //         CrossAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         "+91",
                            //         style: CommonStyles.black12(),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.5),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.orange[900]!,
                            //   ),
                            // ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            // fillColor: Colors.white,
                            // filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    minWidth: deviceWidth(context) * 0.93,
                    height: 45,
                    color: Colors.yellow[900],
                    child: new Text('Continue',
                        style: CommonStyles.whiteText15BoldW500()),
                    onPressed: () {
                      print("Number is ----- - - - - " + _phoneController.text);
                      if (formKey.currentState!.validate()) {
                        // print("isvalied");
                        verifyPhone(context);
                      }
                      //          setState(() {
                      //            _isNeedHelp = true;
                      //          });
                    },
                  ),

                  //  Center(
                  //     child: InkWell(
                  //   borderRadius: BorderRadius.circular(8),
                  //   highlightColor: Colors.yellow[900],
                  //   overlayColor:
                  //       MaterialStateProperty.all(Colors.yellow[900]!),
                  //   hoverColor: Colors.white,
                  //   focusColor: Colors.yellow[900],
                  //   onTap: () {},
                  //   child: Container(
                  //     width: deviceWidth(context) * 0.88,

                  //     // decoration: BoxDecoration(
                  //     //     color: Colors.yellow[900],
                  //     //     borderRadius: BorderRadius.circular(8)),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           "Continue",
                  //           style: CommonStyles.whiteText16BoldW500(),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )

                  //    Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text(
                  //   "Continue",
                  //   style: CommonStyles.whiteText16BoldW500(),
                  // ),
                  // )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsAndConditionsSegment extends StatefulWidget {
  const TermsAndConditionsSegment({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsSegmentState createState() =>
      _TermsAndConditionsSegmentState();
}

class _TermsAndConditionsSegmentState extends State<TermsAndConditionsSegment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "By continuing, you agree to our ",
          style: CommonStyles.blackw54s9Thin(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(
                      context: context, text: "Terms Of Service");
                },
                child: Text(
                  "Terms of Service",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                )),
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(context: context, text: "Privacy Policy");
                },
                child: Text(
                  "Privacy Policy",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                )),
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(context: context, text: "Content Policy");
                },
                child: Text(
                  "Content Policy",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                ))
          ],
        )
      ],
    );
  }
}

// //Email login Code ----

//    Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Text(
//                   "Email or Contact".toUpperCase(),
//                   style: TextStyle(
//                       color: Colors.orange[900],
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 15),
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: TextFormField(
//                   controller: email,
//                   keyboardType: TextInputType.text,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "Enter Your Email or Mobile number",
//                     hintStyle: TextStyle(color: Colors.black26),
//                     labelStyle: TextStyle(color: Colors.black),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.orange[600]!,
//                       ),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.orange[900]!,
//                       ),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                     fillColor: Colors.white,
//                     isDense: true,
//                     filled: true,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 25.0),
//                 child: Text(
//                   "Password".toUpperCase(),
//                   style: TextStyle(
//                       color: Colors.orange[900],
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 15),
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: TextFormField(
//                   controller: password,
//                   keyboardType: TextInputType.text,
//                   obscureText: _obscureText,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "Enter Your Password",
//                     hintStyle: TextStyle(color: Colors.black26),
//                     labelStyle: TextStyle(color: Colors.black),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.orange[600]!,
//                       ),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.orange[900]!,
//                       ),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                     fillColor: Colors.white,
//                     isDense: true,
//                     filled: true,
//                     suffix: InkWell(
//                       onTap: _toggle,
//                       child: Text(
//                         _obscureText ? "SHOW" : "HIDE",
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, 'ForgotPassword');
//                   },
//                   child: Text("Forgot Password ?",
//                       style: TextStyle(
//                           color: Colors.orange[900],
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 width: double.maxFinite,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (formKey.currentState!.validate()) {
//                       CoolAlert.show(
//                           context: context, type: CoolAlertType.loading);
//                       await loginAPIProvider.emailLogin(
//                           email: email.value.text,
//                           password: password.value.text,
//                           deviceToken: deviceToken!,
//                           deviceType: "customer_app");
//                       // print("-------" +
//                       //     loginAPIProvider.loginResponse!.status.toString());
//                       // print(loginAPIProvider.loginResponse != null);

//                       if (loginAPIProvider.error) {
//                         Navigator.of(context).pop();

//                         CoolAlert.show(
//                           context: context,
//                           type: CoolAlertType.error,
//                           title: "Failed",
//                           text: loginAPIProvider.errorMessage,
//                         );
//                       } else if (loginAPIProvider.loginResponse != null &&
//                           loginAPIProvider.loginResponse!.status == "0") {
//                         Navigator.of(context).pop();

//                         CoolAlert.show(
//                             context: context,
//                             type: CoolAlertType.error,
//                             title: "Login Failed",
//                             text: loginAPIProvider.loginResponse!.message);
//                       } else {
//                         await sharedPreferenceProvider.setIsUserLoggedIn(
//                             userLoginStatus: true);
//                         await sharedPreferenceProvider.setUserId(
//                             userId: loginAPIProvider
//                                 .loginResponse!.driverDetails!.id!);
//                         Navigator.pushReplacementNamed(context, 'GetLocation');
//                         // ApiServices.sharedPreferences
//                         //     .setString(
//                         //         "userId",
//                         //         loginAPIProvider
//                         //             .loginResponse!.driverDetails!.id!)
//                         //     .then((value2) {
//                         //   if (value2) {}
//                         // });
//                       }
//                     }
//                     print("Moving to get location ");
//                     // apiServices
//                     //     .logIn(
//                     //         email.value.text, password.value.text, deviceToken!)
//                     //     .then((value) {
//                     //   Navigator.pop(context);
//                     //   if (value["status"]) {
//                     //   } else {
//                     //     CoolAlert.show(
//                     //       context: context,
//                     //       type: CoolAlertType.error,
//                     //       title: "Failed",
//                     //       text: "${value['msg']}",
//                     //     );
//                     //   }
//                     // });
//                   },
//                   child: Text("Log In",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold)),
//                   style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color?>(Colors.orange[900]),
//                       shape: MaterialStateProperty.all<OutlinedBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                       )),
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Don't have an account?",
//                       style: TextStyle(
//                         color: Colors.orange[900],
//                         fontSize: 16,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, "SignUp");
//                     },
//                     child: Container(
//                       child: Text("Register",
//                           style: TextStyle(
//                               color: Colors.orange[900],
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
*/
