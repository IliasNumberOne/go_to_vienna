import 'package:flutter/cupertino.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';

class CategoryModel extends ChangeNotifier{
  final PreferenceService _preferenceService;

  CategoryModel(
      {required PreferenceService preferenceService,})
      : _preferenceService = preferenceService;

  late int _index;
  List<int> _items = [];

  int get index => _index;
  List<int> get items => _items;

  void openPage(int index) {
    _items = [];
    _index = index;
    for(int i = 0; i < categoryItems.length; i++) {
      if(_preferenceService.getIsPremium()) {
        if(categoryItems[i].category == index) {
          items.add(i);
        }
      } else{
        if(categoryItems[i].category == index && !categoryItems[i].isPremium) {
          items.add(i);
        }
      }
    }
    notifyListeners();
  }

  List<int> getRandomItems() {
    List<int> randomItems = [];
    for(int i = 0; i < categoryItems.length; i++) {
      if(_preferenceService.getIsPremium()) {
        randomItems.add(i);
      } else{
        if(!categoryItems[i].isPremium) {
          randomItems.add(i);
        }
      }
    }
    randomItems.shuffle();
    print('items: $randomItems');
    return randomItems;
  }
}