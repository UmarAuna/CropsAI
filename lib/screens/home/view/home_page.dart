import 'dart:io';

import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/screens/home/widget/home_card.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put<HomeController>(HomeController());

  PackageInfo? packageInfo;
  String _version = '';
  //String message = '';

  Future<void> init() async {
    getVersion();
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: const Text('Home',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontFamily: 'Poppins')),

                //systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
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
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            30.heightSpace,
                                            const HomeCard(),
                                          ]),
                                    ))),
                            InkWell(
                              onDoubleTap: () {
                                if (Platform.isAndroid) {
                                  homeController.checkForUpdates();
                                }
                              },
                              child: Text('v.$_version',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.5),
                                      fontFamily: 'Poppins')),
                            ),
                            10.heightSpace,
                            InkWell(
                              onTap: () {
                                logDebug('message');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 17, bottom: 17),
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
            )));
  }
}
