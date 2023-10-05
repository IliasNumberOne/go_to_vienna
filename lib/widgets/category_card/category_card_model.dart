import 'package:flutter/material.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';

class CategoryCardModel extends ChangeNotifier {
  final PreferenceService _preferenceService;

  CategoryCardModel(
      {required PreferenceService preferenceService})
      : _preferenceService = preferenceService;

  late List<String> _favorites;

  void tapFavorites(int index) {
    _favorites = _preferenceService.getFavorites();
    _favorites[index] = '${!bool.parse(_favorites[index])}';
    _preferenceService.setFavorites(_favorites);
    notifyListeners();
  }
}