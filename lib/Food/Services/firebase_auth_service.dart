import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class LoggedInUser {
  const LoggedInUser(
      {required this.uid,
      required this.phoneNo,
      required this.name,
      required this.email});
  final String uid;
  final String phoneNo;
  final String name;
  final String email;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //VerificationId in when otp is generated
  String? verificationId;

  LoggedInUser? _userFromFirebase(User? user) {
    return user == null
        ? null
        : LoggedInUser(
            uid: user.uid,
            phoneNo: user.phoneNumber == null ? "" : user.phoneNumber!,
            name: user.displayName == null ? "" : user.displayName!,
            email: user.email == null ? "" : user.email!);
  }

  Stream<LoggedInUser?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<LoggedInUser?> signInAnonymously() async {
    try {
      final authResult = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(authResult.user);
    } catch (e) {
      throw e;
    }
  }

  //Phone authentication implicitly.. when device reads auto code
  Future<LoggedInUser?> signInWithCredential(AuthCredential credential) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(userCredential.user);
  }

  Future<LoggedInUser?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAUthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAUthentication.accessToken,
          idToken: googleSignInAUthentication.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      final User currentUser = _firebaseAuth.currentUser!;
      // print(currentUser.toString());
      return _userFromFirebase(currentUser);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> isGoogleLoggedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  bool isAnonymusSignIn() {
    return _firebaseAuth.currentUser!.isAnonymous;
  }

  // void signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
  //   _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential credential) async {
  //         return await signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException exception) {
  //         print(exception);
  //       },
  //       codeSent: (String verificationId, [int forceResendingToken]) {
  //         showDialogWidget(verificationId, context);
  //       },
  //       codeAutoRetrievalTimeout: null);
  // }

  Future<void> signOut({required bool googleSignIn}) async {
    if (googleSignIn) {
      await _googleSignIn.signOut();
    }
    return await _firebaseAuth.signOut();
  }

  Future<void> signInWithPhoneNumber(
      String countryCode, String mobile, BuildContext context,
      {Widget? pushWidget}) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      print("The processing phone numbere is  - - - - - - - - - - " +
          mobileToSend);
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            print('Verification Complete');

            await _firebaseAuth
                .signInWithCredential(phoneAuthCredential)
                .then((value) {
              _userFromFirebase(value.user);
              print(
                  "SIgn in wiht credentisl - - - - - - ---  - - -- - -  - success");
              if (pushWidget != null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => pushWidget));
              }
            });

            // });

            print("Verification Complete" + phoneAuthCredential.toString());
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> signInWithPhoneNumberPersonalDetails(
    String countryCode,
    String mobile,
    BuildContext context,
  ) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      print("The processing phone numbere is  - - - - - - - - - - " +
          mobileToSend);
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            print('Verification Complete');

            await _firebaseAuth
                .signInWithCredential(phoneAuthCredential)
                .then((value) {
              _userFromFirebase(value.user);
              print(
                  "SIgn in wiht credentisl - - - - - - ---  - - -- - -  - success");
              Navigator.of(context).pop("Success");
              Navigator.of(context).pop("Success");
            });
            // });
            print("Verification Complete" + phoneAuthCredential.toString());
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      final UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      final User currentUser = _firebaseAuth.currentUser!;
      print(user);
      _userFromFirebase(currentUser);

      if (currentUser.uid != "") {
        print(currentUser.uid);
      }
    } catch (e) {
      throw e;
    }
  }
}



// showDialogWidget(String verificationId, BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         final _codeController = new TextEditingController();
  //         return AlertDialog(
  //           contentPadding: EdgeInsets.all(40),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //           title: Text(
  //             'Please Enter SMS Code:',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //                 shadows: [
  //                   Shadow(
  //                     offset: Offset(0.2, 0.2),
  //                     blurRadius: 0.5,
  //                     color: Colors.brown[300],
  //                   )
  //                 ],
  //                 color: Colors.black54,
  //                 backgroundColor: Colors.transparent,
  //                 fontSize: 20,
  //                 decorationThickness: 1,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Roboto'),
  //           ),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               TextField(
  //                 controller: _codeController,
  //                 cursorColor: Colors.blue,
  //                 decoration: InputDecoration(
  //                   hintText: 'OTP Number',
  //                   hintStyle: TextStyle(
  //                       fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
  //                   filled: false,
  //                   fillColor: Colors.blueAccent,
  //                   contentPadding: const EdgeInsets.only(
  //                       left: 14.0, bottom: 6.0, top: 8.0),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(8)),
  //                     borderSide: BorderSide(width: 2, color: Colors.blue),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () async {
  //                 final smsCode = _codeController.text.trim();
  //                 AuthCredential credential = PhoneAuthProvider.credential(
  //                     verificationId: verificationId, smsCode: smsCode);
  //                 final user = await signInWithCredential(credential);
  //                 if (user != null) {
  //                   // _codeController.clear();
  //                   _codeController.dispose();
  //                 }
  //                 Navigator.pop(context);
  //                 print(user.uid);
  //               },
  //               child: Text(
  //                 'Confirm'.toUpperCase(),
  //                 style: TextStyle(
  //                     shadows: [
  //                       Shadow(
  //                         offset: Offset(1.0, 1.0),
  //                         blurRadius: 3.0,
  //                         color: Color.fromARGB(190, 0, 0, 0),
  //                       )
  //                     ],
  //                     color: Colors.white,
  //                     backgroundColor: Colors.transparent,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Montserrat'),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }