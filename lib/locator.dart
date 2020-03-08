import 'package:currency_converter/bloc/data/dial_number_bloc.dart';
import 'package:currency_converter/bloc/data/position_bloc.dart';
import 'package:currency_converter/repository/rates_crypto_repository.dart';
import 'package:get_it/get_it.dart';

import 'repository/api.dart';
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
