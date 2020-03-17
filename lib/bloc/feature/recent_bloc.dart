import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../locator.dart';
import '../../model/currency_list.dart';
import '../../services/dialog_service.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends HydratedBloc<RecentEvent, RecentState> {
  final _dialogService = locator<DialogService>();

  @override
  RecentState get initialState =>
      super.initialState ?? RecentState(<RecentCurrency>[]);

  @override
  Stream<RecentState> mapEventToState(
    RecentEvent event,
  ) async* {
    if (event is RecentAdd) {
      final newEvent =
          RecentCurrency.fromJson((event.currency as ConstCurrency).toJson());

      if (state.listCurr.any((e) => e.currencyId == newEvent.currencyId)) {
        final newState = List.from(state.listCurr)
          ..removeWhere((e) => e.currencyId == newEvent.currencyId)
          ..insert(0, newEvent);
        yield RecentState(newState);
      } else {
        yield RecentState(
          state.listCurr..insert(0, newEvent),
        );
      }
    } else if (event is RecentRemove) {
      final newEvent =
          RecentCurrency.fromJson((event.currency as RecentCurrency).toJson());

      final value = await confirm(newEvent);

      if (value) {
        final updatedCurr = state.listCurr
            .where((e) => e.currencyId != newEvent.currencyId)
            .toList();
        yield RecentState(updatedCurr);
      }
    }
  }

  @override
  RecentState fromJson(Map<String, dynamic> json) {
    List<RecentCurrency> recent = List<RecentCurrency>();

    try {
      final parsed = json['recent'] as List;

      for (var json in parsed) {
        recent.add(RecentCurrency.fromJson(json));
      }

      return RecentState(recent);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(RecentState state) {
    try {
      final recent = state.listCurr.map((e) => e.toJson()).toList();
      return {'recent': recent};
    } catch (_) {
      return null;
    }
  }

  Future<bool> confirm(RecentCurrency currency) {
    return _dialogService
        .showConfirmationDialog(
          title: '${currency.currencyName}',
          cancelTitle: 'CANCEL',
          confirmationTitle: 'REMOVE',
          description: 'Remove from search history?',
        )
        .then((value) => value.confirmed);
  }
}
