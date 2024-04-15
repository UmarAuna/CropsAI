import 'package:crops_ai/components/app_decoration.dart';
import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/screens/home/widget/home_modal_item.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HarvestPredictionModal extends StatefulWidget {
  const HarvestPredictionModal({super.key});

  @override
  State<HarvestPredictionModal> createState() => _HarvestPredictionModalState();
}

class _HarvestPredictionModalState extends State<HarvestPredictionModal> {
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: 380,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppVectors.icDragModal),
                15.heightSpace,
                // Content goes here
                Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (homeController.pageIndex.value == 1 ||
                                  homeController.pageIndex.value == 2) ...[
                                InkWell(
                                  onTap: () {
                                    if (homeController
                                            .isCropHarvestSelected.value ==
                                        'crop_image') {
                                      homeController.pageIndex.value = 0;
                                    }
                                    if (homeController.pageIndex.value == 1) {
                                      homeController.pageIndex.value = 0;
                                    } else if (homeController.pageIndex.value ==
                                        2) {
                                      homeController.pageIndex.value = 1;
                                    }
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                15.widthSpace,
                              ],
                              const Text('Harvest Prediction Options',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppin',
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              goBack(context);
                              homeController.pageIndex.value = 0;
                            },
                            child: SvgPicture.asset(
                              AppVectors.iconCloseOutline,
                              /*   colorFilter: ColorFilter.mode(
                                            widget.mainController.isLightTheme.value
                                                ? AppColors.textInputBorderLight
                                                : AppColors.doyarAsh,
                                            BlendMode.srcIn) */
                            ),
                          )
                        ]),
                    8.heightSpace,
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      if (homeController.pageIndex.value == 0)
                        const Text(
                            'Select your preference to know harvest prediction',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppin',
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w400))
                      else if (homeController.pageIndex.value == 1)
                        const Text('Enter crop name that you want to harvest',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppin',
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w400))
                      else
                        const Text('Enter your farm location',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppin',
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w400)),
                    ]),
                    20.heightSpace,
                    if (homeController.pageIndex.value == 0) ...[
                      HomeModalItem(
                          onClick: () {
                            homeController.isCropHarvestSelected.value =
                                'crop_text';
                            homeController.pageIndex.value = 1;
                          },
                          title: 'Write name of crop'),
                      20.heightSpace,
                      HomeModalItem(
                          onClick: () {
                            //homeController.pageIndex.value = 1;
                            homeController.isCropHarvestSelected.value =
                                'crop_image';
                            homeController.nameOfCropHarvestController.text =
                                '';
                            //homeController.goToHarvestPredictionPage(context);
                            homeController.pageIndex.value = 2;
                          },
                          title: 'Capture image of crop'),
                    ],
                    10.heightSpace,
                    if (homeController.pageIndex.value == 1) ...[
                      TextFormField(
                          controller:
                              homeController.nameOfCropHarvestController,
                          decoration:
                              AppDecorations.inputDecorationLight.copyWith(
                            counterText: '',
                            hintText: 'e.g Millet',
                            filled: true,
                            fillColor: AppColors.transparent,
                          ),
                          style: const TextStyle(fontSize: 12.0),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name of crop';
                            } else {
                              return null;
                            }
                          }),
                      10.heightSpace,
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor)),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final isValid = _formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          homeController.pageIndex.value = 2;
                          //homeController.goToCropCarePage(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 10),
                          child: Text('Proceed',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppin',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                    if (homeController.pageIndex.value == 2) ...[
                      TextFormField(
                          controller:
                              homeController.locationOfCropHarvestController,
                          decoration:
                              AppDecorations.inputDecorationLight.copyWith(
                            counterText: '',
                            hintText: 'e.g Nasko, Niger State, Nigeria',
                            filled: true,
                            fillColor: AppColors.transparent,
                          ),
                          style: const TextStyle(fontSize: 12.0),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter location';
                            } else {
                              return null;
                            }
                          }),
                      10.heightSpace,
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor)),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final isValid = _formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          //homeController.isCropHarvestSelected.value ='crop_text';
                          homeController.goToHarvestPredictionPage(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 10),
                          child: Text('Proceed',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppin',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
