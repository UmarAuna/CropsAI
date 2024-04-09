import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  static const id = 'onboarding_page';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: homeController.demoData.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                homeController.currentPage.value = index;
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 70),
                    SvgPicture.asset(homeController.demoData[index].image),
                    const SizedBox(height: 50),
                    Text(homeController.demoData[index].title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppin',
                            color: AppColors.black100,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Text(homeController.demoData[index].description,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppin',
                            color:
                                AppColors.onboardingTextColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400)),
                    const Spacer(),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor)),
                      onPressed: () {
                        homeController.goToHomePage(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        child: Text('Get Started',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppin',
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          homeController.demoData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 5,
                            width: homeController.currentPage.value == index
                                ? 15
                                : 5, // Adjust the size of the active dot
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: homeController.currentPage.value == index
                                  ? AppColors.primaryColor
                                  : Colors
                                      .grey, // Adjust active and inactive dot colors
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
