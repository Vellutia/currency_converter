import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/data/position_bloc.dart';
import '../locator.dart';
import '../ui/page/currency_page.dart';
import '../ui/page/home_page.dart';
import '../ui/page/setting_page.dart';
import 'router_extended.dart';
import 'router_utils.dart';

class Router {
  // Route names
  static const homePage = '/';
  static const settingPage = '/setting-page';
  static const currencyPage = '/currency-page';
  static final navigator = ExtendedNavigator();

  // Bloc
  static final _positionBloc = locator<PositionBloc>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case Router.settingPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.currencyPage:
        final typedArgs =
            args as CurrencyPageArguments ?? CurrencyPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => BlocProvider.value(
            value: _positionBloc,
            child: CurrencyPage(
              key: typedArgs.key,
              isTop: typedArgs.isTop,
            ),
          ),
          settings: settings,
          fullscreenDialog: true,
        );
      // case Router.settingPage:
      //   final typedArgs =
      //       args as AdditionPageArguments ?? AdditionPageArguments();
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => AdditionPage(
      //       key: typedArgs.key,
      //       number: typedArgs.number,
      //     ),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      default:
        return unknownRoutePage(settings.name);
    }
  }

  static void dispose() {
    _positionBloc.close();
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

// CurrencyPage arguments holder class
class CurrencyPageArguments {
  final Key key;
  final bool isTop;

  CurrencyPageArguments({this.key, this.isTop});
}
