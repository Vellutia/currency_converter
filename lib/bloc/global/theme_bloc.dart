import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../constant/style.dart';

class ThemeEvent extends Equatable {
  final bool value;

  const ThemeEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ThemeState extends Equatable {
  final bool value;
  final ThemeData themeData;
  final TextSelectionThemeData textSelectionThemeData;

  const ThemeState(this.value, this.themeData, this.textSelectionThemeData);

  @override
  List<Object> get props => [value, themeData];
}

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      super.initialState ??
      ThemeState(
        false,
        ThemeData.light().copyWith(
          primaryColor: primaryColor,
          accentColor: accentColor,
          primaryTextTheme: primaryTextTheme,
          accentTextTheme: accentTextTheme,
          primaryIconTheme: primaryIconTheme,
          accentIconTheme: accentIconTheme,
          floatingActionButtonTheme: floatingTheme,
          appBarTheme: primaryAppBarTheme,
        ),
        TextSelectionThemeData().copyWith(
          cursorColor: accentColor,
        ),
      );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    yield (event.value)
        ? ThemeState(
            true,
            ThemeData.dark().copyWith(
              primaryColor: darkPrimaryColor,
              accentColor: darkAccentColor,
              primaryTextTheme: darkPrimaryTextTheme,
              accentTextTheme: darkAccentTextTheme,
              primaryIconTheme: darkPrimaryIconTheme,
              accentIconTheme: darkAccentIconTheme,
              floatingActionButtonTheme: darkFloatingTheme,
              appBarTheme: darkPrimaryAppBarTheme,
            ),
            TextSelectionThemeData().copyWith(
              cursorColor: darkAccentColor,
            ),
          )
        : ThemeState(
            false,
            ThemeData.light().copyWith(
              primaryColor: primaryColor,
              accentColor: accentColor,
              primaryTextTheme: primaryTextTheme,
              accentTextTheme: accentTextTheme,
              primaryIconTheme: primaryIconTheme,
              accentIconTheme: accentIconTheme,
              floatingActionButtonTheme: floatingTheme,
              appBarTheme: primaryAppBarTheme,
            ),
            TextSelectionThemeData().copyWith(
              cursorColor: accentColor,
            ),
          );
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      return (json['theme'] == 'true')
          ? ThemeState(
              false,
              ThemeData.light().copyWith(
                primaryColor: primaryColor,
                accentColor: accentColor,
                primaryTextTheme: primaryTextTheme,
                accentTextTheme: accentTextTheme,
                primaryIconTheme: primaryIconTheme,
                accentIconTheme: accentIconTheme,
                floatingActionButtonTheme: floatingTheme,
                appBarTheme: primaryAppBarTheme,
              ),
              TextSelectionThemeData().copyWith(
                cursorColor: accentColor,
              ),
            )
          : ThemeState(
              true,
              ThemeData.dark().copyWith(
                primaryColor: darkPrimaryColor,
                accentColor: darkAccentColor,
                primaryTextTheme: darkPrimaryTextTheme,
                accentTextTheme: darkAccentTextTheme,
                primaryIconTheme: darkPrimaryIconTheme,
                accentIconTheme: darkAccentIconTheme,
                floatingActionButtonTheme: darkFloatingTheme,
                appBarTheme: darkPrimaryAppBarTheme,
              ),
              TextSelectionThemeData().copyWith(
                cursorColor: darkAccentColor,
              ),
            );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    final bool isLight = (state ==
        ThemeState(
          false,
          ThemeData.light().copyWith(
            primaryColor: primaryColor,
            accentColor: accentColor,
            primaryTextTheme: primaryTextTheme,
            accentTextTheme: accentTextTheme,
            primaryIconTheme: primaryIconTheme,
            accentIconTheme: accentIconTheme,
            floatingActionButtonTheme: floatingTheme,
            appBarTheme: primaryAppBarTheme,
          ),
          TextSelectionThemeData().copyWith(
            cursorColor: accentColor,
          ),
        ));

    try {
      return {'theme': '$isLight'};
    } catch (_) {
      return null;
    }
  }
}
