import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reward_calculator/constant/color_constant.dart';
import 'package:reward_calculator/screen/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const NavigationScreen()),
          (route) => false);
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AnimatedBuilder(
        animation: controller,
        builder: (c, widget) {
          return Center(
            child: Text(
              'Reward Project',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: colorWhite,
                    fontSize: animation.value *
                        (MediaQuery.of(context).size.width * 0.1),
                  ),
            ),
          );
        },
      ),
    );
  }
}
