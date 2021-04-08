import 'package:currency_converter/model/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void onLongPressed(BuildContext context, Value curS) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
      reason: SnackBarClosedReason.remove,
    );
    Clipboard.setData(
      ClipboardData(text: '${curS.value}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 24.0,
          child: Text('Copied to Clipboard.'),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          floatingActionButton: FloatingActionButton(
            mini: true,
            foregroundColor:
                Theme.of(context).floatingActionButtonTheme.foregroundColor,
            backgroundColor:
                Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () => Routers.navigator.pushNamed(Routers.settingPage),
            child: Icon(Icons.settings),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TopValue(
                    show: show,
                    onLongPressed: onLongPressed,
                  ),
                  BottomValue(
                    show: show,
                    onLongPressed: onLongPressed,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: constraints.maxHeight * 0.5 * 0.3,
                  width: constraints.maxHeight * 0.5 * 0.3,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: constraints.maxHeight * 0.5 * 0.26,
                  width: constraints.maxHeight * 0.5 * 0.26,
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
                      size: constraints.maxHeight * 0.5 * 0.2,
                      color: Theme.of(context).accentIconTheme.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
