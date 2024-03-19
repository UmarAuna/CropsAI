import 'package:crops_ai/disease_diagnosis/view/disease_diagnosis_page.dart';
import 'package:crops_ai/home/view/home_page.dart';
import 'package:crops_ai/home/view/splash_screen_page.dart';
import 'package:crops_ai/home/widget/page_loader.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreenPage.id: (context) => const SplashScreenPage(),
  HomePage.id: (context) => const HomePage(),
  PageLoader.id: (context) => const PageLoader(),
  DiseaseDiagnosisPage.id: (context) => const DiseaseDiagnosisPage(),
};
