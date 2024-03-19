import 'package:crops_ai/utils/app_vectors.dart';

class HomeCardItem {
  final String title;
  final String icon;
  //final Color cardColor;
  const HomeCardItem(
      {required this.title,
      required this.icon /* , required this.cardColor */});
}

const List<HomeCardItem> homeCardItems = <HomeCardItem>[
  HomeCardItem(
    title: 'Disease\nDiagnosis',
    icon: AppVectors
        .iconDiseaseDiagnosis, /* cardColor: AppColors.diseaseDiagnosisColor */
  ),
  HomeCardItem(
    title: 'Crop\nInformation',
    icon: AppVectors
        .iconCropInformation, /* cardColor: AppColors.propheticSayingsColor */
  ),
  HomeCardItem(
    title: 'Crop\nCare',
    icon: AppVectors.iconCropCare, /* cardColor: AppColors.shareAppColor */
  ),
  HomeCardItem(
    title: 'Harvest\nPrediction',
    icon: AppVectors
        .iconHarvestPrediction, /* cardColor: AppColors.aboutAppColor */
  )
];
