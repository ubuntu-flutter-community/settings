import 'package:flutter/material.dart';
import 'package:settings/view/widgets/master_detail_utils.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Detail Page"),
        leading: isTablet(context) ? null : const BackButton(),
      ),
      body: Center(
        child: Text("Detail Page : $item "),
      ),
      // floatingActionButton: isTablet(context)
      //     ? null
      //     : FloatingActionButton(
      //         onPressed: Navigator.of(context).pop,
      //         child: const Icon(Icons.arrow_back),
      //       ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
