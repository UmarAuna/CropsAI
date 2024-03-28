import 'package:crops_ai/screens/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DiagnosisText extends StatefulWidget {
  final DiseaseDiagnosisController diseaseDiagnosisController;
  const DiagnosisText({super.key, required this.diseaseDiagnosisController});

  @override
  State<DiagnosisText> createState() => _DiagnosisTextState();
}

class _DiagnosisTextState extends State<DiagnosisText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.heightSpace,
        Expanded(
          child: Markdown(
            selectable: true,
            data: widget.diseaseDiagnosisController.responseText.value,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        10.heightSpace,
      ],
    );
  }
}
