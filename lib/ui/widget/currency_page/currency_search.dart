import 'dart:collection';
import 'dart:math' as math;

import 'package:currency_converter/bloc/feature/recent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../constant/currency_list_const.dart';
import '../../../model/currency_list.dart';

class CurrencySearch extends SearchDelegate {
  final bool isTop;
  final convertedCurrency = currencyList
      .where((e) => e is Currency)
      .map((e) => e as Currency)
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
    final _recentBloc = BlocProvider.of<RecentBloc>(context).state as Recent;

    List<Currency> suggestions() {
      if (query.isEmpty) {
        if (_recentBloc.listCurr.isEmpty) {
          return convertedCurrency;
        } else {
          return _recentBloc.listCurr;
        }
      } else {
        if (_recentBloc.listCurr.any((e) =>
            e.currencyName.toLowerCase().contains(query.toLowerCase()))) {
          final listFromBloc = _recentBloc.listCurr
              .where((e) =>
                  e.currencyName.toLowerCase().contains(query.toLowerCase()))
              .toList();

          final listFromConst = convertedCurrency
              .where((e) =>
                  e.currencyName.toLowerCase().contains(query.toLowerCase()))
              .toList();

          return (listFromBloc + listFromConst).toSet().toList();
        } else {
          final listFromConst = convertedCurrency
              .where(
                (e) =>
                    e.currencyName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

          return listFromConst;
        }
      }
    }

    final suggestion = suggestions();

    return BlocBuilder<RecentBloc, RecentState>(
      builder: (context, state) => ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
          leading: query.isEmpty
              ? _recentBloc.listCurr.isEmpty
                  ? Icon(Icons.search)
                  : Icon(Icons.history)
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
            BlocProvider.of<RecentBloc>(context)
                .add(RecentAdd(curr: suggestion[index]));
            isTop
                ? BlocProvider.of<CurrencyBloc>(context)
                    .add(ChangeNameTop(currency: suggestion[index]))
                : BlocProvider.of<CurrencyBloc>(context)
                    .add(ChangeNameBottom(currency: suggestion[index]));
          },
          onLongPress: () {
            FocusScope.of(context).unfocus();

            BlocProvider.of<RecentBloc>(context)
                .add(RecentRemove(curr: suggestion[index]));
          },
        ),
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
