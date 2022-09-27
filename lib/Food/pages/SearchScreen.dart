import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/Models/DishesList.dart';
import 'package:mycityapp/Food/Models/TakeAwayModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/Services/popularcuration_list_api_provider.dart';
import 'package:mycityapp/Food/pages/beverages.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'ui_helper.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // final List<DishesList>? dishes = ApiServices.dishesList;
  TextEditingController searchController = TextEditingController();

  // List<DishesList> searchdishes = [];
  List<TakeAwayModel>? searchResDishes = [];

  // List<CategoryList>? popularCurations = [];
  Future? _postData;
  // bool _isSelected1 = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (context.read<PopularCurationAPIProvider>().popularCurationResponse ==
        null) {
      context.read<PopularCurationAPIProvider>().getPopularCuration();
    }

    apiService.popluarcurationlist().then((value) {
      setState(() {
        // popularCurations = ApiServices.popularCurations!.categoryList;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _post(dynamic filter) {
    _postData = apiService
        .searchData(SharedPreference.latitudeValue,
            SharedPreference.longitudeValue, searchController.text, filter)
        .then((value) {
      setState(() {
        searchResDishes = ApiService.searchDatas;
      });
    });
  }

  List<String> names = [
    "All",
    "Delivery",
    "Rating",
    "Low to High",
    "High to Low"
  ];

  String? selectedReportList;

  String selectedChoice = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        _post("1");
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for restaurants and food',
                        hintStyle:
                            Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // UIHelper.horizontalSpaceMedium(),
                  // IconButton(
                  //   icon: Icon(Icons.search),
                  //   onPressed: () {},
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: searchController.value.text.isEmpty
                  ? Beverages()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            child:
                                // ListView.builder(
                                //   shrinkWrap: true,
                                //   physics: ScrollPhysics(),
                                //   scrollDirection: Axis.horizontal,
                                //   itemCount: names.length,
                                //   itemBuilder: (context, index) {
                                //     return

                                ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: names.length,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: ChoiceChip(
                                      elevation: 2,
                                      label: Center(
                                          child: Text(
                                        names[index],
                                        textAlign: TextAlign.center,
                                        style: CommonStyles.black12(),
                                      )),
                                      padding: EdgeInsets.zero,
                                      selected: selectedChoice == names[index],
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedChoice =
                                              names[index].toString();
                                          index = index + 1;
                                          _postData = _post(index);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          _SearchListView(foods: searchResDishes),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchListView extends StatelessWidget {
  final List<TakeAwayModel>? foods;

  const _SearchListView({this.foods});

  @override
  Widget build(BuildContext context) {
    return foods != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: foods!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                          id: foods![index].id!,
                        ),
                      ),
                    );
                  },
                  child: _SearchRestaurants(
                    food: foods![index],
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 45,
                color: Colors.redAccent,
              ),
              UIHelper.verticalSpaceMedium(),
              Text("Service not available in your location"),
            ],
          ));
  }
}

class _SearchRestaurants extends StatelessWidget {
  const _SearchRestaurants({
    Key? key,
    required this.food,
  }) : super(key: key);

  final TakeAwayModel? food;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(
              id: food!.id!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  )
                ],
              ),
              child: food!.image != ""
                  ? Image.network(
                      food!.image!,
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
            ),
            UIHelper.horizontalSpaceSmall(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    food!.restaurantName!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 15.0),
                  ),
                  Text(food!.category!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[600], fontSize: 13.5)),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      Text(food!.rating!)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SearchDishes extends StatelessWidget {
  const _SearchDishes({
    Key? key,
    required this.food,
    required this.index,
  }) : super(key: key);

  final DishesList food;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(
              id: food.id!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  )
                ],
              ),
              child: Image.network(
                food.image == null
                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
                    : "https://foodieworlds.in/foodie/uploads/menu/${food.image}",
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            UIHelper.horizontalSpaceSmall(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    food.dishes_name!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 15.0),
                  ),
                  Text(food.duration_lt!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[600], fontSize: 13.5)),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      Text(food.duration_lt!)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
