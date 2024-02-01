import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logics/weather_logic.dart';
import '../pages/splash_page.dart';
import 'package:get/get.dart';

Widget providerWithMainScreen() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WeatherLogic()),
    ],
    child: const MainScreen(),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
