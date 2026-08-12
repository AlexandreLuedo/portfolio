import 'package:flutter/material.dart';

import 'content/content.dart';
import 'sections/footer.dart';
import 'sections/hero.dart';
import 'sections/projects.dart';
import 'sections/toolbox.dart';

/// La page unique : cinq blocs, un seul défilement.
///
/// Pas de barre de navigation ni d'ancres — à cette longueur, elles donnent du
/// travail à l'utilisateur au lieu de lui en économiser.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          // Les projets avant les outils : on veut savoir ce que quelqu'un a
          // construit avant de savoir avec quoi. Et la liste d'outils se lit
          // mieux une fois qu'on a vu à quoi elle a servi.
          children: const [
            HeroSection(),
            ProjectsSection(
              title: Ui.mainProjectsTitle,
              projects: mainProjects,
            ),
            ProjectsSection(
              title: Ui.sideProjectsTitle,
              projects: sideProjects,
            ),
            ToolboxSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
