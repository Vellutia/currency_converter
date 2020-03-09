class RateCrypto {
  final DateTime time;
  final String assetIdBase;
  final String assetIdQuote;
  final double rate;

  const RateCrypto({
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
