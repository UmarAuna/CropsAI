import 'package:crops_ai/screens/home/modal/crop_care_modal.dart';
import 'package:crops_ai/screens/home/modal/crops_info_modal.dart';
import 'package:crops_ai/screens/home/modal/disease_diagnosis_modal.dart';
import 'package:crops_ai/screens/home/modal/harvest_prediction_modal.dart';
import 'package:crops_ai/screens/home/model/home_card_item.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:crops_ai/utils/app_vectors.dart';
import 'package:crops_ai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35.0, mainAxisSpacing: 35.0),
          itemCount: homeCardItems.length,
          itemBuilder: (context, int index) {
            final homeCardItem = homeCardItems[index];
            return InkWell(
              onTap: () {
                if (index == 0) {
                  showModalBottomSheet(
                      backgroundColor: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: const DiseaseDiagnosisModal(),
                          ),
                        );
                        /* return SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const DiseaseDiagnosisModal()); */
                      });
                } else if (index == 1) {
                  showModalBottomSheet(
                      backgroundColor: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: const CropsInformationModal(),
                          ),
                        );
                      });
                } else if (index == 2) {
                  showModalBottomSheet(
                      backgroundColor: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: const CropCareModal(),
                          ),
                        );
                      });
                } else if (index == 3) {
                  showModalBottomSheet(
                      backgroundColor: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: const HarvestPredictionModal(),
                          ),
                        );
                      });
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textColor.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 12,
                        offset: const Offset(4, 4),
                      ),
                    ],
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            homeCardItem.icon,
                            fit: BoxFit.cover,
                          ),
                          35.widthSpace,
                          SvgPicture.asset(AppVectors.iconArrowRight,
                              semanticsLabel: 'arrow icon'),
                        ],
                      ),
                      12.heightSpace,
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(homeCardItem.title,
                            style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppin',
                                color: AppColors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
