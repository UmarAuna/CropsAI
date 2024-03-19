import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';

class HomeModalItem extends StatefulWidget {
  final Function() onClick;
  final String title;

  const HomeModalItem({
    Key? key,
    required this.onClick,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeModalItem> createState() => _HomeModalItemState();
}

class _HomeModalItemState extends State<HomeModalItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          border: Border.all(width: 0.8, color: AppColors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.radio_button_unchecked_rounded,
                  color: AppColors.grey,
                ),
              ],
            ),
            15.widthSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppin',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
