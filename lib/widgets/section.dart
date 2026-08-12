import 'package:flutter/material.dart';

import '../french.dart';
import '../theme.dart';

/// Enveloppe commune à toutes les sections de la page.
///
/// C'est le seul endroit où sont réglées la largeur maximale, les marges
/// latérales et l'espace vertical entre sections. Quand le rythme de la page
/// semble faux, c'est ici qu'on corrige, pas dans cinq fichiers.
class Section extends StatelessWidget {
  final String? title;
  final String? hint;
  final Widget child;

  const Section({super.key, this.title, this.hint, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
          child: Column(
            // `stretch`, pas `start` : sinon la colonne se réduit à la largeur
            // de son contenu, et une section courte (le pied de page) se
            // retrouve centrée au milieu de l'écran par le `Center` ci-dessus.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null) ...[
                Text(title!.fr, style: theme.textTheme.titleSmall),
                const SizedBox(height: 6),
              ],
              if (hint != null) ...[
                Text(hint!.fr, style: theme.textTheme.bodySmall),
                const SizedBox(height: 16),
              ] else if (title != null)
                const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
