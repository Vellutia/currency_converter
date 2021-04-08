class Rate {
  final Rates rates;
  final String base;
  // final DateTime date;

  const Rate({
    this.rates,
    this.base,
    // this.date,
  });

  factory Rate.fromJson(Map<String, dynamic> json, String symbol) => Rate(
        rates: Rates.fromJson(json["rates"], symbol),
        base: json["base"],
        // date: DateTime.parse(json["date"]),
      );
}

class Rates {
  final double gbp;

  const Rates({
    this.gbp,
  });

  factory Rates.fromJson(Map<String, dynamic> json, String symbol) => Rates(
        gbp: json["$symbol"].toDouble(),
      );
}
