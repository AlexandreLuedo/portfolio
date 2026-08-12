import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../content/content.dart';
import '../content/models.dart';

/// La rangée de boutons d'un projet.
///
/// Le nombre de boutons vient du contenu, pas de la mise en page : un projet
/// avec un seul lien n'affiche qu'un bouton, sans trou à côté.
/// « Explications » passe en premier et en rouge — c'est celui qu'on veut voir
/// cliqué, et c'est l'un des rares endroits où l'accent sert à quelque chose.
class ProjectLinks extends StatelessWidget {
  final Project project;

  /// `null` quand on est déjà sur la page d'explications.
  final VoidCallback? onExplain;

  const ProjectLinks({super.key, required this.project, this.onExplain});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final explains = project.hasExplainer && onExplain != null;

    return Transform.translate(
      // Un bouton plein s'aligne par son fond, un bouton texte par son texte —
      // et celui-ci porte 12 px de marge interne. Sans ce décalage, une rangée
      // qui commence par « Code » est en retrait du reste de la carte.
      offset: explains ? Offset.zero : const Offset(-12, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (explains)
            // Bouton « tonal » de Material 3 : plus appuyé qu'un bouton texte,
            // moins qu'un bouton plein. C'est exactement le rang de cette
            // action — la plus intéressante de la carte, mais pas une validation.
            FilledButton.tonalIcon(
              onPressed: onExplain,
              icon: const Icon(Icons.auto_stories_outlined, size: 18),
              label: const Text(Ui.linkExplain),
              style: FilledButton.styleFrom(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
              ),
            ),
          for (final link in project.links)
            TextButton.icon(
              onPressed: () => _open(context, link.url),
              icon: Icon(_icon(link.kind), size: 18),
              label: Text(_label(link.kind)),
            ),
        ],
      ),
    );
  }

  static IconData _icon(LinkKind kind) => switch (kind) {
    LinkKind.code => Icons.code,
    LinkKind.demo => Icons.open_in_new,
  };

  static String _label(LinkKind kind) => switch (kind) {
    LinkKind.code => Ui.linkCode,
    LinkKind.demo => Ui.linkDemo,
  };

  static Future<void> _open(BuildContext context, String url) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final uri = Uri.tryParse(url);

    if (uri != null) {
      try {
        if (await launchUrl(uri, webOnlyWindowName: '_blank')) return;
      } on Exception {
        // Lien mal formé ou bloqué par le navigateur : on prévient plus bas.
      }
    }

    messenger?.showSnackBar(
      SnackBar(content: Text("Impossible d'ouvrir $url")),
    );
  }
}
