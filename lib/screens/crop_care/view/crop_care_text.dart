import 'package:crops_ai/screens/crop_care/controller/crop_care_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CropCareText extends StatefulWidget {
  final CropCareController cropCareController;
  const CropCareText({super.key, required this.cropCareController});

  @override
  State<CropCareText> createState() => _CropCareTextState();
}

class _CropCareTextState extends State<CropCareText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.heightSpace,
        Expanded(
          child: Markdown(
            selectable: true,
            data: widget.cropCareController.responseText.value,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            onTapLink: (text, href, title) {
              if (href != null) {
                openLink(href);
              }
            },
          ),
        ),
        10.heightSpace,
      ],
    );
  }
}
