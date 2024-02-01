import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../logics/weather_logic.dart';
import '../pages/main_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await context.read<WeatherLogic>().read(myCountry: "Ta Khmau");
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainPage()));

      Get.to(() => const MainPage(),
          transition: Transition.fade, duration: const Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Lottie.asset("assets/lotties/weather.json"),
      ),
    );
  }
}
