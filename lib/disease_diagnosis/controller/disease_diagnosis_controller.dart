import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseDiagnosisController extends GetxController {
  final responseText = ''.obs;
  final loading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  // Create a GenerativeModel instance with your API key and model name.
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyAYKMCOfCEuqTudatKKPJDx8gQ3e4VrYeM',
    generationConfig: generationConfig,
    safetySettings: safetySettings,
  );

  final visionModel = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: 'AIzaSyAYKMCOfCEuqTudatKKPJDx8gQ3e4VrYeM',
    generationConfig: generationConfig,
    safetySettings: safetySettings,
  );

  Future<void> getDiseaseDiagnosisImage() async {
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
    print('Image bytes: $imageBytes');
    final inputPrompt = TextPart("""
As a highly skilled plant pathologist, your expertise is indispensable in our pursuit of maintaining optimal plant health. You will be provided with information or samples related to plant diseases, and your role involves conducting a detailed analysis to identify the specific issues, propose solutions, and offer recommendations.

**Analysis Guidelines:**

1. **Disease Identification:** Examine the provided information or samples to identify and characterize plant diseases accurately.

2. **Detailed Findings:** Provide in-depth findings on the nature and extent of the identified plant diseases, including affected plant parts, symptoms, and potential causes.

3. **Next Steps:** Outline the recommended course of action for managing and controlling the identified plant diseases. This may involve treatment options, preventive measures, or further investigations.

4. **Recommendations:** Offer informed recommendations for maintaining plant health, preventing disease spread, and optimizing overall plant well-being.

5. **Important Note:** As a plant pathologist, your insights are vital for informed decision-making in agriculture and plant management. Your response should be thorough, concise, and focused on plant health.

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

  Future<String> getDiseaseDiagnosisText(String disease) async {
    final inputPrompt = """
As a highly skilled plant pathologist, your expertise is indispensable in our pursuit of maintaining optimal plant health. You will be provided with information or samples related to plant diseases $disease, and your role involves conducting a detailed analysis to identify the specific issues, propose solutions, and offer recommendations.

**Analysis Guidelines:**

1. **Disease Identification:** Examine the provided information or samples to identify and characterize plant diseases accurately.

2. **Detailed Findings:** Provide in-depth findings on the nature and extent of the identified plant diseases, including affected plant parts, symptoms, and potential causes.

3. **Next Steps:** Outline the recommended course of action for managing and controlling the identified plant diseases. This may involve treatment options, preventive measures, or further investigations.

4. **Recommendations:** Offer informed recommendations for maintaining plant health, preventing disease spread, and optimizing overall plant well-being.

5. **Important Note:** As a plant pathologist, your insights are vital for informed decision-making in agriculture and plant management. Your response should be thorough, concise, and focused on plant health.

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

final generationConfig = GenerationConfig(
  //stopSequences: ["red"],
  maxOutputTokens: 12096,
  temperature: 0.4,
  topP: 0.1,
  topK: 32,
);

final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
  SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
  SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
];
