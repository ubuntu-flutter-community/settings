import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/utils.dart';
import 'package:yaru_colors/yaru_colors.dart';
import 'package:yaru_icons/yaru_icons.dart';

extension PowerProfileX on PowerProfile {
  String localize(AppLocalizations l10n) {
    switch (this) {
      case PowerProfile.performance:
        return l10n.powerProfilePerformance;
      case PowerProfile.balanced:
        return l10n.powerProfileBalanced;
      case PowerProfile.powerSaver:
        return l10n.powerProfilePowerSaver;
    }
  }

  String localizeDescription(AppLocalizations l10n) {
    switch (this) {
      case PowerProfile.performance:
        return l10n.powerProfilePerformanceDescription;
      case PowerProfile.balanced:
        return l10n.powerProfileBalancedDescription;
      case PowerProfile.powerSaver:
        return l10n.powerProfilePowerSaverDescription;
    }
  }

  IconData getIcon() {
    switch (this) {
      case PowerProfile.performance:
        return YaruIcons.meter_5;
      case PowerProfile.balanced:
        return YaruIcons.meter_3;
      case PowerProfile.powerSaver:
        return YaruIcons.meter_1;
    }
  }

  Color getColor(bool light) {
    switch (this) {
      case PowerProfile.performance:
        return light ? YaruColors.red : lighten(YaruColors.red, 30);
      case PowerProfile.balanced:
        return light ? YaruColors.inkstone : YaruColors.porcelain;
      case PowerProfile.powerSaver:
        return light ? YaruColors.success : lighten(YaruColors.success, 30);
    }
  }
}
