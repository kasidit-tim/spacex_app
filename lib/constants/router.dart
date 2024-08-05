import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/modules/launches_detail/bloc/launches_detail_bloc.dart';
import 'package:spacex_app/modules/launches_detail/views/launches_detail.dart';
import 'package:spacex_app/modules/home/views/home_screen.dart';
import 'package:spacex_app/repository/spacex_repository.dart';
import 'package:spacex_app/utils/locator.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.mainScreen: (context) => const HomeScreen(),
    RouteNames.launchesDetail: (context) {
      final launchesId = ModalRoute.of(context)!.settings.arguments as String;
      return BlocProvider(
        create: (context) => LaunchesDetailBloc(
          locator.get<SpacexRepository>(),
          launchesId,
        ),
        child: const LaunchesDetail(),
      );
    }
  };
}

class RouteNames {
  static const mainScreen = '/';
  static const launchesDetail = '/launchesDetail';
}
