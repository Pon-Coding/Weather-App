import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherService {
  static Future<void> getData(
      {String country = "Ta Khmau",required void Function(WeatherModel?) onSuccess,
      required void Function(String?) onError}) async {
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?appid=057f3972a2e20f30fdfc880c26366c43&units=metric&q="+country;
      final dio = Dio();
      final response = await dio.get(url);
      onSuccess(WeatherModel.fromJson(response.data));
      onError(null);
      debugPrint("Done !!!");
      debugPrint("${response.data}");
    } catch (e) {
      onError(e.toString());
    }
  }


  //by latlon
  static Future<void> getDataByLatLng(
      {required currentLocation,required void Function(WeatherModel?) onSuccess,
      required void Function(String?) onError}) async {
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?appid=057f3972a2e20f30fdfc880c26366c43&units=metric&lat="+currentLocation.latitude.toString()+"&lon="+currentLocation.longitude.toString();
      final dio = Dio();
      final response = await dio.get(url);
      onSuccess(WeatherModel.fromJson(response.data));
      onError(null);
      debugPrint("Done !!!");
      debugPrint("${response.data}");
    } catch (e) {
      onError(e.toString());
    }
  }
}
