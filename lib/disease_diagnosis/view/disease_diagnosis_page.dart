import 'package:crops_ai/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/disease_diagnosis/view/diagnosis_image.dart';
import 'package:crops_ai/disease_diagnosis/view/diagnosis_text.dart';
import 'package:crops_ai/home/widget/page_loader.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseDiagnosisPage extends StatefulWidget {
  static const id = 'disease_diagnosis_page';
  final String? isDiseaseNameSelected;
  final String? nameOfDisease;
  const DiseaseDiagnosisPage(
      {super.key, this.isDiseaseNameSelected, this.nameOfDisease});

  @override
  State<DiseaseDiagnosisPage> createState() => _DiseaseDiagnosisPageState();
}

class _DiseaseDiagnosisPageState extends State<DiseaseDiagnosisPage> {
  final diseaseDiagnoseController =
      Get.put<DiseaseDiagnosisController>(DiseaseDiagnosisController());

  @override
  void initState() {
    super.initState();
    if (widget.isDiseaseNameSelected == 'disease_text') {
      diseaseDiagnoseController
          .getDiseaseDiagnosisText(widget.nameOfDisease ?? '');
    } else {
      diseaseDiagnoseController.getDiseaseDiagnosisImage();
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
              widget.nameOfDisease != ''
                  ? widget.nameOfDisease ?? ''
                  : 'About this disease',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.white,
                  fontFamily: 'Poppins')),
          centerTitle: true,
        ),
        body: widget.isDiseaseNameSelected == 'disease_text'
            ? diseaseDiagnoseController.loading.value
                ? const PageLoader()
                : DiagnosisText(
                    diseaseDiagnosisController: diseaseDiagnoseController)
            : diseaseDiagnoseController.loading.value
                ? const PageLoader()
                : DiagnosisImage(
                    diseaseDiagnosisController: diseaseDiagnoseController),
      );
    });
  }
}
