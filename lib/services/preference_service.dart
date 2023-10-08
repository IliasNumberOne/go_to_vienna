import 'package:go_to_vienna/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final SharedPreferences preferences;
  PreferenceService(this.preferences);

  static const favoritesKey = 'favoritesKey';
  static const isPremiumKey = 'isPremiumKey';
  static const isFirstEntryKey = 'isFirstEntryKey';

  void cleanCasch() {
    preferences.clear();
  }

  bool getIsFirstEntry() {
    return preferences.getBool(isFirstEntryKey) ?? false;
  }
  Future<void> setIsFirstEntry() async {
    await preferences.setBool(isFirstEntryKey, true);
  }


  List<String> getFavorites() {
    final List<String> basicFavorites = List.generate(categoryItems.length, (index) => 'false');
    return preferences.getStringList(favoritesKey) ?? basicFavorites;
  }
  Future<void> setFavorites(List<String> value) async{
    await preferences.setStringList(favoritesKey, value);
  }

  bool getIsPremium() {
    return preferences.getBool(isPremiumKey) ?? false;
  }
  Future<void> setIsPremium(bool value) async {
    await preferences.setBool(isPremiumKey, value);
  }
}