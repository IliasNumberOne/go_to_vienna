import 'package:flutter/material.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TopModel extends ChangeNotifier{
  final PreferenceService _preferenceService;

  TopModel(
      {required PreferenceService preferenceService,})
      : _preferenceService = preferenceService;

  PanelController _panelController = PanelController();
  double _panelPosition = 0.0;
  bool _isVisible = true;

  PanelController get panelController => _panelController;
  bool get isVisible => _isVisible;
  double get panelPosition => _panelPosition;

  void initialize() {
    _panelPosition = _panelController.panelPosition;
    notifyListeners();
  }

  void openPanel() {
    if(_panelController.isPanelOpen) {
      _isVisible = false;
      print('position when open: ${_panelController.panelPosition}');
    }
    notifyListeners();
  }
  void closePanel() {
    if(_panelController.isPanelClosed) {
      _isVisible = true;
      print('position when close: ${_panelController.panelPosition}');
    }
    notifyListeners();
  }

  void pageChanges(int) {
    _isVisible = true;
    notifyListeners();
  }
}