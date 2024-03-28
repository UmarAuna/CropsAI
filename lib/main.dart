import 'dart:io';

import 'package:crops_ai/screens/crop_care/controller/crop_care_controller.dart';
import 'package:crops_ai/screens/crops_information/controller/crops_information_controller.dart';
import 'package:crops_ai/screens/disease_diagnosis/controller/disease_diagnosis_controller.dart';
import 'package:crops_ai/screens/harvest_prediction/controller/harvest_prediction_controller.dart';
import 'package:crops_ai/screens/home/controller/home_controller.dart';
import 'package:crops_ai/screens/home/view/home_page.dart';
import 'package:crops_ai/main_controller.dart';
import 'package:crops_ai/routes.dart';
import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Get.lazyPut<MainController>(() => MainController());
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
            home: const HomePage(),
            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
            //home: const SplashScreenPage(), *TODO @Umar undo this
            initialRoute: HomePage.id,
            routes: routes,
            /* initialRoute: SplashScreenPage.id,
              routes: routes, */
          ),
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mainController = Get.put<MainController>(MainController());
  @override
  void initState() {
    super.initState();
    //mainController.generateText();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton(
            onPressed: () {
              //mainController.generateText();
              mainController.generateImage();
            },
            child: const Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
            //title: const Text('Back'),
            ),
        body: SafeArea(
          child: mainController.loading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    if (mainController.photo?.path == null)
                      const SizedBox()
                    else
                      SizedBox(
                          width: 400,
                          height: 250,
                          child: Image.file(
                              File(mainController.photo?.path ?? ''))),
                    Expanded(
                      child: Markdown(
                        selectable: true,
                        data: mainController.responseText.value,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
/* class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker picker = ImagePicker();
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result, _finishReason;
  bool _loading = false;

  String? get finishReason => _finishReason;
  bool get loading => _loading;

  Uint8List? selectedImage;

  set finishReason(String? set) {
    if (set != _finishReason) {
      setState(() => _finishReason = set);
    }
  }

  set loading(bool set) {
    if (set != loading) {
      setState(() => _loading = set);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: const Text('Back'),
          ),
      body: SafeArea(
        child: Column(
          children: [
            if (searchedText != null)
              MaterialButton(
                  color: Colors.blue.shade700,
                  onPressed: () {
                    setState(() {
                      searchedText = null;
                      result = null;
                    });
                  },
                  child: Text('search: $searchedText')),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: loading
                          //? Lottie.asset('assets/lottie/ai.json')
                          ? const SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator())
                          : result != null
                              ? Markdown(
                                  data: result!,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                )
                              : const Center(
                                  child: Text('Search something!'),
                                ),
                    ),
                    if (selectedImage != null)
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.memory(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            ChatInputBox(
              controller: controller,
              onClickCamera: () async {
                // Capture a photo.
                final XFile? photo =
                    await picker.pickImage(source: ImageSource.camera);

                if (photo != null) {
                  photo.readAsBytes().then((value) => setState(() {
                        selectedImage = value;
                      }));
                }
              },
              onSend: () {
                if (controller.text.isNotEmpty && selectedImage != null) {
                  searchedText = controller.text;
                  controller.clear();
                  loading = true;

                  gemini.textAndImage(
                      text: searchedText!,
                      images: [selectedImage!]).then((value) {
                    result = value?.content?.parts?.last.text;
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
} */
