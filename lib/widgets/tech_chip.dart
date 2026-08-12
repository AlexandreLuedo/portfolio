import 'package:flutter/material.dart';

import '../content/models.dart';
import '../french.dart';

/// Une techno, avec son explication en français courant au survol ou au clic.
///
/// `triggerMode: tap` est important : par défaut Flutter demande un appui long,
/// que personne ne devine sur mobile.
class TechChip extends StatelessWidget {
  final Tech tech;

  const TechChip(this.tech, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tech.gloss.fr,
      triggerMode: TooltipTriggerMode.tap,
      child: Chip(
        label: Text(tech.name),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

/// Les puces d'un groupe, qui passent à la ligne toutes seules.
class TechWrap extends StatelessWidget {
  final List<Tech> items;

  const TechWrap(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final t in items) TechChip(t)],
    );
  }
}
