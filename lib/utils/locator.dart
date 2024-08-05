import 'package:spacex_app/core/network/network.dart';
import 'package:spacex_app/modules/home/bloc/home_bloc.dart';
import 'package:spacex_app/repository/spacex_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator({
  required AppNetwork network,
}) {
  final spacexRepository = SpacexRepository(network);

  //repository
  locator.registerLazySingleton(() => spacexRepository);

  //bloc
  locator.registerLazySingleton(() => HomeBloc(spacexRepository));
}
