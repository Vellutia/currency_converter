import 'package:flutter/material.dart';

import '../widget/currency_page/currency_listview.dart';
import '../widget/currency_page/currency_search.dart';

class CurrencyPage extends StatelessWidget {
  final bool isTop;

  const CurrencyPage({
    Key key,
    this.isTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isTop
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: isTop
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          iconTheme: isTop
              ? Theme.of(context).primaryIconTheme
              : Theme.of(context).accentIconTheme,
          actionsIconTheme: isTop
              ? Theme.of(context).primaryIconTheme
              : Theme.of(context).accentIconTheme,
          title: Text(
            'Currency',
            style: isTop
                ? Theme.of(context).primaryTextTheme.headline6
                : Theme.of(context).accentTextTheme.headline6,
          ),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => showSearch(
                    context: context,
                    delegate: CurrencySearch(isTop),
                  ),
                  tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                ),
              ),
            ),
          ],
        ),
        body: CurrencyListview(
          isTop: isTop,
        ),
      ),
    );
  }
}
