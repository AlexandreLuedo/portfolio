import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../content/content.dart';
import '../widgets/section.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Section(
      title: Ui.contactTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-12, 0),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for (final contact in contacts)
                  TextButton(
                    onPressed: () => launchUrl(
                      Uri.parse(contact.url),
                      webOnlyWindowName: '_blank',
                    ),
                    child: Text(contact.label),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(Ui.builtWith, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
