import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spacex_app/app.dart';
import 'package:spacex_app/core/network/network.dart';
import 'package:spacex_app/utils/locator.dart';

void main() async {
  runZonedGuarded(() async {
    final network = createNetworkClient();
    setupLocator(network: network);

    runApp(const RootApp());
  }, (error, stack) {
    debugPrint('zoned guard $error $stack');
  });
}

AppNetwork createNetworkClient() {
  final dio = Dio()..options.baseUrl = "https://api.spacexdata.com";
  return AppNetwork(dio);
}
