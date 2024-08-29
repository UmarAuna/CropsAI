import 'package:crops_ai/screens/crop_care/controller/crop_care_controller.dart';
import 'package:crops_ai/screens/crops_information/controller/crops_information_controller.dart';
import 'package:crops_ai/screens/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/screens/harvest_prediction/controller/harvest_prediction_controller.dart';
import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/routes.dart';
import 'package:crops_ai/screens/home/view/splash_screen_page.dart';
import 'package:crops_ai/screens/services/storage_services.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync<StorageServices>(() => StorageServices().init());
  Get.lazyPut<HomeController>(() => HomeController());
  Get.lazyPut<DiseaseDiagnosisController>(() => DiseaseDiagnosisController());
  Get.lazyPut<CropsInformationController>(() => CropsInformationController());
  Get.lazyPut<CropCareController>(() => CropCareController());
  Get.lazyPut<HarvestPredictionController>(() => HarvestPredictionController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);

            // Close the keyboard when the user clicks outside the input field
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: GetMaterialApp(
            title: 'CropsAI',
            fallbackLocale: const Locale('en_US'),
            navigatorObservers: [NavigationHistoryObserver()],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
            home: const SplashScreenPage(),
            initialRoute: SplashScreenPage.id,
            routes: routes,
            /* initialRoute: SplashScreenPage.id,
              routes: routes, */
          ),
        );
      });
    });
  }
}
