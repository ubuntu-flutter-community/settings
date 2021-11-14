import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsettings/gsettings.dart';
import 'package:mockito/annotations.dart';
import 'package:settings/view/app_theme.dart';
import 'app_theme_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GSettings])
void main() {
  test(
    'App Theme Dark Mode Test',
    () {
      GSettings settings = MockGSettings();
      AppTheme theme = AppTheme(settings);

      when(settings.setValue('gtk-theme', 'Yaru-dark')).thenAnswer(
        (realInvocation) => true,
      );

      theme.apply(Brightness.dark);
      verify(settings.setValue('gtk-theme', 'Yaru-dark')).called(1);
    },
  );

  test(
    'App Theme Light Mode Test',
    () {
      GSettings settings = MockGSettings();
      AppTheme theme = AppTheme(settings);

      when(settings.setValue('gtk-theme', 'Yaru')).thenAnswer(
        (realInvocation) => true,
      );

      theme.apply(Brightness.light);
      verify(settings.setValue('gtk-theme', 'Yaru')).called(1);
    },
  );
}
