import 'dart:io';
import 'dart:typed_data';

import 'package:crops_ai/chat_input_box.dart';
import 'package:crops_ai/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

Future<void> main() async {
  /*  Gemini.init(
      apiKey: 'AIzaSyAYKMCOfCEuqTudatKKPJDx8gQ3e4VrYeM', enableDebugging: true); */

  //Gemini.reInitialize(apiKey: "ali", enableDebugging: false);
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Get.lazyPut<MainController>(() => MainController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
