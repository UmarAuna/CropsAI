import 'package:crops_ai/screens/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/diagnosis_image.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/diagnosis_pest.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/diagnosis_text.dart';
import 'package:crops_ai/screens/home/widget/page_loader.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
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
    } else if (widget.isDiseaseNameSelected == 'disease_image') {
      diseaseDiagnoseController.getDiseaseDiagnosisImage();
    } else {
      diseaseDiagnoseController.getPestDiagnosisImage();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: LayoutBuilder(builder: (context, constraints) {
          if (widget.isDiseaseNameSelected == 'disease_text') {
            return Obx(() {
              return diseaseDiagnoseController.loading.value
                  ? const PageLoader()
                  : WillPopScope(
                      onWillPop: () async {
                        diseaseDiagnoseController.responseText.value = '';
                        goBack(context);
                        return true;
                      },
                      child: DiagnosisText(
                          diseaseDiagnosisController:
                              diseaseDiagnoseController),
                    );
            });
          } else if (widget.isDiseaseNameSelected == 'disease_image') {
            return Obx(() {
              return diseaseDiagnoseController.loading.value
                  ? const PageLoader()
                  : WillPopScope(
                      onWillPop: () async {
                        diseaseDiagnoseController.responseText.value = '';
                        diseaseDiagnoseController.photo = null;
                        goBack(context);
                        return true;
                      },
                      child: DiagnosisImage(
                          diseaseDiagnosisController:
                              diseaseDiagnoseController),
                    );
            });
          } else {
            return Obx(() {
              return diseaseDiagnoseController.loading.value
                  ? const PageLoader()
                  : WillPopScope(
                      onWillPop: () async {
                        diseaseDiagnoseController.responseText.value = '';
                        diseaseDiagnoseController.photo = null;
                        goBack(context);
                        return true;
                      },
                      child: DiagnosisPest(
                          diseaseDiagnosisController:
                              diseaseDiagnoseController),
                    );
            });
          }
        })
/*  widget.isDiseaseNameSelected == 'disease_text'
            ? diseaseDiagnoseController.loading.value
                ? const PageLoader()
                : WillPopScope(
                    onWillPop: () async {
                      diseaseDiagnoseController.responseText.value = '';
                      goBack(context);
                      return true;
                    },
                    child: DiagnosisText(
                        diseaseDiagnosisController: diseaseDiagnoseController),
                  )
            : diseaseDiagnoseController.loading.value
                ? const PageLoader()
                : WillPopScope(
                    onWillPop: () async {
                      diseaseDiagnoseController.responseText.value = '';
                      diseaseDiagnoseController.photo = null;
                      goBack(context);
                      return true;
                    },
                    child: DiagnosisImage(
                        diseaseDiagnosisController: diseaseDiagnoseController),
                  ), */
        );
  }
}
