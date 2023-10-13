import 'package:flutter/cupertino.dart';
import 'package:go_to_vienna/services/preference_service.dart';

class PlaceProvider extends ChangeNotifier {
  final PreferenceService _preferenceService;

  PlaceProvider({
    required PreferenceService preferenceService,
  }) : _preferenceService = preferenceService;
}
