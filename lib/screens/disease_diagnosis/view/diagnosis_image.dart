import 'dart:io';

import 'package:crops_ai/screens/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DiagnosisImage extends StatefulWidget {
  final DiseaseDiagnosisController diseaseDiagnosisController;
  const DiagnosisImage({super.key, required this.diseaseDiagnosisController});

  @override
  State<DiagnosisImage> createState() => _DiagnosisImageState();
}

class _DiagnosisImageState extends State<DiagnosisImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightSpace,
        if (widget.diseaseDiagnosisController.photo?.path == null)
          const SizedBox()
        else
          SizedBox(
              width: 400,
              height: 250,
              child: Image.file(
                  File(widget.diseaseDiagnosisController.photo?.path ?? ''))),
        10.heightSpace,
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
