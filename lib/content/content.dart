/// TOUT le texte du site est ici. C'est le seul fichier à éditer pour changer
/// le contenu : aucune ligne d'interface ne s'y trouve.
///
/// Écris la ponctuation normalement, avec une espace simple avant `: ; ! ?` :
/// l'affichage la remplace tout seul par une espace fine insécable, comme le
/// veut la typographie française (voir `lib/french.dart`).
library;

import 'models.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Identité
// ─────────────────────────────────────────────────────────────────────────────

/// Photo ronde en haut de page.
///
/// Mets ton fichier dans `assets/images/` et écris son chemin ici, par exemple
/// `'assets/images/photo.jpg'`. Tant que c'est `null`, une silhouette grise
/// s'affiche à la place.
const String? photo = 'images/profile.webp';

const String fullName = 'Hadrien K';
const String pseudo = '@AlexandreLuedo';
const String tagline = 'Futur administrateur système';

const String taglinePlain =
    'Je fais tourner les serveurs et les réseaux sur lesquels tournent des '
    'applications. J\'ai également une appétence pour Linux et les logiciels '
    'libres.';

// ─────────────────────────────────────────────────────────────────────────────
// Projets principaux — avec schéma, description longue, et jusqu'à 3 boutons.
// ─────────────────────────────────────────────────────────────────────────────

