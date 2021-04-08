import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/rate.dart';
import '../model/rate_crypto.dart';

class Api {
  static const baseEndpoint = 'https://openexchangerates.org/api';
  // static const baseEndpoint = 'https://api.exchangeratesapi.io';
  // static const header = {
  //   HttpHeaders.contentTypeHeader: "application/json",
  // };
  static const baseCryptoEndpoint = 'https://rest.coinapi.io';
  static const headerCrypto = {
    'Content-type': 'application/json',
    'Accept': "application/json",
    'Accept-Encoding': "application/gzip"
  };
  // Get your own APP ID from openexchangerates - https://openexchangerates.org/
  static const appID = '6fef2514d2b04f53adb5d95db2e6b753';
  // Get your own API key from CoinAPI - https://www.coinapi.io/
  static const apiKey = 'F792B90B-1CF3-44FA-AA5C-F30B080C30D9';
  var client = new http.Client();

  Future<double> fetchRates(String base, String symbol) async {
    var response = await client.get(
      Uri.encodeFull(
          '$baseEndpoint/latest.json?app_id=$appID&base=$base&symbols=$symbol'),
      // Uri.encodeFull('$baseEndpoint/latest?base=$base&symbols=$symbol'),
      // headers: header,
    );

    print('response: ${response.request} ${response.statusCode}');
    print(
        'rate: ${Rate.fromJson(json.decode(response.body), symbol).rates.gbp}');

    return Rate.fromJson(json.decode(response.body), symbol).rates.gbp;
  }

  Future<double> fetchRateCrypto(String base, String symbol) async {
    var response = await client.get(
      Uri.encodeFull(
          '$baseCryptoEndpoint/v1/exchangerate/$base/$symbol?apiKey=$apiKey'),
      headers: headerCrypto,
    );

    return RateCrypto.fromJson(json.decode(response.body)).rate;
  }
}
