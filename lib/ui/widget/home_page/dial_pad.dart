import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/dial_number_bloc.dart';
import '../../../bloc/feature/currency_bloc.dart';
import '../../../constant/ui_helper.dart';
import '../../../navigator/router.dart';
import 'dial_button.dart';

class DialPad extends StatefulWidget {
  final BoxConstraints constraints;
  final bool isTop;

  const DialPad({
    Key key,
    this.constraints,
    this.isTop,
  }) : super(key: key);

  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  var title = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0', '✓', ''];

  List<Widget> _getDialerButtons(BoxConstraints constraints) {
    var rows = <Widget>[];
    var items = <Widget>[];

    for (var i = 0; i < title.length; i++) {
      if (i % 3 == 0 && i > 0) {
        if (i == 3) {
          rows.add(SizedBox(
            height: constraints.maxHeight * 0.04,
          ));
        }
        rows.add(Flexible(
          fit: FlexFit.loose,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        ));
        rows.add(SizedBox(
          height: constraints.maxHeight * 0.04,
        ));
        items = <Widget>[];
      }

      if (i != 12) {
        items.add(Flexible(
          fit: FlexFit.loose,
          child: DialButton(
            title: title[i],
            constraints: constraints,
            color: widget.isTop
                ? Theme.of(context).accentColor.withOpacity(0.30)
                : Theme.of(context).primaryColor.withOpacity(0.30),
            textColor: widget.isTop
                ? Theme.of(context).primaryTextTheme.bodyText2.color
                : Theme.of(context).accentTextTheme.bodyText2.color,
            onTap: i == 11
                ? widget.isTop
                    ? (value) {
                        BlocProvider.of<CurrencyBloc>(context).add(
                          ChangeValueTop(
                            value:
                                BlocProvider.of<DialNumberBloc>(context).state,
                          ),
                        );
                        BlocProvider.of<DialNumberBloc>(context).add(
                          DialNumberDelete(),
                        );
                      }
                    : (value) {
                        BlocProvider.of<CurrencyBloc>(context).add(
                          ChangeValueBottom(
                            value:
                                BlocProvider.of<DialNumberBloc>(context).state,
                          ),
                        );
                        BlocProvider.of<DialNumberBloc>(context).add(
                          DialNumberDelete(),
                        );
                      }
                : (value) => BlocProvider.of<DialNumberBloc>(context).add(
                      DialNumberAdd(value),
                    ),
          ),
        ));
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.constraints.maxHeight * 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            verticalSpaceMedium,
            InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: () => BlocProvider.of<DialNumberBloc>(context).add(
                DialNumberDelete(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tap to delete',
                  style: widget.isTop
                      ? Theme.of(context).primaryTextTheme.headline5
                      : Theme.of(context).accentTextTheme.headline5,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.constraints.maxWidth * 0.05,
                ),
                child: Center(
                  child: BlocBuilder<DialNumberBloc, String>(
                    builder: (context, state) {
                      if (state.isEmpty) {
                        return TextField(
                          readOnly: true,
                          autofocus: true,
                          showCursor: true,
                          textAlign: TextAlign.center,
                          style: widget.isTop
                              ? Theme.of(context).primaryTextTheme.headline1
                              : Theme.of(context).accentTextTheme.headline1,
                          cursorColor: widget.isTop
                              ? Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2
                                  .color
                              : Theme.of(context)
                                  .accentTextTheme
                                  .bodyText2
                                  .color,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        );
                      } else {
                        return AutoSizeText.rich(
                          TextSpan(
                            text: state,
                          ),
                          maxLines: 1,
                          minFontSize: 16.0,
                          style: widget.isTop
                              ? Theme.of(context).primaryTextTheme.headline1
                              : Theme.of(context).accentTextTheme.headline1,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: widget.constraints.maxHeight * 1,
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.constraints.maxWidth * 0.05,
                  ),
                  child: Column(
                    children: <Widget>[
                      ..._getDialerButtons(constraints),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: widget.constraints.maxHeight * 0.1,
              color: widget.isTop
                  ? Theme.of(context).primaryIconTheme.color
                  : Theme.of(context).accentIconTheme.color,
              onPressed: () => Routers.navigator.pop(),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            ),
            verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
