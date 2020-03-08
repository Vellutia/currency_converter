import '../locator.dart';
import '../model/rate.dart';
import 'api.dart';

class RatesRepository {
  final Api _api = locator<Api>();

  Future<double> fetchRates(String base, String symbol) async {
    return await _api.fetchRates(base, symbol);
  }
}
