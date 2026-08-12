/// Modèles de contenu du portfolio.
///
/// Ce fichier ne dépend pas de Flutter : c'est du Dart pur. Il décrit *ce que*
/// le site raconte, jamais *comment* il s'affiche.
library;

/// Un lien externe posé sur un projet.
enum LinkKind {
  /// Vers le dépôt de code (GitHub, Forgejo…).
  code,

  /// Vers la démo en ligne.
  demo,
}

/// Une techno ou un outil, avec son explication en français courant.
///
/// [gloss] est lue par des personnes qui ne font pas d'informatique : pas de
/// jargon, une phrase, pas de point-virgule.
class Tech {
  final String name;
  final String gloss;

  const Tech(this.name, this.gloss);
}

/// Un groupe de [Tech] affiché sous un intertitre (« Outils », « Ma stack »…).
class ToolGroup {
  final String title;
  final List<Tech> items;

  const ToolGroup({required this.title, required this.items});
}

class ProjectLink {
  final LinkKind kind;
  final String url;

  const ProjectLink(this.kind, this.url);
}

class Project {
  final String title;

  /// Une ou deux phrases. C'est ce qu'on lit dans la liste, sans cliquer.
  final String blurb;

  final List<Tech> tech;

  /// Chemin d'une image dans `assets/diagrams/`, ou `null`.
  ///
  /// SVG ou raster (PNG, JPG) : l'extension suffit, rien d'autre à déclarer.
  ///
  /// Réservé aux projets principaux : c'est ce qui creuse l'écart visuel avec
  /// les projets annexes.
  final String? diagram;

  /// Le texte de la page « Explications », un paragraphe par entrée.
  ///
  /// Vide = pas de bouton « Explications » sur la carte.
  final List<String> explainer;

  final List<ProjectLink> links;

  const Project({
    required this.title,
    required this.blurb,
    this.tech = const [],
    this.diagram,
    this.explainer = const [],
    this.links = const [],
  });

  bool get hasExplainer => explainer.isNotEmpty;
}

class ContactLink {
  final String label;
  final String url;

  const ContactLink(this.label, this.url);
}
