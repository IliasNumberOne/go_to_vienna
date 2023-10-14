import 'package:flutter/material.dart';
import 'package:go_to_vienna/models/models.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/data.dart';

class PlaceProvider extends ChangeNotifier {
  final PreferenceService _preferenceService;

  PlaceProvider({
    required PreferenceService preferenceService,
  }) : _preferenceService = preferenceService;

  Category _selectedCategory = categories.first;
  List<Place> _places = [];
  Place _place = allPlaces.first;
  bool _isPremium = false;

  Category get selectedCategory => _selectedCategory;

  List<Place> get places => _places;

  Place get place => _place;

  bool get isPremium => _isPremium;

  List<int> _favorites = [];

  List<int> get favoritesId => _favorites;

  List<Place> get favorites =>
      allPlaces.where((element) => _favorites.contains(element.id)).toList();

  void init() {
    _isPremium = _preferenceService.getPremium();
    _places = List.from(allPlaces);
    _favorites = _preferenceService.getFavorites();
    notifyListeners();
  }

  void selectCategory(Category category) {
    _places =
        allPlaces.where((element) => element.category == category.id).toList();
    _selectedCategory = category;
    notifyListeners();
  }

  void selectPlace(Place place) {
    _place = place;
    notifyListeners();
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      _places = List.from(allPlaces);
      return;
    }
    _places = allPlaces
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void onLike(int index) async {
    if (_favorites.contains(index)) {
      _favorites.remove(index);
    } else {
      _favorites.add(index);
    }

    await _preferenceService.setFavorites(_favorites);

    notifyListeners();
  }

  void selectRandomCount(int count) {
    final temp = List<Place>.from(allPlaces);

    temp.shuffle();

    int count0 = 0;
    _places.clear();

    for (final item in temp) {
      if ((item.isPremium && !_isPremium) ||
          (item.category != _selectedCategory.id &&
              _selectedCategory.id != 5)) {
        continue;
      }
      _places.add(item);
      count0++;
      if (count == count0) return;
    }

    notifyListeners();
  }

  void onBuyPremium() async {
    await _preferenceService.setPremium();

    _isPremium = true;
    notifyListeners();
  }
}
