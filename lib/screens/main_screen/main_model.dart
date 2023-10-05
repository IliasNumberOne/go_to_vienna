import 'package:flutter/material.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';

class MainModel extends ChangeNotifier {
  final PreferenceService _preferenceService;

  MainModel({
    required PreferenceService preferenceService,
  }) : _preferenceService = preferenceService;

  List<int> _randomItems = [];
  String _searchText = '';

  String get searchText => _searchText;

  List<int> get randomItems => _randomItems;

  void getRandomItems() {
    for (int i = 0; i < categoryItems.length; i++) {
      if (_preferenceService.getIsPremium()) {
        _randomItems.add(i);
      } else {
        if (!categoryItems[i].isPremium) {
          _randomItems.add(i);
        }
      }
    }
    _randomItems.shuffle();
    _randomItems.removeRange(20, _randomItems.length);
  }

  void searchItems(String query) {
    _searchText = query.toLowerCase();
    _randomItems = [];
    if(query == '') {
      getRandomItems();
    } else {
      for (int i = 0; i < categoryItems.length; i++) {
        if(_preferenceService.getIsPremium()) {
          if (categoryItems[i].title.toLowerCase().contains(_searchText)) {
            _randomItems.add(i);
          }
        } else{
          if(!categoryItems[i].isPremium) {
            if (categoryItems[i].title.toLowerCase().contains(_searchText)) {
              _randomItems.add(i);
            }
          }
        }
      }
    }
    notifyListeners();
  }
}
