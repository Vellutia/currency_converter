import 'package:equatable/equatable.dart';

class Value extends Equatable {
  final String id, name, symbol;
  final double value;
  final bool isCurr;

  const Value({
    this.id,
    this.name,
    this.symbol,
    this.value,
    this.isCurr,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        value: json['value'],
        isCurr: json['isCurr'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'value': value,
        'isCurr': isCurr,
      };

  Value copyWith({
    String id,
    String name,
    String symbol,
    double value,
    bool isCurr,
  }) {
    return Value(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      value: value ?? this.value,
      isCurr: isCurr ?? this.isCurr,
    );
  }

  @override
  List<Object> get props => [id, name, symbol, value, isCurr];
}
