import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:starbhakmart/pages/menu_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/Animation - 1733930527183.json', 
          onLoaded: (composition) {
            Future.delayed(const Duration(seconds: 6), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MenuPage()),
              );
            });
          },
        ),
      ),
    );
  }
}
