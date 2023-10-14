import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TopModel extends ChangeNotifier {
  final PanelController _panelController = PanelController();
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
    if (_panelController.isPanelShown) {
      _isVisible = false;
    }
    notifyListeners();
  }

  void closePanel() {
    if (_panelController.isPanelClosed) {
      _isVisible = true;
    }
    notifyListeners();
  }

  void pageChanges() {
    _isVisible = true;
    notifyListeners();
  }
}
