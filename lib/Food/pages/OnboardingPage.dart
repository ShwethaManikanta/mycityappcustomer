import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Services/banner_api_provider.dart';


class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  String? getTitle() {
    return title;
  }

  String? getDesc() {
    return desc;
  }
}

// List<SliderModel> getSlides() {
//   List<SliderModel> slides = [];
//   for (var item in ApiServices.onboardingBanners) {
//     SliderModel sliderModel = new SliderModel();
//     sliderModel.setDesc("${item.description}".toUpperCase());
//     sliderModel.setTitle("${item.title}".toUpperCase());
//     sliderModel.setImageAssetPath("${item.image}");
//     slides.add(sliderModel);
//   }
//   return slides;
// }

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<SliderModel> mySLides = [];
  int slideIndex = 0;
  PageController? controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // mySLides = getSlides();
    if (context
            .read<FrontPageBannerAPIProvider>()
            .frontBannerListResponseModel ==
        null) {
      context.read<FrontPageBannerAPIProvider>().getFrontBanners();
    }
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    final frontPageBannerAPIProvider =
        Provider.of<FrontPageBannerAPIProvider>(context);

    if (frontPageBannerAPIProvider.ifLoading) {
      return SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Center(child: Utils.showLoading()));
    }
    if (frontPageBannerAPIProvider.error) {
      return Utils.showErrorMessage(frontPageBannerAPIProvider.errorMessage);
    } else if (frontPageBannerAPIProvider
            .frontBannerListResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(
          frontPageBannerAPIProvider.frontBannerListResponseModel!.message!);
    } else {
      final images =
          frontPageBannerAPIProvider.frontBannerListResponseModel!.topBanner;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: List.generate(3, (index) {
                return SliderTile(
                  title: mySLides[index].getTitle(),
                  imagePath: mySLides[index].getImageAssetPath(),
                  desc: mySLides[index].getDesc(),
                );
              }),
            ),
          ),
          bottomSheet: slideIndex != 2
              ? Container(
                  height: 60,
                  color: Colors.orange[700],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          controller!.jumpToPage(2);
                        },
                        child: Text(
                          "SKIP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              i == slideIndex
                                  ? _buildPageIndicator(true)
                                  : _buildPageIndicator(false),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller!.animateToPage(slideIndex + 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'Login');
                  },
                  child: Container(
                    height: 60,
                    color: Colors.orange[900],
                    alignment: Alignment.center,
                    child: Text(
                      "GET STARTED NOW",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
        ),
      );
    }
  }
}

// ignore: must_be_immutable
class SliderTile extends StatelessWidget {
  String? imagePath, title, desc;

  SliderTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      "https://foodieworlds.in/foodie/uploads/banner_customer/$imagePath",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Colors.black,
                letterSpacing: .1,
                wordSpacing: .1,
              ),
            ),
          ),
          Divider(
            color: Colors.orange,
          ),
          Text(
            desc!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
              letterSpacing: 0.1,
              wordSpacing: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
