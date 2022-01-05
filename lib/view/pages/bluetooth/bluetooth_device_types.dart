import 'package:flutter/material.dart';
import 'package:yaru_icons/yaru_icons.dart';

class BluetoothDeviceTypes {
  static const map = <int, String>{
    0: 'unknown',
    64: 'generic phone',
    128: 'generic computer',
    192: 'generic watch',
    193: 'watch sports watch',
    256: 'generic clock',
    320: 'generic display',
    384: 'generic remote control',
    448: 'generic eye glasses',
    512: 'generic tag',
    576: 'generic keyring',
    640: 'generic media player',
    704: 'generic barcode scanner',
    768: 'generic thermometer',
    769: 'thermometer ear',
    832: 'generic heart rate sensor',
    833: 'heart rate sensor heart rate belt ',
    896: 'generic blood pressure',
    897: 'blood pressure arm',
    898: 'blood pressure wrist',
    960: 'generic hid',
    961: 'hid keyboard',
    962: 'hid mouse',
    963: 'hid joystick',
    964: 'hid gamepad',
    965: 'hid digitizersubtype',
    966: 'hid card reader',
    967: 'hid digital pen',
    968: 'hid barcode',
    1024: 'generic glucose meter',
    1088: 'generic running walking sensor',
    1089: 'running walking sensor in shoe',
    1090: 'running walking sensor on shoe',
    1091: 'running walking sensor on hip',
    1152: 'generic cycling',
    1153: 'cycling cycling computer',
    1154: 'cycling speed sensor',
    1155: 'cycling cadence sensor',
    1156: 'cycling power sensor',
    1157: 'cycling speed cadence sensor',
    3136: 'generic pulse oximeter',
    3137: 'pulse oximeter fingertip',
    3138: 'pulse oximeter wrist worn',
    3200: 'generic weight scale',
    5184: 'generic outdoor sports act',
    5185: 'outdoor sports act loc disp',
    5186: 'outdoor sports act loc and nav disp',
    5187: 'outdoor sports act loc pod',
    5188: 'outdoor sports act loc and nav pod',
  };

  static bool isMouse(int appearanceCode) =>
      appearanceCode == 962 ? true : false;

  static bool isKeyboard(int appearanceCode) =>
      appearanceCode == 961 ? true : false;

  static bool isGamePad(int appearanceCode) =>
      appearanceCode == 964 ? true : false;

  static bool isJoyStick(int appearanceCode) =>
      appearanceCode == 963 ? true : false;

  static bool isMediaPlayer(int appearanceCode) =>
      appearanceCode == 640 ? true : false;

  static IconData getIconForAppearanceCode(int appearanceCode) {
    if (isMouse(appearanceCode)) {
      return YaruIcons.input_mouse;
    } else if (isKeyboard(appearanceCode)) {
      return YaruIcons.input_keyboard;
    } else if (isGamePad(appearanceCode) || isJoyStick(appearanceCode)) {
      return YaruIcons.input_gaming;
    } else if (isMediaPlayer(appearanceCode)) {
      return YaruIcons.headphones;
    } else {}

    return YaruIcons.question;
  }
}