const List<Project> mainProjects = [
  Project(
    title: 'Infrastructure',
    blurb:
        'Mon infrastructure personnelle : serveurs, réseau privé, DNS, '
        'certificats et sauvegardes, le tout installé et reconfigurable '
        'automatiquement.',
    tech: [linux, ansible, docker, tailscale, powerdns, chrony, pki, bash],
    diagram: 'assets/diagrams/infrastructure.svg',
    explainer: [
      'Une infrastructure, c\'est l\'ensemble des machines et des réseaux sur '
          'lesquels tournent les applications qu\'on utilise tous les jours. '
          'Quand un site répond, quand un fichier est sauvegardé, quand une '
          'connexion est sécurisée : quelqu\'un a monté tout ça derrière.',
      'Ici, j\'ai monté la mienne à la maison. Elle me sert de terrain '
          'd\'entraînement : j\'y héberge mes projets et j\'y reproduis '
          'ce qu\'on trouve en entreprise, à plus petite échelle.',
      'La partie dont je suis le plus content, c\'est qu\'elle est entièrement '
          'décrite dans des fichiers. Si une machine meurt, je n\'ai rien à '
          'refaire à la main : je relance la configuration et elle se '
          'reconstruit à l\'identique.',
      'Voici les technologies employées pour faire tourner les serveurs :',
    ],
    links: [
      ProjectLink(LinkKind.code, 'https://github.com/AlexandreLuedo/Ansible'),
    ],
  ),
  Project(
    title: 'Ganache.lab',
    blurb:
        'Application Flutter : le premier équilibreur de ganaches multiplateforme.',
    tech: [flutter, git],
    diagram: 'assets/diagrams/ganache_lab.png',
    explainer: [
      'Ganache.lab est une application mobile fonctionnant de manière native '
          'sur toutes les plateformes, ce qui fait d\'elle la première dans '
          'son genre. Elle évite les calculs fastidieux pour créer des '
          'recettes de ganaches. Cela permet, en un temps record, de créer des '
          'recettes avec une texture précise et une conservation maîtrisée.',
      'L\'utilisateur n\'a qu\'à renseigner son poids total ou bien remplir les '
          'dimensions de ses moules, choisir le type de chocolat qu\'il '
          'souhaite, pour enfin appuyer sur le bouton de calcul. '
          'Puis le chocolatier peut commencer à produire sa ganache ou '
          'exporter la recette en moins de 5 min, top chrono ! Ce qui n\'est '
          'pas possible en temps normal avec les autres logiciels de ce type.',
      'Vous pouvez cliquer sur le bouton "Démo" pour accéder à la version de '
          'test !',
    ],
    links: [
      ProjectLink(
        LinkKind.code,
        'https://github.com/AlexandreLuedo/Ganache.lab',
      ),
      ProjectLink(
        LinkKind.demo,
        'https://alexandreluedo.github.io/Ganache.lab/',
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Projets annexes — pas de schéma, volontairement plus légers.
// ─────────────────────────────────────────────────────────────────────────────

const List<Project> sideProjects = [
  Project(
    title: 'Converter.lab',
    blurb:
        'Application Flutter : une solution moderne pour convertir les '
        'dimensions des moules en poids.',
    tech: [flutter, git],
    explainer: [
      'L\'idée est de répondre à une problématique de conversion des diamètres '
          'de cadres et de moules.',
      'Concrètement, l\'utilisateur remplit les dimensions de son moule ou de '
          'son cadre et le logiciel retourne une valeur en grammes.',
      'Puis l\'on peut partager le résultat en le copiant automatiquement via '
          'un bouton ou en envoyant le contenu vers une autre application.',
    ],
    links: [
      ProjectLink(
        LinkKind.code,
        'https://github.com/AlexandreLuedo/Converter.lab',
      ),
      ProjectLink(
        LinkKind.demo,
        'https://alexandreluedo.github.io/Converter.lab/',
      ),
    ],
  ),
  Project(
    title: 'Serveur Minecraft',
    blurb:
        'Un serveur de jeu hébergé chez moi, accessible à mes amis, avec '
        'sauvegardes et mises à jour automatiques.',
    tech: [linux, docker, bash, git, neovim],
    explainer: [
      'Héberger un serveur de jeu, c\'est faire tourner en permanence le '
          'programme auquel les joueurs se connectent. C\'est un bon exercice '
          'de sysadmin : il faut que ça tienne, que ça sauvegarde tout '
          'seul, et que ça reste joignable de l\'extérieur sans ouvrir la '
          'porte à n\'importe qui.',
      'J\'ai utilisé itzg/docker-minecraft-server, puis j\'ai rédigé le '
          'Docker Compose en le couplant avec une instance Tailscale, afin de '
          'ne pas ouvrir de ports sur la box internet tout en me donnant la '
          'possibilité de créer d\'autres serveurs Minecraft. '
          'En dernier lieu, j\'ai mis en place un service de sauvegardes '
          'automatiques via le projet Docker itzg/mc-backup.',
    ],
    links: [
      ProjectLink(
        LinkKind.code,
        'https://github.com/AlexandreLuedo/Groupuscule-Minecraft-Server',
      ),
    ],
  ),
  Project(
    title: 'Doc',
    blurb:
        'Ma documentation personnelle : notes d\'installation, '
        'procédures, pense-bêtes. Écrite en Org (un format texte brut), '
        'lisible directement sur GitHub.',
    tech: [emacs, git, english],
    links: [
      ProjectLink(LinkKind.code, 'https://github.com/AlexandreLuedo/DOCU'),
    ],
  ),
  Project(
    title: 'Portfolio',
    blurb:
        'Mon portfolio retracant une partie de mes projets',
    tech: [flutter, git],
    links: [
      ProjectLink(LinkKind.code, 'https://github.com/AlexandreLuedo/portfolio'),
    ]
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Outils et technos
//
// Chaque techno est déclarée une fois ici, puis réutilisée dans les projets.
// La deuxième chaîne est l'explication qui apparaît au survol ou au clic :
// elle s'adresse à quelqu'un d'extérieur au métier.
// ─────────────────────────────────────────────────────────────────────────────

const linux = Tech(
  'Linux',
  'Système d\'exploitation libre, alternative à Windows.',
);
const macos = Tech('macOS', 'Le système des ordinateurs Apple.');
const neovim = Tech(
  'Neovim',
  'Éditeur de texte qui se pilote entièrement au clavier.',
);
const emacs = Tech(
  'Doom Emacs',
  'Éditeur de texte très personnalisable, qui me sert aussi à écrire et '
      'organiser mes notes.',
);
const vscode = Tech(
  'VS Code',
  'Éditeur de code de Microsoft, le plus répandu aujourd\'hui.',
);
const androidStudio = Tech(
  'Android Studio',
  'Outil pour créer et tester des applications mobiles.',
);
const git = Tech(
  'Git',
  'Garde l\'historique de toutes les modifications d\'un projet.',
);

const ansible = Tech(
  'Ansible',
  'Installe et configure des dizaines de machines automatiquement.',
);
const docker = Tech(
  'Docker',
  'Fait tourner une application isolée, à l\'identique sur n\'importe quelle '
      'machine.',
);
const tailscale = Tech(
  'Tailscale',
  'Relie mes machines entre elles par un réseau privé, où qu\'elles soient.',
);
const powerdns = Tech(
  'PowerDNS',
  'Traduit les noms de sites (exemple.fr) en adresses de machines.',
);
const chrony = Tech(
  'Chrony',
  'Garde toutes les machines à la même heure, à la milliseconde près.',
);
const pki = Tech(
  'PKI',
  'Gère les certificats qui sécurisent les connexions — le cadenas du '
      'navigateur.',
);
const bash = Tech(
  'Bash',
  'Écrit de petits scripts pour automatiser les tâches répétitives.',
);
const flutter = Tech(
  'Flutter / Dart',
  'Permet de créer une application mobile et web à partir d\'un seul code.',
);
const francais = Tech('Français', 'Langue maternelle.');
const english = Tech('Anglais', 'Courant à l\'écrit.');

const List<ToolGroup> toolGroups = [
  ToolGroup(
    title: 'Outils',
    items: [linux, macos, neovim, emacs, vscode, androidStudio, git],
  ),
  ToolGroup(
    title: 'Ma stack',
    items: [ansible, docker, tailscale, powerdns, chrony, pki, bash, flutter],
  ),
  ToolGroup(title: 'Langues pratiquées', items: [francais, english]),
];


// ─────────────────────────────────────────────────────────────────────────────
// Contact
// ─────────────────────────────────────────────────────────────────────────────

const List<ContactLink> contacts = [
  ContactLink('Mail', 'mailto:alexandre.luedo@pm.me'),
  ContactLink('GitHub', 'https://github.com/AlexandreLuedo'),
  ContactLink('LinkedIn', 'https://www.linkedin.com/in/hadrien-k-823a2a205'),
];

// ─────────────────────────────────────────────────────────────────────────────
// Libellés de l'interface
// ─────────────────────────────────────────────────────────────────────────────

abstract final class Ui {
  static const siteTitle = 'Portfolio - Hadrien K';

  static const toolsTitle = 'Ce que j\'utilise';
  static const toolsHint =
      'Passer la souris ou appuyer sur un élément pour voir à quoi il sert.';

  static const mainProjectsTitle = 'Projets principaux';
  static const sideProjectsTitle = 'Projets annexes';
  static const contactTitle = 'Me contacter';

  static const linkCode = 'Code';
  static const linkDemo = 'Démo';
  static const linkExplain = 'Explications';

  static const zoomHint = 'Appuyer sur le schéma pour l\'agrandir.';
  static const close = 'Fermer';
  static const back = 'Retour';
  static const builtWith =
      'Site fait en Dart propulsé par le framework Flutter.';
}
