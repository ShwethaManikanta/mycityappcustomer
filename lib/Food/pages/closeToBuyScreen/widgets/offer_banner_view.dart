import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/cached_network_image.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/Services/banner_api_provider.dart';
import 'package:mycityapp/Food/pages/closeToBuyScreen/widgets/offers_based_list.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:provider/provider.dart';

import '../../../CommonWidgets/utils.dart';

class OfferBannerView extends StatefulWidget {
  @override
  State<OfferBannerView> createState() => _OfferBannerViewState();
}

class _OfferBannerViewState extends State<OfferBannerView> {
  // final List<String?>? images = ApiServices.banners;

  @override
  void initState() {
    if (context.read<BannerListAPIProvider>().bannerListResponseModel == null) {
      context.read<BannerListAPIProvider>().getBannerList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bannerListAPIProvider = Provider.of<BannerListAPIProvider>(context);
    if (bannerListAPIProvider.ifLoading) {
      return Center(child: Utils.showLoading());
    }
    if (bannerListAPIProvider.error) {
      return Utils.showErrorMessage(bannerListAPIProvider.errorMessage);
    } else if (bannerListAPIProvider.bannerListResponseModel!.status == "0") {
      return Utils.showErrorMessage(
          bannerListAPIProvider.bannerListResponseModel!.message!);
    } else {
      final images = bannerListAPIProvider.bannerListResponseModel!.topBanner;
      return InkWell(
        child: SizedBox(
          // aspectRatio: 4 / 3,
          height: 180,
          child: Swiper(
            itemHeight: 100,
            duration: 500,
            itemWidth: double.infinity,
            // pagination: SwiperPagination(),
            itemCount: images!.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: cachedNetworkImage(
                    100,
                    double.infinity,
                    bannerListAPIProvider
                            .bannerListResponseModel!.imageBaseurl! +
                        images[index].bannerImage!),
              ),
            ),
            autoplay: true,
            viewportFraction: 1.0,
            scale: 0.9,
          ),
        ),
        onTap: () {},
      );
    }
  }
}

class TopOfferBannerView extends StatefulWidget {
  @override
  State<TopOfferBannerView> createState() => _TopOfferBannerViewState();
}

class _TopOfferBannerViewState extends State<TopOfferBannerView> {
  @override
  void initState() {
    if (context
            .read<RestaurantOfferBannerAPIProvider>()
            .offerBannerResponseModel ==
        null) {
      context.read<RestaurantOfferBannerAPIProvider>().getOfferBannerList();
    }
    super.initState();
  }

  final List<Color> colors = [
    Colors.green.withOpacity(0.6),
    Colors.deepOrange.withOpacity(0.6),
    Colors.pink.withOpacity(0.6),
    Colors.teal.withOpacity(0.6),
  ];

