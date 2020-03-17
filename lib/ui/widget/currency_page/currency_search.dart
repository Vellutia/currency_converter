import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../bloc/feature/recent_bloc.dart';
import '../../../constant/currency_list_const.dart';
import '../../../locator.dart';
import '../../../model/currency_list.dart';
import '../../../services/dialog_service.dart';

class CurrencySearch extends SearchDelegate {
  final bool isTop;
  final _dialogService = locator<DialogService>();
  final convertedCurrency = currencyList
      .where((e) => e is ConstCurrency)
      .map((e) => e as ConstCurrency)
      .toList();

  CurrencySearch(this.isTop)
      : super(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.none,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.primaryTextTheme.headline6,
      ),
      textTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_dialogService.dialogNavigationKey.currentState.canPop()) {
          _dialogService.dialogNavigationKey.currentState.pop();
          return false;
        } else {
          return true;
        }
      },
      child: BlocBuilder<RecentBloc, RecentState>(
        builder: (context, state) {
          final suggestion = query.isEmpty
              ? state.listCurr.isEmpty ? convertedCurrency : state.listCurr
              : state.listCurr.any((e) => e.currencyName
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  ? ((List<Currency>.from(state.listCurr.where(
                            (e) => e.currencyName
                                .toLowerCase()
                                .contains(query.toLowerCase()),
                          ))) +
                          (List<Currency>.from(convertedCurrency.where(
                            (e) => e.currencyName
                                .toLowerCase()
                                .contains(query.toLowerCase()),
                          ))))
                      .toSet()
                      .toList()
                  : List<ConstCurrency>.from(convertedCurrency.where(
                      (e) => e.currencyName
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    ));

          return ListView.builder(
            itemCount: suggestion.length,
            itemBuilder: (context, index) => ListTile(
              leading: suggestion[index] is RecentCurrency
                  ? Icon(Icons.history)
                  : Icon(Icons.search),
              title: RichText(
                text: TextSpan(
                  children: highlightOccurrences(
                    suggestion[index].currencyName,
                    query,
                    Theme.of(context).textTheme.subtitle1,
                  ),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              trailing: Transform.rotate(
                angle: 270 * math.pi / 180,
                child: IconButton(
                  icon: Icon(Icons.call_made),
                  onPressed: () => query = suggestion[index].currencyName,
                ),
              ),
              onTap: () {
                if (isTop) {
                  BlocProvider.of<CurrencyBloc>(context)
                      .add(ChangeNameTop(currency: suggestion[index]));
                } else {
                  BlocProvider.of<CurrencyBloc>(context)
                      .add(ChangeNameBottom(currency: suggestion[index]));
                }

                BlocProvider.of<RecentBloc>(context)
                    .add(RecentAdd(currency: suggestion[index]));
              },
              onLongPress: suggestion[index] is RecentCurrency
                  ? () {
                      FocusScope.of(context).unfocus();

                      BlocProvider.of<RecentBloc>(context)
                          .add(RecentRemove(currency: suggestion[index]));
                    }
                  : () {},
            ),
          );
        },
      ),
    );
  }

  List<TextSpan> highlightOccurrences(
    String source,
    String query,
    TextStyle style,
  ) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase()))
      TextSpan(text: source);

    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];

    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: style,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
