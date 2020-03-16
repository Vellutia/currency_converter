import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/feature/currency_bloc.dart';
import '../../../bloc/feature/recent_bloc.dart';
import '../../../constant/ui_helper.dart';
import '../../../model/currency_list.dart';

class CurrencyTile extends StatelessWidget {
  final Currency item;
  final bool isTop;

  const CurrencyTile({
    Key key,
    this.item,
    this.isTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: item.isCurr ? false : true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '${item.currencyName}',
            style: isTop
                ? Theme.of(context).primaryTextTheme.headline5
                : Theme.of(context).accentTextTheme.headline5,
          ),
          horizontalSpaceMedium,
          Text(
            '${item.currencySymbol}',
            style: isTop
                ? Theme.of(context).primaryTextTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w300,
                    )
                : Theme.of(context).accentTextTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
          ),
        ],
      ),
      onTap: () {
        if (isTop) {
          BlocProvider.of<CurrencyBloc>(context)
              .add(ChangeNameTop(currency: item));
        } else {
          BlocProvider.of<CurrencyBloc>(context)
              .add(ChangeNameBottom(currency: item));
        }

        BlocProvider.of<RecentBloc>(context).add(RecentAdd(currency: item));
      },
    );
  }
}
