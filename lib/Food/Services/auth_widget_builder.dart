import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_auth_service.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(
      BuildContext context, AsyncSnapshot<LoggedInUser?> isLoggedIn) builder;

  // @override
  // Widget build(BuildContext context) {
  //   final sharedPreferenceProvider =
  //       Provider.of<SharedPreferencesProvider>(context);
  //   return FutureBuilder<bool>(
  //       future: sharedPreferenceProvider.getIsUserLoggedIn(),
  //       builder: (_, asyncSnapshot) {
  //         if (asyncSnapshot.connectionState == ConnectionState.waiting) {
  //           return Container(
  //             color: Colors.white,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 CircularProgressIndicator(
  //                   strokeWidth: 1,
  //                   color: Colors.black,
  //                   backgroundColor: Colors.brown[200],
  //                 ),
  //                 Utils.getSizedBox(height: 15),
  //                 Text(
  //                   "Initializing",
  //                   textDirection: TextDirection.ltr,
  //                   style: GoogleFonts.montserrat(
  //                       textStyle: TextStyle(
  //                     color: Colors.yellow[900],
  //                     backgroundColor: Colors.transparent,
  //                     fontSize: 14,
  //                     letterSpacing: 0.3,
  //                     fontWeight: FontWeight.w400,
  //                   )),
  //                 )
  //               ],
  //             ),
  //           );
  //         } else {
  //           print(asyncSnapshot.data);
  //           return builder(context, asyncSnapshot.data!);
  //         }
  //       });

  //   // if (provider.status == SharedPreferencesInitializationStatus.initialized) {}
  //   // return builder(context, provider.isUserLoggedIn, provider.viewedSplashPage);
  // }

  initializeSharedPreference() async {
    await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<LoggedInUser?>(
        stream: authService.onAuthStateChanged,
        builder: (context, snapshot) {
          final user = snapshot.data;

          if (user != null) {
            return MultiProvider(providers: [
              Provider<LoggedInUser>.value(value: user),
              // Provider<FirebaseStorageService>(
              //   create: (_) => FirebaseStorageService(uid: user.uid),
              // ),
              // Provider<DatabaseService>(
              //   create: (_) => DatabaseService(uid: user.uid),
              // ),
              // Provider<FirestoreService>(
              //   create: (_) => FirestoreService(uid: user.uid),
              // ),
            ], child: builder(context, snapshot));

            // Consumer<DatabaseService>(
            //     builder: (_, databaseService, __) {
            //   print("Text from Database Service" + databaseService.text);
            //   return
            //   FutureBuilder<List<LocationDetailsCopy>>(
            //       future: databaseService.futureLocation(),
            //       builder: (_, streamSnapshot) {
            //         if (streamSnapshot.connectionState ==
            //             ConnectionState.done) {
            //           return MultiProvider(
            //             providers: [
            //               ChangeNotifierProvider<HomePageProvider>(
            //                 create: (_) => HomePageProvider(
            //                     unfilteredLocationDetails:
            //                         streamSnapshot.data,
            //                     databaseService: databaseService),
            //               ),
            //               ChangeNotifierProvider<MyActivitiesProvider>(
            //                 create: (context) => MyActivitiesProvider(
            //                     databaseService: databaseService),
            //               )
            //             ],
            //             child: builder(context, snapshot),
            //           );
            //         }
            //         return Container(
            //           color: Colors.white,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               CircularProgressIndicator(
            //                 strokeWidth: 1,
            //               ),
            //             ],
            //           ),
            //         );
            //       });
            // }));
          }
          return builder(context, snapshot);
        });
  }
}
