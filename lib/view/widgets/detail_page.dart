import 'package:flutter/material.dart';
import 'package:settings/view/widgets/master_detail_utils.dart';
import 'package:settings/view/widgets/menu_item.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.item}) : super(key: key);

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(item.name,
            style: const TextStyle(fontWeight: FontWeight.normal)),
        leading: isTablet(context) ? null : const BackButton(),
      ),
      body: Center(
        child: item.details,
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
