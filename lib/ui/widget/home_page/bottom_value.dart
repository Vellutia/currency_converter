import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_converter/model/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../constant/ui_helper.dart';
import '../../../navigator/router.dart';

class BottomValue extends StatelessWidget {
  final Function show;

  const BottomValue({
    Key key,
    this.show,
  }) : super(key: key);

  void _onLongPressed(BuildContext context, Value curS) {
    Scaffold.of(context).removeCurrentSnackBar(
      reason: SnackBarClosedReason.remove,
    );
    Clipboard.setData(
      ClipboardData(text: '${curS.value}'),
    );
    Scaffold.of(context).showSnackBar(
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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: double.infinity,
          color: Theme.of(context).accentColor,
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoaded) {
                var curS = state.bottomValue;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.2,
                        ),
                        child: Text(
                          '${curS.id}',
                          style: Theme.of(context)
                              .accentTextTheme
                              .headline5
                              .copyWith(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .headline5
                                    .color
                                    .withOpacity(0.6),
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18.0),
                                  onTap: () =>
                                      show(context, constraints, false),
                                  onLongPress: () =>
                                      _onLongPressed(context, curS),
                                  child: AutoSizeText(
                                    curS.value.toString().startsWith('0.')
                                        ? curS.value.toString().length < 4
                                            ? '${curS.value.toString().substring(0, 3)}'
                                            : '${curS.value.toString().substring(0, 4)}'
                                        : curS.value
                                                .toStringAsFixed(1)
                                                .contains('.0')
                                            ? '${curS.value.toStringAsFixed(1)}'
                                            : '${curS.value.toStringAsFixed(2)}',
                                    maxLines: 1,
                                    minFontSize: 12.0,
                                    style: Theme.of(context)
                                        .accentTextTheme
                                        .headline1,
                                  ),
                                ),
                              ),
                            ),
                            horizontalSpaceTiny,
                            Text(
                              '${curS.symbol}',
                              style: Theme.of(context)
                                  .accentTextTheme
                                  .headline5
                                  .copyWith(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .headline5
                                        .color
                                        .withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: constraints.maxHeight * 0.2,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18.0),
                            onTap: () => Router.navigator.pushNamed(
                              Router.currencyPage,
                              arguments: CurrencyPageArguments(isTop: false),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${curS.name}',
                                style:
                                    Theme.of(context).accentTextTheme.headline4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
