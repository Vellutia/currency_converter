import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../locator.dart';
import '../../model/currency_list.dart';
import '../../services/dialog_service.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends HydratedBloc<RecentEvent, RecentState> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  RecentState get initialState => super.initialState ?? Recent(<Currency>[]);

  @override
  Stream<RecentState> mapEventToState(
    RecentEvent event,
  ) async* {
    if (event is RecentAdd) {
      if (state.listCurr
          .any((e) => e.currencyId == event.currency.currencyId)) {
        yield Recent(state.listCurr
          ..removeWhere((e) => e.currencyId == event.currency.currencyId)
          ..insert(0, event.currency));
      } else {
        yield Recent(state.listCurr..insert(0, event.currency));
      }
    } else if (event is RecentRemove) {
      final value = await confirm(event.currency);

      if (value) {
        final updatedCurr = state.listCurr
            .where((e) => e.currencyId != event.currency.currencyId)
            .toList();
        yield Recent(updatedCurr);
      }
    }
  }

  @override
  RecentState fromJson(Map<String, dynamic> json) {
    List<Currency> recent = List<Currency>();

    try {
      final parsed = json['recent'] as List;

      for (var json in parsed) {
        recent.add(Currency.fromJson(json));
      }

      return Recent(recent);
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

  Future<bool> confirm(Currency curr) async {
    return await _dialogService
        .showConfirmationDialog(
          title: '${curr.currencyName}',
          cancelTitle: 'CANCEL',
          confirmationTitle: 'REMOVE',
          description: 'Remove from search history?',
        )
        .then((value) => value.confirmed);
  }
}
