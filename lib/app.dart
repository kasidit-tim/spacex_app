import 'package:flutter/material.dart';
import 'package:spacex_app/constants/router.dart';
import 'package:spacex_app/core/theme/theme.dart';
import 'package:spacex_app/modules/home/bloc/home_bloc.dart';
import 'package:spacex_app/utils/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<HomeBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  final builder = Routes.routes[settings.name];
  if (builder == null) throw Exception('unknown route is called');

  return MaterialPageRoute(builder: builder, settings: settings);
}
