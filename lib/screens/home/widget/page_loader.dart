import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';

class PageLoader extends StatelessWidget {
  static const id = 'page_loader_page';
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 53, right: 53),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      const Text(
                        '🤖',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: 0.13,
                        ),
                      ),
                      10.heightSpace,
                      const Text('Please wait CropsAI is doing some magic...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppin',
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      10.heightSpace,
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
