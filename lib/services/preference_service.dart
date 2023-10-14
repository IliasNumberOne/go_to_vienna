import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final SharedPreferences preferences;

  PreferenceService(this.preferences);

  static const favoritesKey = 'favoritesKey';
  static const isPremiumKey = 'isPremiumKey';
  static const isFirstEntryKey = 'isFirstEntryKey';
  static const linkKey = 'LINK';

  Future<void> setLink(String link) async {
    await preferences.setString(linkKey, link);
  }

  String? getLink() {
    return preferences.getString(linkKey);
  }

  bool getIsFirstEntry() {
    return preferences.getBool(isFirstEntryKey) ?? false;
  }

  Future<void> setIsFirstEntry() async {
    await preferences.setBool(isFirstEntryKey, true);
  }

  List<int> getFavorites() {
    final map = preferences.getStringList(favoritesKey) ?? [];
    if (map.isEmpty) return [];
    final favorites = map.map((e) => int.parse(e)).toList();
    return favorites;
  }

  Future<void> setFavorites(List<int> favorites) async {
    final map = favorites.map((e) => e.toString()).toList();
    await preferences.setStringList(favoritesKey, map);
  }

  bool getPremium() {
    return preferences.getBool(isPremiumKey) ?? false;
  }

  Future<void> setPremium() async {
    await preferences.setBool(isPremiumKey, true);
  }
}
