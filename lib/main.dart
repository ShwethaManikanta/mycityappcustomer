import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Food/Services/banner_api_provider.dart';
import 'package:mycityapp/Food/Services/beverage_list_api.dart';
import 'package:mycityapp/Food/Services/cart_api_provider.dart';
import 'package:mycityapp/Food/Services/ongoing_order_api.dart';
import 'package:mycityapp/Food/Services/order_history_api_provider.dart';
import 'package:mycityapp/Food/Services/popular_restaurant_api_provider.dart';
import 'package:mycityapp/Food/Services/popularcuration_list_api_provider.dart';
import 'package:mycityapp/Food/Services/profile_update_api_provider.dart';
import 'package:mycityapp/Food/Services/profile_view_api_provider.dart';
import 'package:mycityapp/Food/Services/restaurant_details_api_provider.dart';
import 'package:mycityapp/Food/Services/shared_preferences_provider.dart';
import 'package:mycityapp/Food/Services/takeaway_api_service.dart';
import 'package:mycityapp/backend/auth/auth_widget.dart';
import 'package:mycityapp/backend/auth/auth_widget_builder.dart';
import 'package:mycityapp/common/loading_widget.dart';
import 'Cab/Services/apiProvider/book_vehicle_api_provider.dart';
import 'Cab/Services/apiProvider/cab_booking_api_provider.dart';
import 'Cab/Services/apiProvider/goods_types_api_provider.dart';
import 'Cab/Services/apiProvider/helper_list_api_provider.dart';
import 'Cab/Services/apiProvider/login_api_provider.dart';
import 'Cab/Services/apiProvider/order_history_api_provider.dart';
import 'Cab/Services/apiProvider/registration_api_provider.dart';
import 'Cab/Services/apiProvider/unit_list_api_provider.dart';
import 'Cab/Services/apiProvider/vehicle_categories_api_provider.dart';
import 'Cab/Services/api_services.dart';
import 'Cab/Services/location_services.dart/loaction_shared_preference.dart';
import 'Cab/Services/nearby_driver_api_provider.dart';
import 'Cab/Services/order_specific_api_provider.dart';
import 'Cab/Services/track_driver_api_provider.dart';
import 'Cab/pages/common_provider.dart';
import 'Cab/pages/confirm_location.dart';
import 'Cab/pages/fetchLocation/fetch_location.dart';
import 'Cab/pages/home/home.dart';
import 'Cab/pages/home/homepage.dart';
import 'Cab/pages/my_wallet.dart';
import 'Cab/pages/orderDetails/order_detiles.dart';
import 'Cab/pages/orderPage/maps_provider.dart';
import 'Cab/pages/orderPage/order_page.dart';
import 'Cab/pages/packers_and_movers.dart';
import 'Cab/pages/payment_page.dart';
import 'Cab/pages/profile_page.dart';
import 'Cab/pages/profile_setting.dart';
import 'Cab/pages/review_add_stops.dart';
import 'Cab/pages/search_page.dart';
import 'Cab/pages/select_vehical.dart';
import 'Cab/pages/signIn/sign_in_page.dart';
import 'Cab/pages/splash_screen.dart';
import 'backend/service/firebase_auth_service.dart';
import 'common/common_styles.dart';
import 'common/image_picker_service.dart';
import 'common/utils.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (BuildContext context) => FirebaseAuthService(),
        ),
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        ChangeNotifierProvider<VehicleCategoriesAPIProvider>(
          create: (_) => VehicleCategoriesAPIProvider(),
        ),
        ChangeNotifierProvider<BookVehicleAPIProvider>(
            create: (_) => BookVehicleAPIProvider()),
        ChangeNotifierProvider<VerifyUserLoginAPIProvider>(
            create: (_) => VerifyUserLoginAPIProvider()),
        ChangeNotifierProvider<HelperListAPIProvider>(
            create: (_) => HelperListAPIProvider()),
        ChangeNotifierProvider<ListGoodTypeAPIProvider>(
            create: (_) => ListGoodTypeAPIProvider()),
        ChangeNotifierProvider<ProfileViewAPIProvider>(
            create: (_) => ProfileViewAPIProvider()),
        ChangeNotifierProvider<UnitListAPIProvider>(
            create: (_) => UnitListAPIProvider()),
        ChangeNotifierProvider<OrderHistoryAPIProviderCab>(
            create: (_) => OrderHistoryAPIProviderCab()),
        ChangeNotifierProvider<CabBookingAPIProvider>(
            create: (_) => CabBookingAPIProvider()),
        ChangeNotifierProvider<NearbyDriverListAPIProvider>(
            create: (_) => NearbyDriverListAPIProvider()),
        ChangeNotifierProvider<OrderSpecificAPIProvider>(
            create: (_) => OrderSpecificAPIProvider()),
        ChangeNotifierProvider<TrackDriverAPIProvider>(
            create: (_) => TrackDriverAPIProvider()),
        ChangeNotifierProvider<ViewDetailsMapProvider>(
            create: (_) => ViewDetailsMapProvider()),

        // Food

        ChangeNotifierProvider<SharedPreferencesProvider>(
            create: (_) => SharedPreferencesProvider()),
        ChangeNotifierProvider<MeatBannerListAPIProvider>(
            create: (_) => MeatBannerListAPIProvider()),

        ChangeNotifierProvider<CartListAPIProvider>(
            create: (_) => CartListAPIProvider()),
        ChangeNotifierProvider<PopularCurationAPIProvider>(
            create: (_) => PopularCurationAPIProvider()),
        // ChangeNotifierProvider<OngoingOrderAPIProvider>(
        //     create: (_) => OngoingOrderAPIProvider()),
        ChangeNotifierProvider<TakeAwayAPIProvider>(
            create: (_) => TakeAwayAPIProvider()),
        ChangeNotifierProvider<BannerListAPIProvider>(
            create: (_) => BannerListAPIProvider()),
        ChangeNotifierProvider<BottomBannerAPIProvider>(
            create: (_) => BottomBannerAPIProvider()),
        ChangeNotifierProvider<RestaurantOfferBannerAPIProvider>(
            create: (_) => RestaurantOfferBannerAPIProvider()),
        ChangeNotifierProvider<FrontPageBannerAPIProvider>(
            create: (_) => FrontPageBannerAPIProvider()),
        ChangeNotifierProvider<RestaurantDetailsAPIProvider>(
            create: (_) => RestaurantDetailsAPIProvider()),
        ChangeNotifierProvider<PopularRestaurantAPIProvider>(
            create: (_) => PopularRestaurantAPIProvider()),
        ChangeNotifierProvider<PopularMeatAPIProvider>(
            create: (_) => PopularMeatAPIProvider()),
        ChangeNotifierProvider<PopularBakeryAPIProvider>(
            create: (_) => PopularBakeryAPIProvider()),

        ChangeNotifierProvider<BeverageListAPIProvider>(
            create: (_) => BeverageListAPIProvider()),
        ChangeNotifierProvider<OrderHistoryAPIProvider>(
            create: (_) => OrderHistoryAPIProvider()),
        ChangeNotifierProvider<ProfileViewApiProvider>(
            create: (_) => ProfileViewApiProvider()),
        ChangeNotifierProvider<SharedPreference>(
            create: (_) => SharedPreference()),
        ChangeNotifierProvider<BakeryBannerListAPIProvider>(
            create: (_) => BakeryBannerListAPIProvider()),
        ChangeNotifierProvider<EditUserProfileAPIProvider>(
          create: (_) => EditUserProfileAPIProvider(),
        ),
        ChangeNotifierProvider<OngoingOrderAPIProvider>(
          create: (_) => OngoingOrderAPIProvider(),
        ),
        ChangeNotifierProvider<FoodCourtAPIProvider>(
          create: (_) => FoodCourtAPIProvider(),
        )
      ],
      child: AuthWidgetBuilder(
        builder:
            (BuildContext context, AsyncSnapshot<LoggedInUser?> userSnapshot) {
          return MaterialApp(
            title: "True Driver",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            routes: {
              'SplashScreen': (context) => const SplashScreen(),
              'SignInPage': (context) => const SignInPage(),
              'MainHomePage': (context) => const MainHomePage(),
              'OrderPage': (context) => const OrderPage(),
              'PaymentPage': (context) => const PaymentPage(),
              'ProfileSetting': (context) => const ProfileSetting(),
              'HomePage': (context) => const HomePage(),
              'PackersAndMovers': (context) => const PackersAndMovers(),
              // 'RentelPackages': (context) => const RentelPackages(),
              'OrderDetiles': (context) => const OrderDetiles(),
              'MyWallet': (context) => const MyWallet(),
              'SearchPage': (context) => const SearchPage(type: ""),
              'ConfirmLocation': (context) => ConfirmLocation(),
              'ReviewAddStops': (context) => const ReviewAddStops(),
              'SelectVehical': (context) => const SelectVehical(),
              'ProfilePage': (context) => const ProfilePage(),
            },
            // initialRoute: 'SplashScreen',
            debugShowCheckedModeBanner: false,
            home: AuthWidget(userSnapshot: userSnapshot),
          );
        },
      ),
    );
  }
}

