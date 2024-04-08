import 'package:crops_ai/screens/crop_care/view/crop_care_page.dart';
import 'package:crops_ai/screens/crops_information/view/crops_information_page.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/disease_diagnosis_page.dart';
import 'package:crops_ai/screens/harvest_prediction/view/harvest_prediction_page.dart';
import 'package:crops_ai/screens/home/models/onboard.dart';
import 'package:crops_ai/screens/home/view/home_page.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final nameOfDiseaseController = TextEditingController();
  final nameOfCropController = TextEditingController();
  final nameOfCropCareController = TextEditingController();
  final nameOfCropHarvestController = TextEditingController();
  final locationOfCropHarvestController = TextEditingController();

  final isDiseaseNameSelected = 'disease_image'.obs;
  final isCropInfoSelected = 'crop_image'.obs;
  final isCropCareSelected = 'crop_image'.obs;
  final isCropHarvestSelected = 'crop_image'.obs;
  //final isCropLocationSelected = ''.obs;
  final pageIndex = 0.obs;
  RxInt currentPage = 0.obs;

  void goToDiseaseDiagnosisPage(BuildContext context) {
    unNamedGoTo(
        context,
        DiseaseDiagnosisPage(
          isDiseaseNameSelected: isDiseaseNameSelected.value,
          nameOfDisease: nameOfDiseaseController.text,
        ));
  }

  void goToCropInformationPage(BuildContext context) {
    unNamedGoTo(
        context,
        CropsInformationPage(
          isCropInfoSelected: isCropInfoSelected.value,
          nameOfCrop: nameOfCropController.text,
        ));
  }

  void goToCropCarePage(BuildContext context) {
    unNamedGoTo(
        context,
        CropCarePage(
          isCropCareSelected: isCropCareSelected.value,
          nameOfCrop: nameOfCropCareController.text,
        ));
  }

  void goToHarvestPredictionPage(BuildContext context) {
    unNamedGoTo(
        context,
        HarvestPredictionPage(
          nameOfCropHarvested: nameOfCropHarvestController.text,
          locationOfCropHarvested: locationOfCropHarvestController.text,
          isCropHarvestSelected: isCropHarvestSelected.value,
        ));
  }

  void goToHomePage(BuildContext context) {
    goTo(context, HomePage.id);
  }

  final List<Onboard> demoData = [
    Onboard(
      image: AppVectors.asset3,
      title: "Find Best Musicians All Around Your City",
      description:
          "Thousands of musicians around you are waiting to rock your event.",
    ),
    Onboard(
      image: AppVectors.asset3,
      title: "Fastest Way To Book Great Musicians",
      description:
          "Find the perfect match to perform for your event and make the day remarkable.",
    ),
    Onboard(
      image: AppVectors.asset3,
      title: "Find Top Sessions Pros For Your Event",
      description:
          "Find the perfect match to perform for your event and make the day remarkable.",
    ),
  ];
}
