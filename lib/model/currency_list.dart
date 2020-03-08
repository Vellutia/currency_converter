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
}

class CurrencyCrypto extends Curr {
  const CurrencyCrypto(
      String currencyId, String currencyName, String currencySymbol)
      : super(currencyId, currencyName, currencySymbol);
}
