import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/position_bloc.dart';
import '../../../constant/currency_list_const.dart';
import '../../../model/currency_list.dart';
import 'category_tile.dart';
import 'currency_tile.dart';

class CurrencyListview extends StatefulWidget {
  final bool isTop;

  const CurrencyListview({
    Key key,
    this.isTop,
  }) : super(key: key);

  @override
  _CurrencyListviewState createState() => _CurrencyListviewState();
}

class _CurrencyListviewState extends State<CurrencyListview> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
      initialScrollOffset: BlocProvider.of<PositionBloc>(context).state ?? 0.0,
    );
    _controller.addListener(
      () => BlocProvider.of<PositionBloc>(context)
          .add(_controller.position.pixels),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: currencyList.length,
      itemBuilder: (context, index) {
        final item = currencyList[index];

        if (item is Category) {
          return CategoryTile(
            item: item,
            isTop: widget.isTop,
          );
        } else {
          return CurrencyTile(
            item: item,
            isTop: widget.isTop,
          );
        }
      },
    );
  }
}
