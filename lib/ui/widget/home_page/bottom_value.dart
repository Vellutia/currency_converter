import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_converter/bloc/data/dial_number_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../constant/ui_helper.dart';
import '../../../navigator/router.dart';

class BottomValue extends StatelessWidget {
  final Function show;

  const BottomValue({Key key, this.show}) : super(key: key);

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
                var curState = state.bottomValue;
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
                          '${curState.id}',
                          style: Theme.of(context).accentTextTheme.headline5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => show(context, constraints, false),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: AutoSizeText(
                                curState.value.toString().startsWith('0.')
                                    ? curState.value.toString().length < 4
                                        ? '${curState.value.toString().substring(0, 3)}'
                                        : '${curState.value.toString().substring(0, 4)}'
                                    : curState.value
                                            .toStringAsFixed(1)
                                            .contains('.0')
                                        ? '${curState.value.toStringAsFixed(1)}'
                                        : '${curState.value.toStringAsFixed(2)}',
                                maxLines: 1,
                                minFontSize: 12.0,
                                style:
                                    Theme.of(context).accentTextTheme.headline1,
                              ),
                            ),
                            horizontalSpaceTiny,
                            Text(
                              '${curState.symbol}',
                              style:
                                  Theme.of(context).accentTextTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: constraints.maxHeight * 0.2,
                        ),
                        child: GestureDetector(
                          onTap: () => Router.navigator.pushNamed(
                            Router.currencyPage,
                            arguments: CurrencyPageArguments(isTop: false),
                          ),
                          child: Text(
                            '${curState.name}',
                            style: Theme.of(context).accentTextTheme.headline4,
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
