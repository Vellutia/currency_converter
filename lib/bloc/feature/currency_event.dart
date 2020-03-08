part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class InitCurrency extends CurrencyEvent {
  @override
  List<Object> get props => [];
}

class ChangeNameTop extends CurrencyEvent {
  final Curr currency;

  ChangeNameTop({this.currency});

  @override
  List<Object> get props => [currency];
}

class ChangeNameBottom extends CurrencyEvent {
  final Curr currency;

  ChangeNameBottom({this.currency});

  @override
  List<Object> get props => [currency];
}

class ChangeValueTop extends CurrencyEvent {
  final String value;

  ChangeValueTop({this.value});

  @override
  List<Object> get props => [value];
}

class ChangeValueBottom extends CurrencyEvent {
  final String value;

  ChangeValueBottom({this.value});

  @override
  List<Object> get props => [value];
}
