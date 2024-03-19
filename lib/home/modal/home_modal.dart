import 'package:crops_ai/components/app_decoration.dart';
import 'package:crops_ai/home/controller/home_controller.dart';
import 'package:crops_ai/home/widget/home_modal_item.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeModal extends StatefulWidget {
  const HomeModal({super.key});

  @override
  State<HomeModal> createState() => _HomeModalState();
}

class _HomeModalState extends State<HomeModal> {
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppVectors.icDragModal),
                15.heightSpace,
                // Content goes here
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (homeController
                                          .isDiseaseNameSelected.value ==
                                      'disease_text') ...[
                                    InkWell(
                                      onTap: () {
                                        homeController.isDiseaseNameSelected
                                            .value = 'disease_image';
                                      },
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    15.widthSpace,
                                  ],
                                  const Text('Content Options',
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  homeController.isDiseaseNameSelected.value ==
                                          'disease_text'
                                      ? 'Enter disease name to diagnose'
                                      : 'Select your preference to diagnose disease',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppin',
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w400)),
                            ]),
                        20.heightSpace,
                        if (homeController.isDiseaseNameSelected.value ==
                            'disease_image') ...[
                          HomeModalItem(
                              onClick: () {
                                homeController.isDiseaseNameSelected.value =
                                    'disease_text';
                              },
                              title: 'Write name of disease'),
                          20.heightSpace,
                          HomeModalItem(
                              onClick: () {
                                homeController.isDiseaseNameSelected.value =
                                    'disease_image';
                                homeController.nameOfDiseaseController.text =
                                    '';
                                homeController
                                    .goToDiseaseDiagnosisPage(context);
                              },
                              title: 'Capture image of crop disease'),
                        ],
                        10.heightSpace,
                        if (homeController.isDiseaseNameSelected.value ==
                            'disease_text') ...[
                          TextFormField(
                              controller:
                                  homeController.nameOfDiseaseController,
                              decoration:
                                  AppDecorations.inputDecorationLight.copyWith(
                                counterText: '',
                                hintText: 'e.g Rust Fungus',
                                filled: true,
                                fillColor: AppColors.transparent,
                              ),
                              style: const TextStyle(fontSize: 12.0),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name of crop disease';
                                } else {
                                  return null;
                                }
                              }),
                          10.heightSpace,
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.primaryColor)),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final isValid = _formKey.currentState!.validate();
                              if (!isValid) {
                                return;
                              }
                              homeController.goToDiseaseDiagnosisPage(context);
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
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
