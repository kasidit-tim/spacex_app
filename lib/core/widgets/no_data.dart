import 'package:flutter/material.dart';
import 'package:spacex_app/constants/images.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      MainImage.noData,
      width: 250,
      height: 250,
    ));
  }
}
