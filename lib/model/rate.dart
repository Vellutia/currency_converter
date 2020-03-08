class Rate {
  Rates rates;
  String base;
  DateTime date;

  Rate({
    this.rates,
    this.base,
    this.date,
  });

  factory Rate.fromJson(Map<String, dynamic> json, String symbol) => Rate(
        rates: Rates.fromJson(json["rates"], symbol),
        base: json["base"],
        date: DateTime.parse(json["date"]),
      );
}

class Rates {
  double gbp;

  Rates({
    this.gbp,
  });

  factory Rates.fromJson(Map<String, dynamic> json, String symbol) => Rates(
        gbp: json["$symbol"].toDouble(),
      );
}
