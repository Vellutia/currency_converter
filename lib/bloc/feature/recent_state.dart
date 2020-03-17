part of 'recent_bloc.dart';

class RecentState extends Equatable {
  final List<RecentCurrency> listCurr;

  const RecentState(this.listCurr);

  @override
  List<Object> get props => [listCurr];
}
