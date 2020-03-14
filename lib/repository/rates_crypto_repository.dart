import '../locator.dart';
import 'api.dart';

class RatesCryptoRepository {
  final _api = locator<Api>();

  Future<double> fetchRateCrypto(String base, String symbol) async {
    return await _api.fetchRateCrypto(base, symbol);
  }
}
