import 'package:crops_ai/screens/crop_care/view/crop_care_page.dart';
import 'package:crops_ai/screens/crops_information/view/crops_information_page.dart';
import 'package:crops_ai/screens/disease_diagnosis/view/disease_diagnosis_page.dart';
import 'package:crops_ai/screens/home/view/home_page.dart';
import 'package:crops_ai/screens/home/view/splash_screen_page.dart';
import 'package:crops_ai/screens/home/widget/page_loader.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreenPage.id: (context) => const SplashScreenPage(),
  HomePage.id: (context) => const HomePage(),
  PageLoader.id: (context) => const PageLoader(),
  DiseaseDiagnosisPage.id: (context) => const DiseaseDiagnosisPage(),
  CropsInformationPage.id: (context) => const CropsInformationPage(),
  CropCarePage.id: (context) => const CropCarePage(),
};
