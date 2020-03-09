import 'package:flutter/material.dart';

import '../../navigator/router.dart';
import '../widget/currency_page/currency_listview.dart';

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
          leading: Builder(
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Router.navigator.pop(),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
            ),
          ),
        ),
        body: CurrencyListview(
          isTop: isTop,
        ),
      ),
    );
  }
}
