import 'dart:io';

import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_config.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class DiseaseDiagnosisController extends GetxController {
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

  Future<void> getPestDiagnosisImage() async {
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
As a highly skilled farmer please Identify the pest in the image, the name of the pest, identification, Prevention, Treatment, Recommended pesticides and offer recommendations and give me relevant disclaimers at the end following this guidelines:
 
 **Guidelines:**

 **Name of Pest:** Provide name of pest with emoji if any found

 **Identification:** Detailed information about the pest or disease, including its appearance, behavior, and damage.

 **Affected crops:** What types of Crops does this pest affect?

 **Prevention:** Tips for preventing the pest or disease from affecting your crop.

 **Treatment:** Effective methods for getting rid of the pest or disease.

 **Recommended pesticides:** Information about suitable pesticides for the specific pest or disease, including organic options.

 **Other relevant information:** Is there any other information that might be helpful in killing the pest, or the use of any chemicals or fertilizers?
 
 **Disclaimer:**
  *"Please note that the information provided is based on plant pathology analysis and should not replace professional agricultural advice. Consult with qualified agricultural experts before implementing any strategies or treatments."*
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
      //responseText.value = 'message: ${e.toString()}';
      responseText.value = 'Error generating text';
    }

    //print(response.text);
  }

  Future<void> getDiseaseDiagnosisImage() async {
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
As a highly skilled farmer please Identify and diagnose the crop infected in the crop image, the name of the disease infected and provide me with the most information you have about the following? You will be provided with information or samples related to crop diseases, and your role involves conducting a detailed analysis to identify specific issues, propose solutions, and offer recommendations and give me relevant disclaimers at the end following this guidelines:

**Guidelines:**

 **Crop name:** Provide name of crop infected.

 **Crop type:** What type of crop is infected?

**Disease name:** Provide name of disease with emoji if any found

**Disease type:** What type of crop disease is it?

**Affected crops:** What types of Crops does this disease affect?

**Symptoms:** What are the visible symptoms of the infected crop and potential causes?

**Disease Identification:** Examine the provided information or samples to identify and characterize plant diseases accurately.

**Environmental factors:** What are the environmental conditions where the crop is growing?

**Recent history:** Have there been any recent changes to the environment or farming practices?

**Treatment and Recommendations:** Offer informed treatment and recommendations for maintaining plant health, preventing disease spread, and optimizing overall plant well-being.

**Other relevant information:** Is there any other information that might be helpful in diagnosing the disease, such as the presence of pests or diseases, or the use of any chemicals or fertilizers?

**Follow-Up and Monitoring:** Advise farmers to monitor the treated crops regularly and assess the effectiveness of the implemented strategies. Encourage proactive measures to prevent disease recurrence and maintain crop health.

**Disclaimer:**
  *"Please note that the information provided is based on plant pathology analysis and should not replace professional agricultural advice. Consult with qualified agricultural experts before implementing any strategies or treatments."*
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
      //responseText.value = 'message: ${e.toString()}';
      responseText.value = 'Error generating text';
    }

    //print(response.text);
  }

  Future<String> getDiseaseDiagnosisText(String disease) async {
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
      return 'No Internet Connection';
    }

    final inputPrompt = """
As a highly skilled farmer please diagnose crops infected with this $disease; could you provide me with the most information you have about the following? You will be provided with information or samples related to crop diseases, and your role involves conducting a detailed analysis to identify specific issues, propose solutions, and offer recommendations and give me relevant disclaimers at the end following this guidelines:

**Guidelines:**

**Disease name:** Provide name of disease with emoji if any found

**Disease type:** What type of crop disease is it?

**Affected crops:** What types of Crops does this disease affect?

**Symptoms:** What are the visible symptoms of the infected crop and potential causes?

**Disease Identification:** Examine the provided information or samples to identify and characterize plant diseases accurately.

**Environmental factors:** What are the environmental conditions where the crop is growing?

**Recent history:** Have there been any recent changes to the environment or farming practices?

**Treatment and Recommendations:** Offer informed treatment and recommendations for maintaining plant health, preventing disease spread, and optimizing overall plant well-being.

**Other relevant information:** Is there any other information that might be helpful in diagnosing the disease, such as the presence of pests or diseases, or the use of any chemicals or fertilizers?

**Follow-Up and Monitoring:** Advise farmers to monitor the treated crops regularly and assess the effectiveness of the implemented strategies. Encourage proactive measures to prevent disease recurrence and maintain crop health.

**Disclaimer:**
  *"Please note that the information provided is based on plant pathology analysis and should not replace professional agricultural advice. Consult with qualified agricultural experts before implementing any strategies or treatments."*
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
