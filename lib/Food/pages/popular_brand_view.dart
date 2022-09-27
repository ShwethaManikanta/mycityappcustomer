import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Models/DishesList.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'restaurantDetailsPage/restaurant_detail_screen.dart';
import 'ui_helper.dart';

class PopularBrandsView extends StatefulWidget {
  @override
  _PopularBrandsViewState createState() => _PopularBrandsViewState();
}

class _PopularBrandsViewState extends State<PopularBrandsView> {
  List<DishesList>? dishes = ApiService.dishesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          UIHelper.verticalSpaceSmall(),
          _buildPopularHeader(context),
          dishes != null
              ? LimitedBox(
                  maxHeight: 170.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: dishes!.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          print(ApiServices.userId);
                          print(dishes![index].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailScreen(
                                id: dishes![index].id!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    dishes![index].image == null
                                        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
                                        : "https://foodieworlds.in/foodie/uploads/menu/${dishes![index].image}",
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                dishes![index].dishes_name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              UIHelper.verticalSpace(2.0),
                              Text(
                                dishes![index].duration_lt!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.grey, fontSize: 13.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Container _buildPopularHeader(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Popular Dishes',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 20.0),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(
              'Most ordered from around your locality',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
}
