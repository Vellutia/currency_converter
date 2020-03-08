import 'package:flutter/material.dart';

import '../../../model/currency_list.dart';

class CategoryTile extends StatelessWidget {
  final Category item;
  final bool isTop;

  const CategoryTile({
    Key key,
    this.item,
    this.isTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        title: Text(
          '${item.category}',
          style: isTop
              ? Theme.of(context).primaryTextTheme.headline5
              : Theme.of(context).accentTextTheme.headline5,
        ),
      ),
    );
  }
}
