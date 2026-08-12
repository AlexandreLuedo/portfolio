import 'package:flutter/material.dart';

import '../content/content.dart';
import '../content/models.dart';
import '../french.dart';
import '../theme.dart';
import '../widgets/diagram_view.dart';
import '../widgets/project_links.dart';
import '../widgets/tech_chip.dart';

/// La page « Explications » d'un projet.
///
/// Elle tient la promesse du site : tout ce qu'il y a ici s'explique à
/// quelqu'un qui ne fait pas d'informatique. Le texte est donc en `bodyLarge`,
/// large et aéré — c'est une page qui se lit, pas qui se survole.
class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage(this.project, {super.key});

  static Future<void> open(BuildContext context, Project project) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ProjectDetailPage(project)));
  }

  /// Écart entre le bord de la barre (16) et le début de la colonne de texte.
  static double _titleInset(BuildContext context) {
    final free = (MediaQuery.sizeOf(context).width - kMaxContentWidth) / 2;
    return (free + _bodyPadding - 16).clamp(0, double.infinity);
  }

  static const double _bodyPadding = 24;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diagram = project.diagram;

    return Scaffold(
      // Grande barre supérieure Material 3 : le titre commence en grand, puis
      // se replie en petit au défilement. C'est le composant prévu pour une
      // page de lecture, et il donne au retour un point d'appui fixe.
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 152,
            // La barre Material 3 colle son titre au bord de l'écran, alors que
            // le texte de la page vit dans une colonne centrée : sur un grand
            // écran, le titre se retrouve tout seul à gauche. On le ramène sur
            // la colonne. Sur mobile, la marge tombe à zéro d'elle-même.
            title: Padding(
              padding: EdgeInsetsDirectional.only(start: _titleInset(context)),
              child: Text(project.title),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    _bodyPadding,
                    8,
                    _bodyPadding,
                    64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (diagram != null) ...[
                        _Diagram(diagram),
                        const SizedBox(height: 8),
                        Text(Ui.zoomHint.fr, style: theme.textTheme.bodySmall),
                        const SizedBox(height: 28),
                      ],
                      Text(project.blurb.fr, style: theme.textTheme.bodyLarge),
                      for (final paragraph in project.explainer) ...[
                        const SizedBox(height: 20),
                        Text(paragraph.fr, style: theme.textTheme.bodyLarge),
                      ],
                      if (project.tech.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        TechWrap(project.tech),
                      ],
                      if (project.links.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        ProjectLinks(project: project),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Diagram extends StatelessWidget {
  final String asset;

  const _Diagram(this.asset);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => showDiagram(context, asset),
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(20),
        child: diagramImage(asset, fit: BoxFit.contain),
      ),
    );
  }
}
