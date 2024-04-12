import 'package:crops_ai/utils/env.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AppConfig {
  AppConfig._(); // ! Private constructor to prevent instantiation

  //static const apiKey = 'AIzaSyAYKMCOfCEuqTudatKKPJDx8gQ3e4VrYeM';
  static final apiKey = Env.geminiApiKey;

  static final generationConfig = GenerationConfig(
    //stopSequences: ["red"],
    // for now gemini-pro seems to support only one candidate
    candidateCount: 1,
    maxOutputTokens: 12096,
    temperature: 0.4,
    topP: 0.1,
    topK: 32,
  );

  static final safetySettings = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
  ];
}
