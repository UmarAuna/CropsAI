import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxService {
  final GetStorage _box = GetStorage();

  static const isFirstTime = 'isFirstTime';

  Future<void> clearAllData() async {
    await _box.remove(isFirstTime);
  }

  Future<StorageServices> init() async {
    return this;
  }

  void setIsFirstTime(bool value) {
    saveBoolean(isFirstTime, value);
  }

  bool? getIsFirstTime() {
    final value = readBoolean(isFirstTime);
    return value;
  }

  Future<void> clearData(String key) async {
    await _box.remove(key);
    //await _box.remove(_keyUId);
  }

  Future<void> saveBoolean(String key, bool value) async {
    await _box.write(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    await _box.write(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    await _box.write(key, value);
  }

  Future<void> saveString(String key, String value) async {
    await _box.write(key, value);
  }

  bool readBoolean(String key) {
    final value = _box.read(key);
    return value is bool ? value : false;
  }

  int readInt(String key) {
    final value = _box.read(key);
    return value is int ? value : -1;
  }

  int readIntReturnZero(String key) {
    final value = _box.read(key);
    return value is int ? value : 0;
  }

  //double myDoubleValue = _readDouble('someDoubleKey');
  double readDouble(String key) {
    final value = _box.read(key);
    return value is double
        ? value
        : -1.0; // Default to -1.0 if the value is not a double
  }

  String? readString(String key) {
    final value = _box.read(key);
    return value is String ? value : null;
  }

  void saveJson(String key, Map<String, dynamic> value) async {
    await _box.write(key, value);
  }

  Map<String, dynamic>? readJson(String key) {
    final value = _box.read(key);
    return value is Map<String, dynamic> ? value : null;
  }
}
