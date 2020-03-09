import 'package:get_it/get_it.dart';

import 'bloc/data/position_bloc.dart';
import 'repository/api.dart';
import 'repository/rates_crypto_repository.dart';
import 'repository/rates_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());

  // Bloc
  locator.registerLazySingleton(() => PositionBloc());

  // Repository
  locator.registerLazySingleton(() => RatesRepository());
  locator.registerLazySingleton(() => RatesCryptoRepository());
}
