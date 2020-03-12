import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_converter/model/currency_list.dart';
import 'package:equatable/equatable.dart';

abstract class RecentEvent extends Equatable {
  final Curr curr;

  const RecentEvent(this.curr);

  @override
  List<Object> get props => [curr];
}

class RecentAdd extends RecentEvent {
  const RecentAdd(Curr curr) : super(curr);

  @override
  List<Object> get props => [curr];
}

class RecentRemove extends RecentEvent {
  RecentRemove(Curr curr) : super(curr);

  @override
  List<Object> get props => [curr];
}

class RecentBloc extends Bloc<RecentEvent, List<Curr>> {
  @override
  List<Curr> get initialState => <Curr>[];

  @override
  Stream<List<Curr>> mapEventToState(
    RecentEvent event,
  ) async* {
    if (event is RecentAdd) {
      yield List.from(state)..insert(0, event.curr);
    } else if (event is RecentRemove) {
      final updatedCurr =
          state.where((e) => e.currencyId != event.curr.currencyId).toList();

      yield updatedCurr;
    }
  }
}
