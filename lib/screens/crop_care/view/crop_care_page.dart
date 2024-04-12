import 'package:crops_ai/screens/crop_care/controller/crop_care_controller.dart';
import 'package:crops_ai/screens/crop_care/view/crop_care_image.dart';
import 'package:crops_ai/screens/crop_care/view/crop_care_text.dart';
import 'package:crops_ai/screens/home/widget/page_loader.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropCarePage extends StatefulWidget {
  static const id = 'crop_care_page';
  final String? isCropCareSelected;
  final String? nameOfCrop;
  const CropCarePage({super.key, this.isCropCareSelected, this.nameOfCrop});

  @override
  State<CropCarePage> createState() => _CropCarePageState();
}

class _CropCarePageState extends State<CropCarePage> {
  final cropCareController = Get.put<CropCareController>(CropCareController());

  @override
  void initState() {
    super.initState();
    if (widget.isCropCareSelected == 'crop_text') {
      cropCareController.getCropCareText(widget.nameOfCrop ?? '');
    } else {
      cropCareController.getCropCareImage();
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
        body: widget.isCropCareSelected == 'crop_text'
            ? cropCareController.loading.value
                ? const PageLoader()
                : PopScope(
                    canPop:
                        true, //When false, blocks the current route from being popped.
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        return;
                      }
                      cropCareController.responseText.value = '';
                      goBack(context);
                    },
                    child: CropCareText(cropCareController: cropCareController))
            : cropCareController.loading.value
                ? const PageLoader()
                : PopScope(
                    canPop:
                        true, //When false, blocks the current route from being popped.
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        return;
                      }
                      cropCareController.responseText.value = '';
                      cropCareController.photo = null;
                      goBack(context);
                    },
                    child:
                        CropCareImage(cropCareController: cropCareController)),
      );
    });
  }
}
