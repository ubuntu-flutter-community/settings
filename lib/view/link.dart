import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  const Link({Key? key, required this.url, required this.linkText})
      : super(key: key);

  final String url;
  final String linkText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await launchUrl(Uri.parse(url)),
      child: Text(
        linkText,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
