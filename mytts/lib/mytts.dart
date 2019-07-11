import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Mytts {
  static const MethodChannel _channel = const MethodChannel('mytts');
  VoidCallback initHandler;
  VoidCallback startHandler;
  VoidCallback completionHandler;
  Function errorHandler;
  Mytts() {
    _channel.setMethodCallHandler(platformCallHandler);
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> isLanguageAvailable(String language) async {
    final bool languageAvailable =
        await _channel.invokeMethod('isLanguageAvailable', <String, Object>{'language': language});
    return languageAvailable;
  }

  static Future<bool> setLanguage(String language) async {
    final bool isSet = await _channel.invokeMethod('setLanguage', <String, Object>{'language': language});
    return isSet;
  }

  static Future<List<String>> getAvailableLanguages() =>
      _channel.invokeMethod('getAvailableLanguages').then((result) => result.cast<String>());

  static void speak(String text) => _channel.invokeMethod('speak', <String, Object>{'text': text});

  static void stop() async {
    _channel.invokeMethod('stop');
  }

  static void shutdown() async {
    _channel.invokeMethod('shutdown');
  }

  static void setSpeechRate(double rate) async {
    _channel.invokeMethod('setSpeechRate', <String, Object>{'rate': rate.toString()});
  }

  void setStartHandler(VoidCallback callback) {
    startHandler = callback;
  }

  void setCompletionHandler(VoidCallback callback) {
    completionHandler = callback;
  }

  void setErrorHandler(VoidCallback handler) {
    errorHandler = handler;
  }

  void ttsInitHandler(VoidCallback handler) {
    initHandler = handler;
  }

  Future platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "tts.init":
        if (initHandler != null) {
          initHandler();
        }
        break;
      case "speak.onStart":
        if (startHandler != null) {
          startHandler();
        }
        break;
      case "speak.onComplete":
        if (completionHandler != null) {
          completionHandler();
        }
        break;
      case "speak.onError":
        if (errorHandler != null) {
          errorHandler(call.arguments);
        }
        break;
      default:
        print('Unknowm method ${call.method}');
    }
  }
}
