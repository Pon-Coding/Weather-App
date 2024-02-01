import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherLogic extends ChangeNotifier {
  WeatherModel? _weatherList;
  WeatherModel? get weatherList => _weatherList;

  String? _error;
  String? get error => _error;

  Future read({required String myCountry}) async {
    await WeatherService.getData(
      country: myCountry,
      onSuccess: (data) => _weatherList = data,
      onError: (e) => _error = e,
    );
    notifyListeners();
  }

  Future readCurrentLocation({required LatLng currentLocation}) async {
    await WeatherService.getDataByLatLng(
      currentLocation: currentLocation,
      onSuccess: (data) => _weatherList = data,
      onError: (e) => _error = e,
    );
    notifyListeners();
  }

}
