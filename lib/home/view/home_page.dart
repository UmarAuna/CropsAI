import 'package:crops_ai/home/controller/home_controller.dart';
import 'package:crops_ai/home/widget/home_card.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      /*  appBar: AppBar(
        title: const Text('HomePage',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.primaryColor,
                fontFamily: 'Poppins')),
        centerTitle: true,
      ), */
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.white,
            child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    35.heightSpace,
                    SvgPicture.asset(
                      AppVectors.iconCropsAILogo,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    30.heightSpace,
                                    const HomeCard(),
                                  ]),
                            ))),
                    InkWell(
                      onTap: () {
                        logDebug('message');
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 17, bottom: 17),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.primaryColor,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppVectors.iconShare,
                              ),
                              5.widthSpace,
                              const Text('Share with friends',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.white,
                                      fontFamily: 'Poppins'))
                            ]),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
