part of 'recent_bloc.dart';

abstract class RecentState {
  final List<Currency> listCurr;

  const RecentState(this.listCurr);
}

class Recent extends RecentState {
  Recent(List<Currency> listCurr) : super(listCurr);
}
