import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../locator.dart';
import '../../model/currency_list.dart';
import '../../model/value.dart';
import '../../navigator/router.dart';
import '../../repository/rates_crypto_repository.dart';
import '../../repository/rates_repository.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends HydratedBloc<CurrencyEvent, CurrencyState> {
  final _ratesRepository = locator<RatesRepository>();
  final _ratesCryptoRepository = locator<RatesCryptoRepository>();

  @override
  CurrencyState get initialState =>
      super.initialState ??
      CurrencyInitial(
        topValue: Value(),
        bottomValue: Value(),
        isTop: null,
      );

  @override
  Stream<CurrencyState> mapEventToState(
    CurrencyEvent event,
  ) async* {
    if (event is InitCurrency) {
      yield* _mapInitCurrencyToState();
    } else if (event is ChangeNameTop) {
      yield* _mapChangeNameTopToState(event);
    } else if (event is ChangeNameBottom) {
      yield* _mapChangeNameBottomToState(event);
    } else if (event is ChangeValueTop) {
      yield* _mapChangeValueTopToState(event);
    } else if (event is ChangeValueBottom) {
      yield* _mapChangeValueBottomToState(event);
    }
  }

  Stream<CurrencyState> _mapInitCurrencyToState() async* {
    if (state is CurrencyInitial) {
      final rates = await _ratesRepository.fetchRates('USD', 'IDR');
      final topValue = Value(
        id: 'IDR',
        name: 'Indonesian Rupiah',
        symbol: 'Rp',
        value: 1 * rates,
        isCurr: true,
      );
      final bottomValue = Value(
        id: 'USD',
        name: 'United States Dollar',
        symbol: '\$',
        value: 1,
        isCurr: true,
      );
      final isTop = false;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    } else if (state is CurrencyLoaded) {
      final rates = await _mapInitRates();
      final topValue = (state as CurrencyLoaded).isTop
          ? (state as CurrencyLoaded).topValue.copyWith()
          : (state as CurrencyLoaded).topValue.copyWith(
                value: (state as CurrencyLoaded).bottomValue.value * rates,
              );
      final bottomValue = (state as CurrencyLoaded).isTop
          ? (state as CurrencyLoaded).bottomValue.copyWith(
                value: (state as CurrencyLoaded).topValue.value * rates,
              )
          : (state as CurrencyLoaded).bottomValue.copyWith();
      final isTop = (state as CurrencyLoaded).isTop;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    }
  }

  Stream<CurrencyState> _mapChangeNameTopToState(
    ChangeNameTop event,
  ) async* {
    if (state is CurrencyLoaded) {
      Routers.navigator.pushNamedAndRemoveUntil(
        Routers.homePage,
        (Route<dynamic> route) => false,
      );
      final rates = await _mapChangeNameTopRates(event);

      final topValue = (state as CurrencyLoaded).topValue.copyWith(
            id: event.currency.currencyId,
            name: event.currency.currencyName,
            symbol: event.currency.currencySymbol,
            isCurr: event.currency.isCurr ? true : false,
          );
      final bottomValue = (state as CurrencyLoaded).bottomValue.copyWith(
            value: (state as CurrencyLoaded).topValue.value * rates,
          );
      final isTop = true;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    }
  }

  Stream<CurrencyState> _mapChangeNameBottomToState(
    ChangeNameBottom event,
  ) async* {
    if (state is CurrencyLoaded) {
      Routers.navigator.pushNamedAndRemoveUntil(
        Routers.homePage,
        (Route<dynamic> route) => false,
      );
      final rates = await _mapChangeNameBottomRates(event);
      final topValue = (state as CurrencyLoaded).topValue.copyWith(
            value: (state as CurrencyLoaded).bottomValue.value * rates,
          );
      final bottomValue = (state as CurrencyLoaded).bottomValue.copyWith(
            id: event.currency.currencyId,
            name: event.currency.currencyName,
            symbol: event.currency.currencySymbol,
            isCurr: event.currency.isCurr ? true : false,
          );
      final isTop = false;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    }
  }

  Stream<CurrencyState> _mapChangeValueTopToState(
    ChangeValueTop event,
  ) async* {
    if (state is CurrencyLoaded && event.value.isNotEmpty) {
      Routers.navigator.pop();
      final rates = await _mapChangeValueTopRates();
      final topValue = (state as CurrencyLoaded).topValue.copyWith(
            value: double.parse(event.value),
          );
      final bottomValue = (state as CurrencyLoaded).bottomValue.copyWith(
            value: double.parse(event.value) * rates,
          );
      final isTop = true;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    }
  }

  Stream<CurrencyState> _mapChangeValueBottomToState(
    ChangeValueBottom event,
  ) async* {
    if (state is CurrencyLoaded && event.value.isNotEmpty) {
      Routers.navigator.pop();
      final rates = await _mapChangeValueBottomRates();
      final topValue = (state as CurrencyLoaded).topValue.copyWith(
            value: double.parse(event.value) * rates,
          );
      final bottomValue = (state as CurrencyLoaded).bottomValue.copyWith(
            value: double.parse(event.value),
          );
      final isTop = false;
      yield CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    }
  }

  @override
  CurrencyState fromJson(Map<String, dynamic> json) {
    final topValue = Value.fromJson(json['topValue']);
    final bottomValue = Value.fromJson(json['bottomValue']);
    final isTop = json['isTop'];
    try {
      return CurrencyLoaded(
        topValue: topValue,
        bottomValue: bottomValue,
        isTop: isTop,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(CurrencyState state) {
    final topValue = (state as CurrencyLoaded).topValue.toJson();
    final bottomValue = (state as CurrencyLoaded).bottomValue.toJson();
    final isTop = (state as CurrencyLoaded).isTop;
    try {
      return {
        'topValue': topValue,
        'bottomValue': bottomValue,
        'isTop': isTop,
      };
    } catch (_) {
      return null;
    }
  }

  Future<double> _mapInitRates() async {
    if ((state as CurrencyLoaded).isTop) {
      return ((state as CurrencyLoaded).topValue.isCurr &&
              (state as CurrencyLoaded).bottomValue.isCurr)
          ? await _ratesRepository.fetchRates(
              '${(state as CurrencyLoaded).topValue.id}',
              '${(state as CurrencyLoaded).bottomValue.id}',
            )
          : await _ratesCryptoRepository.fetchRateCrypto(
              '${(state as CurrencyLoaded).topValue.id}',
              '${(state as CurrencyLoaded).bottomValue.id}',
            );
    } else {
      return ((state as CurrencyLoaded).topValue.isCurr &&
              (state as CurrencyLoaded).bottomValue.isCurr)
          ? await _ratesRepository.fetchRates(
              '${(state as CurrencyLoaded).bottomValue.id}',
              '${(state as CurrencyLoaded).topValue.id}',
            )
          : await _ratesCryptoRepository.fetchRateCrypto(
              '${(state as CurrencyLoaded).bottomValue.id}',
              '${(state as CurrencyLoaded).topValue.id}',
            );
    }
  }

  Future<double> _mapChangeNameTopRates(ChangeNameTop event) async {
    return (event.currency.isCurr &&
            (state as CurrencyLoaded).bottomValue.isCurr)
        ? await _ratesRepository.fetchRates(
            '${event.currency.currencyId}',
            '${(state as CurrencyLoaded).bottomValue.id}',
          )
        : await _ratesCryptoRepository.fetchRateCrypto(
            '${event.currency.currencyId}',
            '${(state as CurrencyLoaded).bottomValue.id}',
          );
  }

  Future<double> _mapChangeNameBottomRates(ChangeNameBottom event) async {
    return (event.currency.isCurr && (state as CurrencyLoaded).topValue.isCurr)
        ? await _ratesRepository.fetchRates(
            '${event.currency.currencyId}',
            '${(state as CurrencyLoaded).topValue.id}',
          )
        : await _ratesCryptoRepository.fetchRateCrypto(
            '${event.currency.currencyId}',
            '${(state as CurrencyLoaded).topValue.id}',
          );
  }

  Future<double> _mapChangeValueTopRates() async {
    return ((state as CurrencyLoaded).topValue.isCurr &&
            (state as CurrencyLoaded).bottomValue.isCurr)
        ? await _ratesRepository.fetchRates(
            '${(state as CurrencyLoaded).topValue.id}',
            '${(state as CurrencyLoaded).bottomValue.id}',
          )
        : await _ratesCryptoRepository.fetchRateCrypto(
            '${(state as CurrencyLoaded).topValue.id}',
            '${(state as CurrencyLoaded).bottomValue.id}',
          );
  }

  Future<double> _mapChangeValueBottomRates() async {
    return ((state as CurrencyLoaded).topValue.isCurr &&
            (state as CurrencyLoaded).bottomValue.isCurr)
        ? await _ratesRepository.fetchRates(
            '${(state as CurrencyLoaded).bottomValue.id}',
            '${(state as CurrencyLoaded).topValue.id}',
          )
        : await _ratesCryptoRepository.fetchRateCrypto(
            '${(state as CurrencyLoaded).bottomValue.id}',
            '${(state as CurrencyLoaded).topValue.id}',
          );
  }
}
