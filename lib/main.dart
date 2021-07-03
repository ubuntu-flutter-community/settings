import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/master_detail_container.dart';
import 'package:yaru/yaru.dart' as yaru;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ubuntu settings',
      home: const MasterDetailContainer(),
      theme: yaru.lightTheme,
      darkTheme: yaru.darkTheme,
    );
  }
}