class GetLoginUser extends StatefulWidget {
  const GetLoginUser({Key? key}) : super(key: key);

  @override
  _GetLoginUserState createState() => _GetLoginUserState();
}

class _GetLoginUserState extends State<GetLoginUser> {
  @override
  void initState() {
    if (mounted) {
      getVerifiedUser();
    }

    super.initState();
  }

  getVerifiedUser() async {
    final loggedInUserProvider =
    Provider.of<LoggedInUser>(context, listen: false);
    if (context.read<VerifyUserLoginAPIProvider>().loginResponse == null) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("Firebase Messaging Token -----------  " + token.toString());
      await context
          .read<VerifyUserLoginAPIProvider>()
          .getUser(
          deviceToken: token ?? "NA",
          userFirebaseID: loggedInUserProvider.uid,
          phoneNumber: loggedInUserProvider.phoneNo.substring(
              loggedInUserProvider.phoneNo.length - 10,
              loggedInUserProvider.phoneNo.length))
          .then((value) {
        setUserID();
        print("User id assigned for user  - - -- - - " +
            context
                .read<VerifyUserLoginAPIProvider>()
                .loginResponse!
                .userDetails!
                .id!);
      });
    }
  }

  setUserID() {
    ApiServices.userId = context
        .read<VerifyUserLoginAPIProvider>()
        .loginResponse!
        .userDetails!
        .id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: checkForUserNameAndEmail()
        // HomeBottomNavigationScreen()

      ),
    );
  }

  checkForUserNameAndEmail() {
    final verifyUserLoginAPIProvider =
    Provider.of<VerifyUserLoginAPIProvider>(context);

    if (verifyUserLoginAPIProvider.isLoading) {
      return ifLoading();
    } else if (verifyUserLoginAPIProvider.error) {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.errorMessage);
    } else if (verifyUserLoginAPIProvider.loginResponse!.status == "0") {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.loginResponse!.message!);
    }
    if (verifyUserLoginAPIProvider.loginResponse!.userDetails!.email == null ||
        verifyUserLoginAPIProvider.loginResponse!.userDetails!.email == "" ||
        verifyUserLoginAPIProvider.loginResponse!.userDetails!.userName ==
            null ||
        verifyUserLoginAPIProvider.loginResponse!.userDetails!.userName == "") {
      return const GetUserNameAndEmail();
    } else {
      return GetLocation();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}

