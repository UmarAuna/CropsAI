import 'package:crops_ai/screens/harvest_prediction/controller/harvest_prediction_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HarvestPredictionText extends StatefulWidget {
  final HarvestPredictionController harvestPredictionController;
  const HarvestPredictionText(
      {super.key, required this.harvestPredictionController});

  @override
  State<HarvestPredictionText> createState() => _HarvestPredictionTextState();
}

class _HarvestPredictionTextState extends State<HarvestPredictionText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.heightSpace,
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
