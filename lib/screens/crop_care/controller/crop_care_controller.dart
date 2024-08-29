import 'dart:io';

import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_config.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class CropCareController extends GetxController {
  final responseText = ''.obs;
  final loading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  Future<void> getCropCareImage() async {
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
As a highly skilled farmer Please, Identify the name of the crop in the image and help me with information about growing, duration, and care for the crop, you will give me relevant disclaimers at the end, and you will give me detailed information following this guidelines:

**Guidelines:**

**Crop name:** Provide name of crop with emoji if any found

**Growth cycle:** What to expect at different stages of the crop's growth.

**Duration:** How long it takes for the crop to mature.

**Care practices:** Watering, fertilization, pest control, and other necessary care practices.

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

  Future<String> getCropCareText(String nameOfCrop) async {
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
As a highly skilled farmer Please help me with information about growing, duration, and care practices for $nameOfCrop. I will provide you with the name of the crop am interested in, you will give me relevant disclaimers at the end, and you will give me detailed information following this guidelines:

**Guidelines:**

**Crop name:** Provide name of crop with emoji if any found

**Growth cycle:** What to expect at different stages of the crop's growth.

**Duration:** How long it takes for the crop to mature.

**Care practices:** Watering, fertilization, pest control, and other necessary care practices.

**Links:** Get recent and relevant links that will help the farmer.

**Disclaimer:**
  *"Please note that the information provided is based on general agricultural knowledge and should not replace professional agricultural advice. Consult with qualified agricultural experts for specific recommendations considering local conditions."*
""";
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
