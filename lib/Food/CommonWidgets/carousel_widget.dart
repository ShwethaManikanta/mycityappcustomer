import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int realIndex, int itemIndex) {
          return Container();
        },
        options: CarouselOptions());
  }
}
