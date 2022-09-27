import 'package:flutter/material.dart';
import 'package:mycityapp/Food/Models/RestaurantViewModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:mycityapp/Food/pages/veg_badge_view.dart';


class SearchRestaurantDetail extends StatefulWidget {
  final String? id;
  final List<ProductList>? productMenu;
  const SearchRestaurantDetail({Key? key, this.id, this.productMenu})
      : super(key: key);

  @override
  _SearchRestaurantDetailState createState() => _SearchRestaurantDetailState();
}

class _SearchRestaurantDetailState extends State<SearchRestaurantDetail> {
  TextEditingController searchController = TextEditingController();
  List<ProductList>? searchResDishes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.black,
                    ))
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            TextField(
              controller: searchController,
              onChanged: (value) {
                apiService
                    .searchRestaurantData(
                        SharedPreference.latitudeValue,
                        SharedPreference.longitudeValue,
                        searchController.text,
                        widget.id)
                    .then((value) {
                  setState(() {
                    searchResDishes = ApiService.searchRestaurantDatas;
                  });
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: swiggyOrange,
                  size: 22,
                ),
                hintText: 'Start typing to search...',
                hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
            ),
            searchController.text.isNotEmpty
                ? searchRestaurantList(searchResDishes!)
                : Container()
          ],
        ),
      ),
    );
  }

  Widget searchRestaurantList(List<ProductList> searchmenu) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: searchmenu.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              searchmenu[index].foodType == "1"
                  ? VegBadgeView()
                  : NonVegBadgeView(),
              UIHelper.horizontalSpaceMedium(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      searchmenu[index].menuName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Row(
                      children: [
                        Text("Rs." + searchmenu[index].mrp.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.lineThrough)),
                        UIHelper.horizontalSpaceMedium(),
                        Text(
                          "Rs ." + searchmenu[index].salePrice!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),

                    // if (foods[index].desc != null)
                    //   Text(
                    //     foods[index].desc,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: Theme.of(context).textTheme.bodyText1.copyWith(
                    //           fontSize: 12.0,
                    //           color: Colors.grey[500],
                    //         ),
                    //   ),
                  ],
                ),
              ),
              Stack(
                children: [
                  searchmenu[index].menuImage != null ||
                          searchmenu[index].menuImage!.first != ""
                      ? Image.network(
                          "https://foodieworlds.in/foodie//uploads/menu/${searchmenu[index].menuImage!}",
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
                  Positioned(
                    bottom: 0,
                    child: searchmenu[index].status != 0
                        ? searchmenu[index].status != 1
                            ? AddBtnView(
                                isLoading: () {},
                                id: searchmenu[index].id,
                                index: index,
                                salesprice: searchmenu[index].salePrice,
                                menuname: '',
                                post: () {},
                              )
                            : InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'CartScreen');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 30.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.0),
                                      color: swiggyOrange),
                                  child: Text(
                                    'Cart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.grey),
                            child: Text(
                              'ADD',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                  )
                ],
              )
            ],
          );
        });
  }
}
