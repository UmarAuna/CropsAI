import 'package:crops_ai/screens/crops_information/controller/crops_information_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CropsInfoText extends StatefulWidget {
  final CropsInformationController cropsInfoController;
  const CropsInfoText({super.key, required this.cropsInfoController});

  @override
  State<CropsInfoText> createState() => _CropsInfoTextState();
}

class _CropsInfoTextState extends State<CropsInfoText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.heightSpace,
        Expanded(
          child: Markdown(
            selectable: true,
            data: widget.cropsInfoController.responseText.value,
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
