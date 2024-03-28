import 'dart:io';

import 'package:crops_ai/utils/app_config.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class HarvestPredictionController extends GetxController {
  final responseText = ''.obs;
  final loading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  // Create a GenerativeModel instance with your API key and model name.
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
    /* if (photo != null) {
      print('No image selected');
      return;
    } */
    photo = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 60);
    final imageBytes = await File(photo!.path).readAsBytes();
    logDebug('Image bytes: $imageBytes');
    final inputPrompt = TextPart("""
As a highly skilled plant pathologist Identify the name of the crop in the image and provide the necessary information when is best to harvest this crop in this $location  . Your role involves conducting a detailed analysis to identify the specific issues, propose solutions, and offer recommendations.
Also please don't prepare it as a report.

**Guidelines:**
//TODO  continue from here Fix this it is not getting location even its provided
1. **Best time to harvest in this $location:** when is the best time to harvest it in $location.

2. **How to harvest it:** Best way to harvest it.

3. **Best way to preserve it:** Recommend best ways to preserve it.

4. **Recommendations:** Provide recommendation.

5. **Important Note:** As a plant pathologist, your insights are vital for informed decision-making in agriculture and plant management. Your response should be thorough, concise, and focused on plant.

**Disclaimer:**
*"Please note that the information provided is based on plant pathology analysis and should not replace professional agricultural advice. Consult with qualified agricultural experts before implementing any strategies or treatments."*

Your role is pivotal in ensuring the health and productivity of plants. Proceed to analyze the provided information or samples, adhering to the structured 
""");

    // Generate text using the GenerativeModel instance.

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

    //print(response.text);
  }

  Future<String> getHarvestPredictionText(
      String cropName, String location) async {
    final inputPrompt = """
As a highly skilled plant pathologist, your expertise is indispensable in our pursuit when  is best to harvest $cropName in $location . Your role involves conducting a detailed analysis to identify the specific issues, propose solutions, and offer recommendations.
Also please don't prepare it as a report.

**Guidelines:**

1. **Best time to harvest:** when is the best time to harvest it.

2. **How to harvest it:** Best way to harvest it.

3. **Best way to preserve it:** Recommend best ways to preserve it.

4. **Recommendations:** Provide recommendation.

5. **Important Note:** As a plant pathologist, your insights are vital for informed decision-making in agriculture and plant management. Your response should be thorough, concise, and focused on plant.

**Disclaimer:**
*"Please note that the information provided is based on plant pathology analysis and should not replace professional agricultural advice. Consult with qualified agricultural experts before implementing any strategies or treatments."*

Your role is pivotal in ensuring the health and productivity of plants. Proceed to analyze the provided information or samples, adhering to the structured 
""";
    // Generate text using the GenerativeModel instance.
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
    //print(response.text);
  }
}
