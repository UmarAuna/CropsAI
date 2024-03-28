import 'dart:io';

import 'package:crops_ai/screens/harvest_prediction/controller/harvest_prediction_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HarvestPredictionImage extends StatefulWidget {
  final HarvestPredictionController harvestPredictionController;
  const HarvestPredictionImage(
      {super.key, required this.harvestPredictionController});

  @override
  State<HarvestPredictionImage> createState() => _HarvestPredictionImageState();
}

class _HarvestPredictionImageState extends State<HarvestPredictionImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightSpace,
        if (widget.harvestPredictionController.photo?.path == null)
          const SizedBox()
        else
          SizedBox(
              width: 400,
              height: 250,
              child: Image.file(
                  File(widget.harvestPredictionController.photo?.path ?? ''))),
        10.heightSpace,
        Expanded(
          child: Markdown(
            selectable: true,
            data: widget.harvestPredictionController.responseText.value,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        10.heightSpace,
      ],
    );
  }
}
