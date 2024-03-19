import 'package:crops_ai/disease_diagnosis/view/disease_diagnosis_page.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final nameOfDiseaseController = TextEditingController();
  final viewType = ''.obs;
  final isDiseaseNameSelected = 'disease_image'.obs;

  void goToDiseaseDiagnosisPage(BuildContext context) {
    unNamedGoTo(
        context,
        DiseaseDiagnosisPage(
          isDiseaseNameSelected: isDiseaseNameSelected.value,
          nameOfDisease: nameOfDiseaseController.text,
        ));
  }
}
