import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../constant/ui_helper.dart';
import '../../../model/value.dart';
import '../../../navigator/router.dart';

class TopValue extends StatelessWidget {
  final void Function(BuildContext, BoxConstraints, bool) show;
  final void Function(BuildContext, Value) onLongPressed;

  const TopValue({
    Key key,
    this.show,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoaded) {
                var curS = state.topValue;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.15,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18.0),
                            onTap: () => Routers.navigator.pushNamed(
                              Routers.currencyPage,
                              arguments: CurrencyPageArguments(isTop: true),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${curS.name}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                        show(context, constraints, true),
                                    onLongPress: () =>
                                        onLongPressed(context, curS),
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
                                          .primaryTextTheme
                                          .headline1,
                                    ),
                                  ),
                                ),
                              ),
                              horizontalSpaceTiny,
                              Text(
                                '${curS.symbol}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline5
                                    .copyWith(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5
                                          .color
                                          .withOpacity(0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: constraints.maxHeight * 0.2,
                        ),
                        child: Text(
                          '${curS.id}',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5
                              .copyWith(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline5
                                    .color
                                    .withOpacity(0.6),
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Offstage();
              }
            },
          ),
        ),
      ),
    );
  }
}
