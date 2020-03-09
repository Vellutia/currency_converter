part of 'currency_bloc.dart';

abstract class CurrencyState extends Equatable {
  final Value topValue, bottomValue;
  final bool isTop;

  const CurrencyState(this.topValue, this.bottomValue, this.isTop);

  @override
  List<Object> get props => [topValue, bottomValue, isTop];
}

class CurrencyInitial extends CurrencyState {
  const CurrencyInitial({Value topValue, Value bottomValue, bool isTop})
      : super(topValue, bottomValue, isTop);
}

class CurrencyLoaded extends CurrencyState {
  const CurrencyLoaded({Value topValue, Value bottomValue, bool isTop})
      : super(topValue, bottomValue, isTop);
}
