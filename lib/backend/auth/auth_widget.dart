import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/pages/onboarding_screen.dart';
import 'package:mycityapp/common/common_styles.dart';
import '../../main.dart';
import '../service/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    Key? key,
    required this.userSnapshot,
  }) : super(key: key);
  final AsyncSnapshot<LoggedInUser?> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? const GetLoginUser() : Onboarding();
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 1,
            color: Colors.blueGrey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "Authenticating",
              style: CommonStyles.black12(),
            ),
          )
        ],
      ),
    );
  }
}
