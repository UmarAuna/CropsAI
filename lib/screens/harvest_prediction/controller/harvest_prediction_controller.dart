import 'dart:io';

import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_config.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class HarvestPredictionController extends GetxController {
  final responseText = ''.obs;
  final loading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? photo;
 
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: AppConfig.apiKey,
    generationConfig: AppConfig.generationConfig,
    safetySettings: AppConfig.safetySettings,
  );

  final visionModel = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: AppConfig.apiKey,
    generationConfig: AppConfig.generationConfig,
    safetySettings: AppConfig.safetySettings,
  );

  Future<void> getHarvestPredictionImage(String location) async {
    if (!await hasInternetConnection()) {
      StylishDialog(
        context: Get.context!,
        alertType: StylishDialogType.ERROR,
        title: const Text('No Internet Connection'),
        content: const Text('Please connect too the internet...'),
        confirmButton: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryColor)),
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
As a highly skilled farmer, Could you kindly help me with the following inquiries regarding crop cultivation? by following the guidelines below and relevant disclaimers at the end:

**Guidelines:**

**Crop Identification and Location:** Please identify the crop with emoji depicted in the provided image and specify its cultivation location.

**Harvest Timing::** When the crop is mature and ready to be harvested in that location.

**Duration of harvest:** How long does the harvest season typically last for this crop in the specified location?

**Harvest Timeline:** Could you provide a timeline outlining the stages of harvest for the identified crop grown in the specified location?

**Optimal Harvest Time:** When is the best time to harvest this crop in the specified location?

**Best time to harvest it in this $location:** when is the best time to harvest it in $location.

**Best way to harvest:** Techniques for harvesting the crop properly.

**Harvesting Techniques:** What are the recommended techniques for harvesting this crop effectively?

**Preservation and storage:** How should the harvested crop be preserved and stored to maintain its quality?

**Recommendations:** What are the best practices for managing the harvest and preventing diseases in this crop?

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
      final response = await visionModel.generateContent(content);
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

  Future<String> getHarvestPredictionText(
      String cropName, String location) async {
    if (!await hasInternetConnection()) {
      StylishDialog(
        context: Get.context!,
        alertType: StylishDialogType.ERROR,
        title: const Text('No Internet Connection'),
        content: const Text('Please connect too the internet...'),
        confirmButton: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryColor)),
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
As a highly skilled farmer, Could you assist me with harvest predictions for $cropName grown in $location? I'm seeking guidance on how to effectively harvest the crop, the expected duration of the harvest period, optimal timing for harvesting, recommended methods for preserving and storing the produce, along with any additional recommendations and relevant disclaimers at the end:

**Guidelines:**

**Crop Identification and Location:** Provide name of crop with emoji if any found and location

**Harvest Timing::** When the crop is mature and ready to be harvested in that location.

**Duration of harvest:** How long the harvest season lasts in that location.

**Harvest Timeline:** Give me the timeline of harvest for $cropName grown in $location.

**Optimal Harvest Time:** When is the best time to harvest this crop in the specified location?

**Best time to harvest it in $location:** when is the best time to harvest it in $location.

**Best way to harvest:** Techniques for harvesting the crop properly.

**Harvesting Techniques:** What are the recommended techniques for harvesting this crop effectively?

**Preservation and storage:** How to preserve and store the harvested crop.

**Recommendations:** Best practices for harvest management and disease prevention.

**Links:** Get recent and relevant links that will help the farmer.

**Disclaimer:**
  *"Please note that the information provided is based on general agricultural knowledge and should not replace professional agricultural advice. Consult with qualified agricultural experts for specific recommendations considering local conditions."*
""";
    try {
      loading.value = true;
      final content = [Content.text(inputPrompt)];
      final response = await model.generateContent(content);
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
