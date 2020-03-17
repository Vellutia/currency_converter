part of 'recent_bloc.dart';

abstract class RecentEvent extends Equatable {
  final Currency currency;

  const RecentEvent(this.currency);

  @override
  List<Object> get props => [currency];
}

class RecentAdd extends RecentEvent {
  const RecentAdd({Currency currency}) : super(currency);
}

class RecentRemove extends RecentEvent {
  const RecentRemove({Currency currency}) : super(currency);
}
