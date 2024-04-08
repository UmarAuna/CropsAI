import 'dart:io';

import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 75,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

showToast(
  String message, {
  ToastGravity gravity = ToastGravity.CENTER,
  Toast length = Toast.LENGTH_LONG,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: length,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.primaryColor,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}

void showToastBottom(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.primaryColor,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}

showToastification(String title, String description,
    {ToastificationType type = ToastificationType.error}) {
  final BuildContext context = Get.overlayContext!;
  /* if (context == null) {
    return;
  } */
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.fillColored,
    title: Text(title),
    description: Text(description),
    alignment: Alignment.topRight,
    autoCloseDuration: const Duration(seconds: 4),
    boxShadow: lowModeShadow,
    showProgressBar: false,
    dragToClose: true,
  );
}

Future<void> goTo(BuildContext context, String screen,
    {Object? arguments}) async {
  try {
    await Navigator.pushNamed(
      context,
      screen,
      arguments: arguments,
    );
  } catch (e) {
    log.e('Navigation Error: ${e.toString()}');
  }
}

Future unNamedGoTo(BuildContext context, Widget screen) async {
  try {
    return await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => screen),
    );
  } catch (e) {
    log.e('Navigation Error: ${e.toString()}');
  }
}

void goBack(BuildContext context, {int count = 1}) {
  try {
    for (var i = 1; i <= count; i++) {
      Navigator.pop(context);
    }
  } catch (e) {
    log.e('Navigation Error: ${e.toString()}');
  }
}

void popThenGoTo(BuildContext context, String screen,
    {Object? arguments, int count = 1}) {
  try {
    goBack(context, count: count);
    goTo(context, screen, arguments: arguments);
  } catch (e) {
    log.e('Navigation Error: ${e.toString()}');
  }
}

Future<void> copy(String text) async {
  final ClipboardData word = ClipboardData(text: text);
  await Clipboard.setData(word);
  showToast('copied to clipboard');
}

//*Anytime you type a number and call the dot operator, it will give you the option
//*to add verticalSpacer or horizontalSpacer.
extension Space on num {
  //*This replaces SizedBox(height: 12 or what spacing you want add).
  Widget get heightSpace => SizedBox(height: toDouble());
  //*This replaces SizedBox(width: 12 or what spacing you want add).
  Widget get widthSpace => SizedBox(width: toDouble());
}

class Width extends StatelessWidget {
  final double width;
  // ignore: use_key_in_widget_constructors
  const Width(this.width);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

enum Level { debug, info, warning, error, wtf }

void logDebug(String message, {Level level = Level.info}) {
  if (kDebugMode) {
    switch (level) {
      case Level.debug:
        log.d(message);
        break;
      case Level.info:
        log.i(message);
        break;
      case Level.warning:
        log.w(message);
        break;
      case Level.error:
        log.e(message);
        break;
      default:
        log.d(message);
    }
  }
}

Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return Future.value(true);
    }
  } on SocketException catch (_) {
    return Future.value(false);
  }
  return false;
}

Future<void> openLink(String link) async {
  final url = Uri.parse(link);

  try {
    await launchUrl(
      url,
    );
  } catch (e) {
    logDebug('Error launching url.', level: Level.error);
  }
}
