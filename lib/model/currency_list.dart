import 'package:equatable/equatable.dart';

abstract class CurrencyList {}

class Category implements CurrencyList {
  final String category;

  const Category(this.category);
}

abstract class Curr implements CurrencyList {
  final String currencyId;
  final String currencyName;
  final String currencySymbol;

  const Curr(this.currencyId, this.currencyName, this.currencySymbol);
}

class Currency extends Curr {
  const Currency(String currencyId, String currencyName, String currencySymbol)
      : super(currencyId, currencyName, currencySymbol);

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        json['currencyId'],
        json['currencyName'],
        json['currencySymbol'],
      );

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
      };
}

class CurrencyCrypto extends Curr {
  const CurrencyCrypto(
      String currencyId, String currencyName, String currencySymbol)
      : super(currencyId, currencyName, currencySymbol);

  factory CurrencyCrypto.fromJson(Map<String, dynamic> json) => CurrencyCrypto(
        json['currencyId'],
        json['currencyName'],
        json['currencySymbol'],
      );

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
      };
}
