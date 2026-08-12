import 'package:flutter/material.dart';

import '../content/content.dart';
import '../french.dart';
import '../widgets/section.dart';
import '../widgets/tech_chip.dart';

/// « Outils » et « Ma stack » dans une seule section.
///
/// Deux groupes plutôt qu'une liste unique : la vraie différence n'est pas
/// logiciel / techno, c'est ce dans quoi je tape et ce que je fais tourner.
/// Et une seule section, parce que ça ne mérite pas deux arrêts dans la page.
class ToolboxSection extends StatelessWidget {
  const ToolboxSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Section(
      title: Ui.toolsTitle,
      hint: Ui.toolsHint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final group in toolGroups) ...[
            if (group != toolGroups.first) const SizedBox(height: 24),
            Text(
              group.title.fr,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            TechWrap(group.items),
          ],
        ],
      ),
    );
  }
}
