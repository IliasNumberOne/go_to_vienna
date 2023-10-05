import 'package:flutter/cupertino.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';

class RandomItemsModel extends ChangeNotifier{
  final PreferenceService _preferenceService;

  RandomItemsModel(
      {required PreferenceService preferenceService,})
      : _preferenceService = preferenceService;

  List<int> _items = [];
  List<int> get items => _items;

  void getRandomIndex(int category, int count) {
    _items = [];
    for(int i = 0; i < categoryItems.length; i++) {
      if(_preferenceService.getIsPremium()) {
        if(category == 5) {
          _items.add(i);
        }else if(category == categoryItems[i].category) {
          _items.add(i);
        }
      } else{
        if(category == 5 && !categoryItems[i].isPremium) {
          _items.add(i);
        }else if(category == categoryItems[i].category && !categoryItems[i].isPremium) {
          _items.add(i);
        }
      }
    }
    _items.shuffle();
    notifyListeners();
  }
}