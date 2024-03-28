import 'package:crops_ai/screens/harvest_prediction/controller/harvest_prediction_controller.dart';
import 'package:crops_ai/screens/harvest_prediction/view/harvest_prediction_image.dart';
import 'package:crops_ai/screens/harvest_prediction/view/harvest_prediction_text.dart';
import 'package:crops_ai/screens/home/widget/page_loader.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HarvestPredictionPage extends StatefulWidget {
  static const id = 'harvest_prediction_page';
  final String? nameOfCropHarvested;
  final String? locationOfCropHarvested;
  final String? isCropHarvestSelected;
  const HarvestPredictionPage(
      {super.key,
      this.nameOfCropHarvested,
      this.locationOfCropHarvested,
      this.isCropHarvestSelected});

  @override
  State<HarvestPredictionPage> createState() => _HarvestPredictionPageState();
}

class _HarvestPredictionPageState extends State<HarvestPredictionPage> {
  final harvestPredictionController =
      Get.put<HarvestPredictionController>(HarvestPredictionController());

  @override
  void initState() {
    super.initState();
    if (widget.isCropHarvestSelected == 'crop_text') {
      harvestPredictionController.getHarvestPredictionText(
          widget.nameOfCropHarvested ?? '',
          widget.locationOfCropHarvested ?? '');
    } else {
      harvestPredictionController
          .getHarvestPredictionImage(widget.locationOfCropHarvested ?? '');
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
              widget.nameOfCropHarvested != ''
                  ? widget.nameOfCropHarvested ?? ''
                  : 'About this crop',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.white,
                  fontFamily: 'Poppins')),
          centerTitle: true,
        ),
        body: widget.isCropHarvestSelected == 'crop_text'
            ? harvestPredictionController.loading.value
                ? const PageLoader()
                : WillPopScope(
                    onWillPop: () async {
                      harvestPredictionController.responseText.value = '';
                      goBack(context);
                      return true;
                    },
                    child: HarvestPredictionText(
                        harvestPredictionController:
                            harvestPredictionController))
            : harvestPredictionController.loading.value
                ? const PageLoader()
                : WillPopScope(
                    onWillPop: () async {
                      harvestPredictionController.responseText.value = '';
                      harvestPredictionController.photo = null;
                      goBack(context);
                      return true;
                    },
                    child: HarvestPredictionImage(
                        harvestPredictionController:
                            harvestPredictionController)),
      );
    });
  }
}
