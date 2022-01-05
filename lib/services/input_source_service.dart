import 'dart:io';

import 'package:xml/xml.dart';

class InputSourceService {
  static const pathToXml = '/usr/share/X11/xkb/rules/base.xml';
  late final List<InputSource> inputSources;

  InputSourceService() {
    inputSources = _loadInputSources();
  }

  List<InputSource> _loadInputSources() {
    final document = XmlDocument.parse(File(pathToXml).readAsStringSync());

    final layouts = document.findAllElements('layout');
    return layouts
        .map(
          (layout) => InputSource(
              variants: layout.getElement('variantList') != null
                  ? layout
                      .getElement('variantList')!
                      .childElements
                      .map((variant) => InputSourceVariant(
                            name: variant
                                .getElement('configItem')!
                                .getElement('name')!
                                .innerText,
                            description: variant
                                .getElement('configItem')!
                                .getElement('description')!
                                .innerText,
                          ))
                      .toList()
                  : [],
              description: layout
                  .getElement('configItem')
                  ?.getElement('description')
                  ?.innerText,
              name: layout
                  .getElement('configItem')
                  ?.getElement('name')
                  ?.innerText),
        )
        .toList();
  }
}

class InputSource {
  final String? name;
  final String? description;
  final List<InputSourceVariant> variants;

  InputSource({this.name, this.description, required this.variants});
}

class InputSourceVariant {
  final String? name;
  final String? description;

  InputSourceVariant({this.name, this.description});
}
