import 'dart:io';

import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_config.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CropsInformationController extends GetxController {
  final responseText = ''.obs;
  final loading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  Future<void> getCropInformationImage() async {
    if (!await hasInternetConnection()) {
      StylishDialog(
        context: Get.context!,
        alertType: StylishDialogType.ERROR,
        title: const Text('No Internet Connection'),
        content: const Text('Please connect too the internet...'),
        confirmButton: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor: WidgetStateProperty.all(AppColors.primaryColor)),
          onPressed: () {
            goBack(Get.context!);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
            child: Text('Ok',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppin',
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ).show();
      return;
    }

    photo = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 60);
    final imageBytes = await File(photo!.path).readAsBytes();
    logDebug('Image bytes: $imageBytes');
    final inputPrompt = TextPart("""
As a highly skilled farmer please Identify the name of the crop in the image and help provide comprehensive information regarding the crop name by getting crop cultivation, including planting guides, fertilizer recommendations, water requirements, common pests, and diseases? Additionally, could you filter the information based on crop categories such as fruits, vegetables, grains, etc.? and give me relevant disclaimers at the end following this guidelines:

**Guidelines:**

**Crop name:** Provide name of crop with emoji if any found

**Crop category:** What type of crop category is this, i.e fruits, vegetables, grains, or legumes.

**Planting guides:** Tips on timing, spacing, and fertilization.

**Fertilizer recommendations:** Best fertilizers based on soil, climate, and crop type.

**Water needs:** Recommended irrigation practices based on weather conditions and soil type.

**Common pests and diseases:** Information about common pests and diseases that affect each crop, as well as prevention and treatment methods.

**Links:** Get recent and relevant links that will help the farmer.

**Disclaimer:**
  *"Please note that the information provided is based on general agricultural knowledge and should not replace professional agricultural advice. Consult with qualified agricultural experts for specific recommendations considering local conditions."*
""");

    try {
      loading.value = true;
      final content = [
        Content.multi([
          inputPrompt,
          DataPart('image/jpeg', imageBytes),
        ])
      ];
      final response = await AppConfig.visionModel.generateContent(content);
      debugPrint(response.text);
      loading.value = false;
      responseText.value = response.text!;
    } catch (e) {
      loading.value = false;
      debugPrint(e.toString());
      responseText.value = 'message: ${e.toString()}';
      //return responseText.value = 'Error generating text';
    }
  }

  Future<String> getCropInformationText(String nameOfCrop) async {
    if (!await hasInternetConnection()) {
      StylishDialog(
        context: Get.context!,
        alertType: StylishDialogType.ERROR,
        title: const Text('No Internet Connection'),
        content: const Text('Please connect too the internet...'),
        confirmButton: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor: WidgetStateProperty.all(AppColors.primaryColor)),
          onPressed: () {
            goBack(Get.context!);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
            child: Text('Ok',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppin',
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ).show();
      return 'No Internet Connection...';
    }

    final inputPrompt = """
As a highly skilled farmer please help provide comprehensive information regarding $nameOfCrop by getting crop cultivation, including planting guides, fertilizer recommendations, water requirements, common pests, and diseases? Additionally, could you filter the information based on crop categories such as fruits, vegetables, grains, etc.? and give me relevant disclaimers at the end following this guidelines:

**Guidelines:**

**Crop name:** Provide name of crop with emoji if any found

**Crop category:** What type of crop category is this, i.e fruits, vegetables, grains, or legumes or any.

**Planting guides:** Tips on timing, spacing, and fertilization.

**Fertilizer recommendations:** Best fertilizers based on soil, climate, and crop type.

**Water needs:** Recommended irrigation practices based on weather conditions and soil type.

**Common pests and diseases:** Information about common pests and diseases that affect each crop, as well as prevention and treatment methods.

**Links:** Get recent and relevant links that will help the farmer.

**Disclaimer:**
  *"Please note that the information provided is based on general agricultural knowledge and should not replace professional agricultural advice. Consult with qualified agricultural experts for specific recommendations considering local conditions."*
""";
    // Generate text using the GenerativeModel instance.
    try {
      loading.value = true;
      final content = [Content.text(inputPrompt)];
      final response = await AppConfig.model.generateContent(content);
      debugPrint(response.text);
      loading.value = false;
      return responseText.value = response.text!;
    } catch (e) {
      loading.value = false;
      debugPrint(e.toString());
      return responseText.value = 'Error generating text';
    }
  }
}
