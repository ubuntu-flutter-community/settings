import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('settings/keyboard');

abstract class KeyboardService {
  Future<bool> grab();
  Future<bool> ungrab();
}

class KeyboardMethodChannel implements KeyboardService {
  @override
  Future<bool> grab() {
    return _methodChannel
        .invokeMethod<bool>('grabKeyboard')
        .then((value) => value ?? false);
  }

  @override
  Future<bool> ungrab() async {
    return _methodChannel
        .invokeMethod<bool>('ungrabKeyboard')
        .then((value) => value ?? false);
  }
}
