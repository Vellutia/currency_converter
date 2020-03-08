import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/model/rate_crypto.dart';
import 'package:http/http.dart' as http;

import '../model/rate.dart';

class Api {
  static const baseEndpoint = 'https://api.exchangeratesapi.io';
  static const header = {
    HttpHeaders.contentTypeHeader: "application/json",
  };
  static const baseCryptoEndpoint = 'https://rest.coinapi.io';
  static const headerCrypto = {
    'Content-type': 'application/json',
    'Accept': "application/json",
    'Accept-Encoding': "application/gzip"
  };
  static const apiKey = '085F9A29-8E14-494A-A5B4-8A5A0B0BDF51';
  var client = new http.Client();

  Future<double> fetchRates(String base, String symbol) async {
    var response = await client.get(
      Uri.encodeFull('$baseEndpoint/latest?base=$base&symbols=$symbol'),
      headers: header,
    );

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
