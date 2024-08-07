import 'package:crops_ai/screens/crop_care/view/crop_care_page.dart';
import 'package:crops_ai/screens/crops_information/view/crops_information_page.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/disease_diagnosis_page.dart';
import 'package:crops_ai/screens/harvest_prediction/view/harvest_prediction_page.dart';
import 'package:crops_ai/screens/home/models/onboard.dart';
import 'package:crops_ai/screens/home/view/home_page.dart';
import 'package:crops_ai/screens/home/view/onboarding_page.dart';
import 'package:crops_ai/screens/services/storage_services.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:toastification/toastification.dart';

class HomeController extends GetxController {
  final storageService = Get.find<StorageServices>();
  final nameOfDiseaseController = TextEditingController();
  final nameOfCropController = TextEditingController();
  final nameOfCropCareController = TextEditingController();
  final nameOfCropHarvestController = TextEditingController();
  final locationOfCropHarvestController = TextEditingController();
  final shorebirdCodePush = ShorebirdCodePush();

  final isDiseaseNameSelected = 'disease_image'.obs;
  final isCropInfoSelected = 'crop_image'.obs;
  final isCropCareSelected = 'crop_image'.obs;
  final isCropHarvestSelected = 'crop_image'.obs;
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

  void goToHomePage(BuildContext? context) {
    storageService.setIsFirstTime(true);
    Navigator.pushReplacementNamed(context ?? Get.context!, HomePage.id);
  }

  Future<void> goToHomePageOrOnboardingPage(BuildContext? context) async {
    logDebug('Splash Status ${storageService.getIsFirstTime().toString()}',
        level: Level.warning);

    Future.delayed(const Duration(seconds: 4), () {
      if (storageService.getIsFirstTime() ?? false) {
        return Navigator.pushReplacementNamed(
            context ?? Get.context!, HomePage.id);
      } else {
        return Navigator.pushReplacementNamed(
            context ?? Get.context!, OnboardingPage.id);
      }
    });
  }

  final List<Onboard> demoData = [
    Onboard(
      image: AppVectors.onboardDiseasesDiagnosis,
      title: 'Get Detailed Information on Disease and Pest Diagnosis',
      description:
          'CropsAI will analyze the image and identifies potential diseases or pest by taking a picture of the crop or pest.',
    ),
    Onboard(
      image: AppVectors.onboardCropInformation,
      title:
          'Get Crop Information  Available Via Image or Typed Inputs for Inquiries',
      description:
          'Get comprehensive information on a crop by either taking a picture or typing the name of crop.',
    ),
    Onboard(
      image: AppVectors.onboardCropCare,
      title: 'Crop Care Offers Tips, Duration, Growth Guidance for Cultivation',
      description:
          'Crop care helps in giving tips on how to take care of your crops, know the duration and growth circle.',
    ),
    Onboard(
      image: AppVectors.onboardHarvestPrediction,
      title:
          'Harvest Prediction Provides Crop Harvest  Details Based on Farm Location',
      description:
          'Harvest prediction tries to predict when a certain crop is going to be harvested by providing location of farm, it returns harvesting time, duration of harvest, harvest time-line and many more',
    ),
  ];

  Future<void> checkForUpdates() async {
    // Get the current patch number and print it to the console. It will be
    // null if no patches are installed.
    shorebirdCodePush
        .currentPatchNumber()
        .then((value) => logDebug('current patch number is $value'));

    // Check whether a patch is available to install.
    final isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      // Download the new patch if it's available.
      await shorebirdCodePush.downloadUpdateIfAvailable();
      showToastification(
        'App Updated Successfully',
        'Please restart the app',
        type: ToastificationType.success,
      );
    } else {
      showToastification(
        'No update',
        'Sorry no update available, please try again later',
      );
    }
  }
}
