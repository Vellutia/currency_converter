import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/feature/currency_bloc.dart';
import '../../navigator/router.dart';
import '../widget/home_page/bottom_value.dart';
import '../widget/home_page/dial_pad.dart';
import '../widget/home_page/top_value.dart';

class HomePage extends StatelessWidget {
  void show(BuildContext context, BoxConstraints constraints, bool isTop) {
    showModalBottomSheet(
      backgroundColor: isTop
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => DialPad(
        constraints: constraints,
        isTop: isTop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          foregroundColor:
              Theme.of(context).floatingActionButtonTheme.foregroundColor,
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: () => Router.navigator.pushNamed(Router.settingPage),
          child: Icon(Icons.settings),
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                TopValue(
                  show: show,
                ),
                BottomValue(
                  show: show,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size * 0.5 * 0.3,
                width: size * 0.5 * 0.3,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size * 0.5 * 0.26,
                width: size * 0.5 * 0.26,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Theme.of(context).accentColor,
                ),
                child: BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) => Icon(
                    state.isTop == null
                        ? null
                        : state.isTop
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                    size: size * 0.5 * 0.2,
                    color: Theme.of(context).accentIconTheme.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
