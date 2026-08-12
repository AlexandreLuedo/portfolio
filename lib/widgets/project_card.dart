import 'package:flutter/material.dart';

import '../content/models.dart';
import '../french.dart';
import '../pages/project_detail.dart';
import 'diagram_view.dart';
import 'project_links.dart';
import 'tech_chip.dart';

/// Une carte de projet, en pleine largeur.
///
/// Pas de grille à trois colonnes : une colonne se lit mieux sur grand écran et
/// se replie sur mobile sans une ligne de code en plus. Un projet sans schéma
/// n'a pas de trou à la place — la carte est simplement plus courte, et c'est
/// ce qui distingue les projets annexes des principaux.
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.diagram != null) DiagramPreview(project.diagram!),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(project.blurb.fr, style: theme.textTheme.bodyMedium),
                if (project.tech.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  TechWrap(project.tech),
                ],
                if (project.hasExplainer || project.links.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ProjectLinks(
                    project: project,
                    onExplain: () => ProjectDetailPage.open(context, project),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
