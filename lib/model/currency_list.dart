abstract class CurrencyList {}

class Category implements CurrencyList {
  final String category;

  const Category(this.category);
}

abstract class Currency implements CurrencyList {
  final String currencyId;
  final String currencyName;
  final String currencySymbol;
  final bool isCurr;

  const Currency(
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.isCurr,
  );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Currency &&
        o.currencyId == currencyId &&
        o.currencyName == currencyName &&
        o.currencySymbol == currencySymbol &&
        o.isCurr == isCurr;
  }

  @override
  int get hashCode {
    return currencyId.hashCode ^
        currencyName.hashCode ^
        currencySymbol.hashCode ^
        isCurr.hashCode;
  }
}

class ConstCurrency extends Currency {
  const ConstCurrency(
    String currencyId,
    String currencyName,
    String currencySymbol,
    bool isCurr,
  ) : super(currencyId, currencyName, currencySymbol, isCurr);

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
        'isCurr': isCurr,
      };
}

class RecentCurrency extends Currency {
  const RecentCurrency(
    String currencyId,
    String currencyName,
    String currencySymbol,
    bool isCurr,
  ) : super(currencyId, currencyName, currencySymbol, isCurr);

  factory RecentCurrency.fromJson(Map<String, dynamic> json) => RecentCurrency(
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
}
