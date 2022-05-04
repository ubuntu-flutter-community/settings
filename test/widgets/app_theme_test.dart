import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/app_theme.dart';
import 'package:yaru/yaru.dart';
import 'app_theme_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Settings])
void main() {
  test(
    'App Theme Dark Mode Test',
    () {
      Settings settings = MockSettings();
      AppTheme theme = AppTheme(settings);

      when(settings.setValue('gtk-theme', 'Yaru-dark')).thenAnswer(
        (realInvocation) async {},
      );

      theme.apply(Brightness.dark, YaruVariant.orange);
      verify(settings.setValue('gtk-theme', 'Yaru-dark')).called(1);
    },
  );

  test(
    'App Theme Light Mode Test',
    () {
      Settings settings = MockSettings();
      AppTheme theme = AppTheme(settings);

      when(settings.setValue('gtk-theme', 'Yaru')).thenAnswer(
        (realInvocation) async {},
      );

      theme.apply(Brightness.light, YaruVariant.orange);
      verify(settings.setValue('gtk-theme', 'Yaru')).called(1);
    },
  );
}
