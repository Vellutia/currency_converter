import 'package:currency_converter/model/rate_crypto.dart';

import '../locator.dart';
import 'api.dart';

class RatesCryptoRepository {
  final Api _api = locator<Api>();

  Future<double> fetchRateCrypto(String base, String symbol) async {
    return await _api.fetchRateCrypto(base, symbol);
  }
}
