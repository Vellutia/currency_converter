import 'package:equatable/equatable.dart';

class Value extends Equatable {
  final String id, name, symbol;
  final double value;

  const Value({this.id, this.name, this.symbol, this.value});

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'value': value,
      };

  Value copyWith({String id, String name, String symbol, double value}) {
    return Value(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [id, name, symbol, value];
}
