import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  static const id = 'splash_screen_page';
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  final homeController = Get.put<HomeController>(HomeController());

  /// ANIMATION CONTROLLER
  late AnimationController _controller;

  /// ANIMATION
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// INITIALING THE CONTROLLER
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    /// INITIALING THE ANIMATION
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);

    /// STARTING THE ANIMATION
    _controller.forward();

    homeController.goToHomePageOrOnboardingPage(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: ScaleTransition(
          scale: _animation,
          child: Center(
            child: SvgPicture.asset(
              AppVectors.appLogo,
            ),
          ),
        ),
      ),
    );
  }
}