class LocationInitialize extends StatefulWidget {
  const LocationInitialize({Key? key}) : super(key: key);

  @override
  _LocationInitializeState createState() => _LocationInitializeState();
}

class _LocationInitializeState extends State<LocationInitialize> {
  @override
  void initState() {
    super.initState();
    SharedPreference.setValues().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPreference.initializeSharedPreference ==
        InitializeSharedPreference.uninitialize) {
      return ifLoading();
    } else {
      return HomePage();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}

class GetUserNameAndEmail extends StatefulWidget {
  const GetUserNameAndEmail({Key? key}) : super(key: key);

  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserNameAndEmail> {
  bool showNextScreen = false;
  String? deviceToken;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  bool isLocationInitialized = false;

  bool nameVerified = false, emailVerified = false, phoneNumberVerified = false;

  @override
  void initState() {
    initialize();
    initializeNameNumber();
    super.initState();
  }

  initializeNameNumber() {
    final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
    phoneNumberController.text = loggedInUser.phoneNo.length > 9
        ? loggedInUser.phoneNo.substring(3, loggedInUser.phoneNo.length)
        : loggedInUser.phoneNo;
    if (loggedInUser.phoneNo.length > 10) {
      if (loggedInUser.phoneNo
          .substring(3, loggedInUser.phoneNo.length)
          .length ==
          10) {
        setState(() {
          phoneNumberVerified = true;
        });
      }
    }
    emailController.text = loggedInUser.email ?? "";
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (loggedInUser.email != null && loggedInUser.name != null) {
      if (regex.hasMatch(loggedInUser.email ?? "")) {
        setState(() {
          emailVerified = true;
        });
      }
      name.text = loggedInUser.name;
      if (loggedInUser.name != "" && loggedInUser.name.length > 3) {
        setState(() {
          nameVerified = true;
        });
      }
    }

    print(nameVerified.toString() +
        "-------" +
        emailVerified.toString() +
        "-------" +
        phoneNumberVerified.toString());
  }

  initialize() async {
    await SharedPreference.setValues().whenComplete(() {
      setState(() {
        isLocationInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customerName(),
    );
    // return PageView(
    //   physics: NeverScrollableScrollPhysics(),
    //   controller: pageController,
    //   children: [customerName(), selectLocationPage()],
    // );
  }

  customerName() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Utils.getSizedBox(height: 15),
            // Row(
            //   children: [
            //     InkWell(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: const Icon(FontAwesomeIcons.arrowLeft))
            //   ],
            // ),
            Utils.getSizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Step 1 of 1: Add Personal Details",
                style: CommonStyles.black12(),
              ),
            ),
            Utils.getSizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Adding these details is a one time process. Next time, you will be directly presented with home screen",
                maxLines: 2,
                style: CommonStyles.blackw54s9Thin(),
              ),
            ),
            Utils.getSizedBox(height: 15),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  readOnly: true,
                  onChanged: (value) {
                    if (value.length == 10) {
                      setState(() {
                        phoneNumberVerified = true;
                      });
                    } else {
                      setState(() {
                        phoneNumberVerified = false;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  decoration: InputDecoration(
                      prefix: Text(
                        "+91  ",
                        style: CommonStyles.black15(),
                      ),
                      counterText: "",
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Phone Number",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                ),
              ),
              key: phoneNumberKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: name,
                  // autovalidateMode: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  onChanged: (value) {
                    if (value.length >= 3) {
                      setState(() {
                        nameVerified = true;
                      });
                      print("Is name verified" + nameVerified.toString());
                    } else {
                      setState(() {
                        nameVerified = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Name",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Minimum Length is 3";
                    }
                    return null;
                  },
                ),
              ),
              key: nameKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    RegExp regex = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    //   String pattern =
                    //       r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
                    // = RegExp(pattern);
                    if (regex.hasMatch(value)) {
                      setState(() {
                        emailVerified = true;
                      });
                    } else {
                      setState(() {
                        emailVerified = false;
                      });
                    }
                    print("email virified" + emailVerified.toString());
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Email",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value!)) {
                      return "Enter Valid email";
                    }
                    return null;
                  },
                ),
              ),
              key: emailKey,
            ),
            Utils.getSizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: MaterialButton(
                  elevation: 18.0,
                  //Wrap with Material
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  minWidth: 100.0,
                  height: 45,
                  color: nameVerified && emailVerified && phoneNumberVerified
                      ? const Color(0xFF801E48)
                      : Colors.grey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Update', style: CommonStyles.whiteText12BoldW500()),
                      Utils.getSizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed: nameVerified &&
                      emailVerified &&
                      phoneNumberVerified
                      ? () async {
                    if (nameKey.currentState!.validate() &&
                        emailKey.currentState!.validate() &&
                        phoneNumberKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      //call update api here
                      showLoadingWithCustomText(
                          context, "Creating Profile");
                      await apiServices
                          .updateProfile(
                          userName: name.text,
                          userEmail: emailController.text,
                          userPhoneNumber: phoneNumberController.text)
                          .then((value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GetLocation()));
                      });
                    }
                  }
                      : () {
                    // pageController.nextPage(
                    //     duration: Duration(milliseconds: 150),
                    //     curve: Curves.ease);
                    print(nameVerified.toString() +
                        "-------" +
                        emailVerified.toString() +
                        "-------" +
                        phoneNumberVerified.toString());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
