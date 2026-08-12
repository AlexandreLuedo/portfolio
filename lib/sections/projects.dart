import 'package:flutter/material.dart';

import '../content/models.dart';
import '../widgets/project_card.dart';
import '../widgets/section.dart';

/// Une liste de projets sous un intertitre.
///
/// Un seul widget sert aux projets principaux et aux projets annexes : ce qui
/// les distingue est dans le contenu (schéma, longueur, nombre de liens), pas
/// dans deux mises en page à maintenir en parallèle.
class ProjectsSection extends StatelessWidget {
  final String title;
  final List<Project> projects;

  const ProjectsSection({
    super.key,
    required this.title,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: title,
      child: Column(
        // Toutes les cartes font la même largeur, y compris celles dont le
        // texte est court — sinon la liste part en escalier.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final project in projects) ...[
            if (project != projects.first) const SizedBox(height: 16),
            ProjectCard(project),
          ],
        ],
      ),
    );
  }
}
