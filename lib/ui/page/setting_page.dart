import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global/theme_bloc.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
        ),
        body: ListView(
          children: <Widget>[
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) => SwitchListTile(
                title: Text('Dark Mode', style: TextStyle(fontSize: 18.0)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                value: state.value,
                onChanged: (value) =>
                    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(value)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
