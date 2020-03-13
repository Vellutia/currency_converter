part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class InitCurrency extends CurrencyEvent {}

class ChangeNameTop extends CurrencyEvent {
  final Currency currency;

  const ChangeNameTop({this.currency});

  @override
  List<Object> get props => [currency];
}

class ChangeNameBottom extends CurrencyEvent {
  final Currency currency;

  const ChangeNameBottom({this.currency});

  @override
  List<Object> get props => [currency];
}

class ChangeValueTop extends CurrencyEvent {
  final String value;

  const ChangeValueTop({this.value});

  @override
  List<Object> get props => [value];
}

class ChangeValueBottom extends CurrencyEvent {
  final String value;

  const ChangeValueBottom({this.value});

  @override
  List<Object> get props => [value];
}
