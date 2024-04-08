import 'dart:io';

import 'package:crops_ai/screens/crop_care/controller/crop_care_controller.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CropCareImage extends StatefulWidget {
  final CropCareController cropCareController;
  const CropCareImage({super.key, required this.cropCareController});

  @override
  State<CropCareImage> createState() => _CropCareImageState();
}

class _CropCareImageState extends State<CropCareImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightSpace,
        if (widget.cropCareController.photo?.path == null)
          const SizedBox()
        else
          SizedBox(
              width: 400,
              height: 250,
              child: Image.file(
                  File(widget.cropCareController.photo?.path ?? ''))),
        10.heightSpace,
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
