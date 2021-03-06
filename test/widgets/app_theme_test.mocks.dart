// Mocks generated by Mockito 5.0.16 from annotations
// in settings/test/widgets/app_theme_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:ui' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:settings/services/settings_service.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [Settings].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettings extends _i1.Mock implements _i2.Settings {
  MockSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void addListener(_i3.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i3.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  bool? boolValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#boolValue, [key])) as bool?);
  @override
  int? intValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#intValue, [key])) as int?);
  @override
  double? doubleValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#doubleValue, [key])) as double?);
  @override
  String? stringValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#stringValue, [key])) as String?);
  @override
  Iterable<String>? stringArrayValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#stringArrayValue, [key]))
          as Iterable<String>?);
  @override
  T? getValue<T>(String? key) =>
      (super.noSuchMethod(Invocation.method(#getValue, [key])) as T?);
  @override
  _i4.Future<void> setValue<T>(String? key, T? value) =>
      (super.noSuchMethod(Invocation.method(#setValue, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> resetValue(String? key) =>
      (super.noSuchMethod(Invocation.method(#resetValue, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}
