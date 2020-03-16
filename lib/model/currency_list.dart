import 'package:equatable/equatable.dart';

abstract class CurrencyList {}

class Category implements CurrencyList {
  final String category;

  const Category(this.category);
}

class Currency extends Equatable implements CurrencyList {
  final String currencyId, currencyName, currencySymbol;
  final bool isCurr;

  const Currency(
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.isCurr,
  );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        json['currencyId'],
        json['currencyName'],
        json['currencySymbol'],
        json['isCurr'],
      );

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
        'isCurr': isCurr,
      };

  @override
  List<Object> get props => [
        currencyId,
        currencyName,
        currencySymbol,
        isCurr,
      ];
}
