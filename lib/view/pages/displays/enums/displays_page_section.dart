import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';

enum DisplaysPageSection {
  displays,
  night,
}

extension DisplaysPageSectionExtension on DisplaysPageSection {
  String name(BuildContext context) {
    switch(this){
      case DisplaysPageSection.displays:
        return context.l10n.displays;
      case DisplaysPageSection.night:
        return context.l10n.nightMode;
      default:
        return '';
    }

  }
}
