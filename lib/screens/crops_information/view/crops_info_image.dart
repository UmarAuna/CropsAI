import 'dart:io';

import 'package:crops_ai/screens/crops_information/controller/crops_information_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CropsInfoImage extends StatefulWidget {
  final CropsInformationController cropsInfoController;
  const CropsInfoImage({super.key, required this.cropsInfoController});

  @override
  State<CropsInfoImage> createState() => _CropsInfoImageState();
}

class _CropsInfoImageState extends State<CropsInfoImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightSpace,
        if (widget.cropsInfoController.photo?.path == null)
          const SizedBox()
        else
          SizedBox(
              width: 400,
              height: 250,
              child: Image.file(
                  File(widget.cropsInfoController.photo?.path ?? ''))),
        10.heightSpace,
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
