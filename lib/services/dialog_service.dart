import 'dart:async';

import 'package:flutter/material.dart';

import '../model/dialog_model.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Future<DialogResponse> Function(DialogRequest) _showDialogListener;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    return _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
  }

  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String confirmationTitle = 'Ok',
    String cancelTitle = 'Cancel',
  }) {
    return _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: confirmationTitle,
      cancelTitle: cancelTitle,
    ));
  }
}
