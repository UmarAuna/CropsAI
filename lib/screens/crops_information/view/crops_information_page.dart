import 'package:crops_ai/screens/crops_information/controller/crops_information_controller.dart';
import 'package:crops_ai/screens/crops_information/view/crops_info_image.dart';
import 'package:crops_ai/screens/crops_information/view/crops_info_text.dart';
import 'package:crops_ai/screens/home/widget/page_loader.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropsInformationPage extends StatefulWidget {
  static const id = 'crops_information_page';
  final String? isCropInfoSelected;
  final String? nameOfCrop;
  const CropsInformationPage(
      {super.key, this.isCropInfoSelected, this.nameOfCrop});

  @override
  State<CropsInformationPage> createState() => _CropsInformationPageState();
}

class _CropsInformationPageState extends State<CropsInformationPage> {
  final cropsInfoController =
      Get.put<CropsInformationController>(CropsInformationController());

  @override
  void initState() {
    super.initState();
    if (widget.isCropInfoSelected == 'crop_text') {
      cropsInfoController.getCropInformationText(widget.nameOfCrop ?? '');
    } else {
      cropsInfoController.getCropInformationImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.white),
          elevation: 0,
          title: Text(
              widget.nameOfCrop != ''
                  ? widget.nameOfCrop ?? ''
                  : 'About this crop',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.white,
                  fontFamily: 'Poppins')),
          centerTitle: true,
        ),
        body: widget.isCropInfoSelected == 'crop_text'
            ? cropsInfoController.loading.value
                ? const PageLoader()
                : PopScope(
                    canPop: false,
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        return;
                      }
                      cropsInfoController.responseText.value = '';
                      goBack(context);
                    },
                    child:
                        CropsInfoText(cropsInfoController: cropsInfoController))
            : cropsInfoController.loading.value
                ? const PageLoader()
                : PopScope(
                    canPop: false,
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        return;
                      }
                      cropsInfoController.responseText.value = '';
                      cropsInfoController.photo = null;
                      goBack(context);
                    },
                    child: CropsInfoImage(
                        cropsInfoController: cropsInfoController)),
      );
    });
  }
}
