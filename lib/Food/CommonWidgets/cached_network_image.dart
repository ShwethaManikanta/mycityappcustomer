import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(double height, double width, String imageUrl,
    {double opacity = 0}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    fit: BoxFit.fill,
    imageUrl: (imageUrl),
    placeholder: (context, string) {
      return SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.white),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(opacity), BlendMode.srcOver),
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
