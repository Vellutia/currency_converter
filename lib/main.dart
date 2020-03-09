import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'bloc/data/dial_number_bloc.dart';
import 'bloc/feature/currency_bloc.dart';
import 'bloc/global/theme_bloc.dart';
import 'locator.dart';
import 'navigator/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<CurrencyBloc>(
        create: (context) => CurrencyBloc()..add(InitCurrency()),
      ),
      BlocProvider<DialNumberBloc>(
        create: (context) => DialNumberBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => MaterialApp(
        theme: state.themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: Router.navigator.key,
        initialRoute: Router.homePage,
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    Router.dispose();
    super.dispose();
  }
}