  final List<String> imagess = [
    "assets/pizza-2487090_1920.jpg",
    "assets/salmon-518032_1920.jpg",
    "assets/beef-5466246_1920.jpg",
    "assets/images/food1.jpg",
    "assets/images/food2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final offerBannerAPIProvider =
        Provider.of<RestaurantOfferBannerAPIProvider>(context);
    if (offerBannerAPIProvider.ifLoading) {
      return Center(child: Utils.showLoading());
    }
    if (offerBannerAPIProvider.error) {
      return Utils.showErrorMessage(offerBannerAPIProvider.errorMessage);
    } else if (offerBannerAPIProvider.offerBannerResponseModel!.status == "0") {
      return Utils.showErrorMessage(
          offerBannerAPIProvider.offerBannerResponseModel!.message!);
    } else {
      final images =
          offerBannerAPIProvider.offerBannerResponseModel!.offerBanner!;
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        height: MediaQuery.of(context).size.height * 0.235,
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final hexColor =
                  images[index].color!.toUpperCase().replaceAll("#", "0xFF");

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfferBasedList(
                        code: images[index].promocode,
                        color: Color(int.parse(hexColor)),
                        offerPercent: images[index].offer!,
                        title: images[index].title!,
                        offerLimit: images[index].offerInt!,
                        id: images[index].id!,
                        image: images[index].bannerImage!,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Color(int.parse(hexColor)).withOpacity(0.5),
                      // color: colors[index],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cachedNetworkImage(
                                  80,
                                  200,
                                  offerBannerAPIProvider
                                          .offerBannerResponseModel!
                                          .imageBaseurl! +
                                      images[index].bannerImage!),
                              // Image.network(
                              //   offerBannerAPIProvider.offerBannerResponseModel!
                              //           .imageBaseurl! +
                              //       images[index].bannerImage!,
                              //   fit: BoxFit.fill,
                              //   width: 200,
                              //   height: 80,
                              // ),
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                images[index].title!.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15),
                              ),
                              UIHelper.verticalSpace(3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    images[index].offer!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Color(int.parse(hexColor)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Row(
                                children: [
                                  Text(
                                    "COUPON: ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8.0),
                                  ),
                                  Text(
                                    images[index].promocode!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 9.8),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // UIHelper.verticalSpace(2),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.only(
                        //         bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                        //     color: Color(int.parse(hexColor)).withOpacity(0.7),
                        //     // color: Color(int.tryParse(images[index].color))
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           "COUPON: ",
                        //           style: TextStyle(color: Colors.white, fontSize: 8.0),
                        //         ),
                        //         Text(
                        //           images[index].promocode,
                        //           style:
                        //               TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 9.8),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )
                        // Image.network(
                        //   "https://foodieworlds.in/foodie/" + images[index].banner_image,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }
}

class MeatBannerView extends StatefulWidget {
  @override
  State<MeatBannerView> createState() => _MeatBannerViewState();
}

class _MeatBannerViewState extends State<MeatBannerView> {
  @override
  void initState() {
    if (context.read<MeatBannerListAPIProvider>().meatBannerResponseModel ==
        null) {
      context.read<MeatBannerListAPIProvider>().getMeatBannerList();
    }
    super.initState();
  }

  // final List<OnboardingBannerModel>? images = ApiServices.meatbanners;

  @override
  Widget build(BuildContext context) {
    final meatBannerListAPIProvider =
        Provider.of<MeatBannerListAPIProvider>(context);

    if (meatBannerListAPIProvider.ifLoading) {
      return Center(child: Utils.showLoading());
    }
    if (meatBannerListAPIProvider.error) {
      return Utils.showErrorMessage(meatBannerListAPIProvider.errorMessage);
    } else if (meatBannerListAPIProvider.meatBannerResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(
          meatBannerListAPIProvider.meatBannerResponseModel!.message!);
    } else {
      final images =
          meatBannerListAPIProvider.meatBannerResponseModel!.meatBanner!;

      return AspectRatio(
        aspectRatio: 16 / 10,
        child: Swiper(
          itemHeight: 250,
          duration: 500,
          itemWidth: double.infinity,
          pagination: SwiperPagination(),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) => cachedNetworkImage(
              250,
              double.infinity,
              meatBannerListAPIProvider.meatBannerResponseModel!.imageBaseurl! +
                  images[index].bannerImage!),
          // Image.network(
          //   "https://foodieworlds.in/foodie/" + images![index].banner_image!,
          //   fit: BoxFit.fill,
          // ),
          autoplay: true,
          viewportFraction: 1.0,
          scale: 0.9,
        ),
      );
    }
    //   return CarouselSlider(
    //   options: CarouselOptions(
    //     height: 200.0,
    //     initialPage: 0,
    //     aspectRatio: 2.0,
    //   ),
    //   items: images!.map((i) {
    //     return Builder(
    //       builder: (BuildContext context) {
    //         return Padding(
    //           padding: const EdgeInsets.all(5.0),
    //           child: Container(
    //               width: MediaQuery.of(context).size.width * 0.8,
    //               // margin: EdgeInsets.symmetric(horizontal: 5.0),
    //               // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.amber),
    //               child: Stack(
    //                 children: [
    //                   Image.network(
    //                       "https://foodieworlds.in/foodie/" + i.banner_image!),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           i.title!,
    //                           style: TextStyle(
    //                               fontSize: 16.0,
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         Text(
    //                           i.description!,
    //                           style: TextStyle(
    //                               fontSize: 16.0,
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               )),
    //         );
    //       },
    //     );
    //   }).toList(),
    // );
  }
}

class BottomBannerView extends StatefulWidget {
  @override
  State<BottomBannerView> createState() => _BottomBannerViewState();
}

class _BottomBannerViewState extends State<BottomBannerView> {
  @override
  void initState() {
    if (context.read<BottomBannerAPIProvider>().bottomBannerResponseModel ==
        null) {
      context.read<BottomBannerAPIProvider>().getBottomBannerApiProvider();
    }
    super.initState();
  }

  // final List<String?>? images = ApiServices.bottombanners;
  @override
  Widget build(BuildContext context) {
    final bottomBannerResponseModel =
        Provider.of<BottomBannerAPIProvider>(context);
    if (bottomBannerResponseModel.ifLoading) {
      return Center(child: Utils.showLoading());
    }
    if (bottomBannerResponseModel.error) {
      return Utils.showErrorMessage(bottomBannerResponseModel.errorMessage);
    } else if (bottomBannerResponseModel.bottomBannerResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(
          bottomBannerResponseModel.bottomBannerResponseModel!.message!);
    } else {
      final images =
          bottomBannerResponseModel.bottomBannerResponseModel!.bottomBanner!;
      return SizedBox(
        height: 150,
        width: deviceWidth(context),

        //  AspectRatio(
        //   aspectRatio: 16 / 9,
        //   child:

        child: Swiper(
          itemHeight: 150,
          duration: 500,
          itemWidth: deviceWidth(context),

          // pagination: SwiperPagination(),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: cachedNetworkImage(
                150,
                deviceWidth(context) * 0.8,
                bottomBannerResponseModel
                        .bottomBannerResponseModel!.imageBaseurl! +
                    images[index].bannerImage!),
          ),
          autoplay: true,
          viewportFraction: 1.0,
          scale: 0.9,
        ),
        // )
      );
    }
  }
}
