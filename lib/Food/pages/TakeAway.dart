import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/TakeAwayModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';


class TakeAwayScreen extends StatefulWidget {
  @override
  _TakeAwayScreenState createState() => _TakeAwayScreenState();
}

class _TakeAwayScreenState extends State<TakeAwayScreen> {
  final List<TakeAwayModel>? foods = ApiService.takeAways;
  TextEditingController searchController = TextEditingController();
  List<TakeAwayModel> searchfoods = [];

  @override
  void initState() {
    super.initState();
    // apiServices.getTakeAway(
    //     SharedPreference.latitudeValue, SharedPreference.longitudeValue, "1");
  }

  void search(String searchKey) {
    searchfoods = [];
    for (var item in foods!) {
      if (item.restaurantName!
          .toLowerCase()
          .contains(searchKey.toLowerCase())) {
        searchfoods.add(item);
      }
    }
    setState(() {});
  }

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
                        search(value);
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
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: searchController.value.text.isEmpty
                  ? _SearchListView(foods)
                  : _SearchListView(searchfoods),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchListView extends StatelessWidget {
  final List<TakeAwayModel>? foods;

  const _SearchListView(this.foods);

  @override
  Widget build(BuildContext context) {
    return foods != null
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12),
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
              child: SearchFoodListItemView(
                food: foods![index],
              ),
            ),
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

class SearchFoodListItemView extends StatelessWidget {
  const SearchFoodListItemView({
    Key? key,
    required this.food,
  }) : super(key: key);

  final TakeAwayModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: food.image != ""
                ? Image.network(
                    "https://foodieworlds.in/foodie/uploads/restaurant/${food.image}",
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
                Row(
                  children: [
                    Text(
                      food.restaurantName!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 15.0),
                    ),
                  ],
                ),
                Text(food.category!,
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
                    Text(food.rating!)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
