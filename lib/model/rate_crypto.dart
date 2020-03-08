class RateCrypto {
  DateTime time;
  String assetIdBase;
  String assetIdQuote;
  double rate;

  RateCrypto({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
  });

  factory RateCrypto.fromJson(Map<String, dynamic> json) => RateCrypto(
        time: DateTime.parse(json["time"]),
        assetIdBase: json["asset_id_base"],
        assetIdQuote: json["asset_id_quote"],
        rate: json["rate"].toDouble(),
      );
}
