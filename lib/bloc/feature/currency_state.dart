part of 'currency_bloc.dart';

abstract class CurrencyState extends Equatable {
  final Value topValue, bottomValue;
  final bool isTop;

  const CurrencyState(this.topValue, this.bottomValue, this.isTop);
}

class CurrencyInitial extends CurrencyState {
  CurrencyInitial({Value topValue, Value bottomValue, bool isTop})
      : super(topValue, bottomValue, isTop);

  @override
  List<Object> get props => [topValue, bottomValue, isTop];
}

class CurrencyLoaded extends CurrencyState {
  CurrencyLoaded({Value topValue, Value bottomValue, bool isTop})
      : super(topValue, bottomValue, isTop);

  @override
  List<Object> get props => [topValue, bottomValue, isTop];
}
