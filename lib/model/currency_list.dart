import 'package:equatable/equatable.dart';

abstract class CurrencyList {}

class Category implements CurrencyList {
  final String category;

  const Category(this.category);
}

class Currency extends Equatable implements CurrencyList {
  final String currencyId, currencyName, currencySymbol;
  final bool isCrypto;

  const Currency(
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.isCrypto,
  );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        json['currencyId'],
        json['currencyName'],
        json['currencySymbol'],
        json['isCrypto'],
      );

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
        'isCrypto': isCrypto,
      };

  @override
  List<Object> get props =>
      [currencyId, currencyName, currencySymbol, isCrypto];
}
