import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Food/Services/beverage_list_api.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import '../CommonWidgets/utils.dart';
import 'restaurantDetailsPage/restaurant_detail_screen.dart';
import 'ui_helper.dart';

class Beverages extends StatefulWidget {
  @override
  _BeveragesState createState() => _BeveragesState();
}

class _BeveragesState extends State<Beverages> {
  // List<DishesList>? dishes = ApiServices.beveragesList;

  @override
  void initState() {
    super.initState();

    if (context.read<BeverageListAPIProvider>().beverageResponseModel == null) {
      context.read<BeverageListAPIProvider>().getBeverageList(
          SharedPreference.latitude, SharedPreference.longitude);
    }

    // apiServices
    //     .beverages(
    //         SharedPreference.latitudeValue, SharedPreference.longitudeValue)
    //     .then((value) {
    //   setState(() {
    //     dishes = ApiServices.beveragesList;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final beverageProvider = Provider.of<BeverageListAPIProvider>(context);
    if (beverageProvider.isLoading) {
      return Center(
        child: Utils.showLoading(),
      );
    } else if (beverageProvider.beverageResponseModel != null &&
        beverageProvider.beverageResponseModel!.status == "0") {
      return Utils.showErrorMessage(beverageProvider.errorMessage);
    } else {
      final dishes = beverageProvider.beverageResponseModel!.newArrival;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            UIHelper.verticalSpaceSmall(),
            _buildPopularHeader(context),
            LimitedBox(
              maxHeight: 170.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: dishes!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print(dishes[index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailScreen(
                            id: dishes[index].id!,
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
                                beverageProvider.beverageResponseModel == null
                                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
                                    : beverageProvider.beverageResponseModel!
                                            .menuBaseurl! +
                                        dishes[index].image!,
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            dishes[index].dishesName!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          UIHelper.verticalSpace(2.0),
                          Text(
                            dishes[index].durationLt!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey, fontSize: 13.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Container _buildPopularHeader(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Search your favourite restaturants',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 20.0),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(
              'Secrets of delicious taste',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
}
