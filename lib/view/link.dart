import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  const Link({super.key, required this.url, required this.linkText});

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
