import 'package:flutter/cupertino.dart';
import 'package:go_to_vienna/services/preference_service.dart';

class FavoritesModel extends ChangeNotifier{
  final PreferenceService _preferenceService;

  FavoritesModel(
      {required PreferenceService preferenceService,})
      : _preferenceService = preferenceService;

  List<int> getItems() {
    final List<String> _favorites = _preferenceService.getFavorites();
    final List<int> _trueFavorites = [];
    for(int i = 0; i < _favorites.length; i++) {
      if(bool.parse(_favorites[i])) {
        _trueFavorites.add(i);
      }
    }
    return _trueFavorites;
  }
}