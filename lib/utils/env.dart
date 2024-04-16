import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '../crops_ai/secret.env') //Path of your secret.env file
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static String geminiApiKey = _Env.geminiApiKey;
}
