import 'package:flutter/material.dart';

/// Rouge brique, chaud plutôt que vif.
///
/// Il sert d'accent, pas de fond : le surligneur du nom, les liens, le bouton
/// « Explications ». La page reste blanche et noire — c'est ce qui rend les
/// trois touches de rouge visibles.
const Color kSeed = Color(0xFFC0392B);

/// Une seule graisse embarquée (600). N'utilise pas d'autre `fontWeight` avec
/// cette famille : Flutter la simulerait, et ça se voit.
const String kMono = 'JetBrainsMono';

/// Largeur maximale du texte. Au-delà, les lignes deviennent trop longues à
/// lire, quelle que soit la taille de l'écran.
const double kMaxContentWidth = 800;

ThemeData buildTheme() {
  // `ColorScheme.fromSeed` teinte *tout* à partir de la graine : avec un rouge,
  // les fonds de cartes, de puces et de panneaux virent au rose et la page
  // entière prend une couleur. On récupère donc les gris à la main, et le rouge
  // ne reste que là où on l'a décidé : le surligneur, les liens, le bouton
  // « Explications ».
  final scheme =
      ColorScheme.fromSeed(
        seedColor: kSeed,
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(0xFFB03A2E),
        onPrimary: Colors.white,
        // Le couple conteneur / sur-conteneur de Material 3 : c'est lui qui
        // porte le rouge partout où il apparaît (surligneur du nom, bouton
        // « Explications »), au lieu d'une opacité choisie à la main.
        primaryContainer: const Color(0xFFFBDDD7),
        onPrimaryContainer: const Color(0xFF5C1A11),
        surface: const Color(0xFFFFFDFC),
        onSurface: const Color(0xFF1B1918),
        onSurfaceVariant: const Color(0xFF5C5654),
        surfaceContainerLowest: const Color(0xFFFFFFFF),
        surfaceContainerLow: const Color(0xFFF8F7F6),
        surfaceContainer: const Color(0xFFF3F1F0),
        surfaceContainerHigh: const Color(0xFFEEECEA),
        surfaceContainerHighest: const Color(0xFFE8E5E3),
        outlineVariant: const Color(0xFFDFDAD7),
        outline: const Color(0xFFB2ABA7),
      );

  final base = ThemeData(colorScheme: scheme, useMaterial3: true);

  return base.copyWith(
    scaffoldBackgroundColor: scheme.surface,
    textTheme: _textTheme(base.textTheme, scheme),
    // Material 3 anime les changements de page avec un fondu-glissé plutôt
    // qu'un glissement plein écran. Sur le web, c'est aussi la transition qui
    // se remarque le moins quand on revient en arrière.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
      },
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 3,
      shadowColor: Colors.black26,
    ),
    // Carte « elevated » de Material 3 : fond `surfaceContainerLow`, une ombre
    // discrète, pas de contour. Le contour et l'ombre ensemble donnaient une
    // carte à deux bords.
    cardTheme: CardThemeData(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    // Puce « assist » de Material 3 : coins à 8, pas de stadium — c'est le
    // détail qui distingue une puce M3 d'une puce M2.
    chipTheme: ChipThemeData(
      backgroundColor: scheme.surface,
      side: BorderSide(color: scheme.outline),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelStyle: TextStyle(
        fontSize: 13,
        height: 1.2,
        color: scheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      // Les glossaires font une phrase : sans largeur maximale, le tooltip
      // s'étale sur toute la fenêtre.
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: scheme.onInverseSurface,
        fontSize: 13,
        height: 1.35,
      ),
      waitDuration: const Duration(milliseconds: 200),
      showDuration: const Duration(seconds: 8),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.onSurfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      space: 1,
      thickness: 1,
    ),
  );
}

/// Dans un site aussi simple, la hiérarchie *est* le design : tout se joue sur
/// la taille, la graisse et l'interligne.
TextTheme _textTheme(TextTheme base, ColorScheme scheme) => base.copyWith(
  displaySmall: base.displaySmall?.copyWith(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.15,
    letterSpacing: -0.5,
    color: scheme.onSurface,
  ),
  titleLarge: base.titleLarge?.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: scheme.onSurface,
  ),
  // Intertitres de section, à la manière des en-têtes de liste Material 3 :
  // casse normale, couleur d'accent, petite taille. Ils ordonnent la page sans
  // lui voler l'attention, et ce sont eux qui répartissent le rouge le long du
  // défilement.
  titleSmall: base.titleSmall?.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: scheme.primary,
  ),
  bodyLarge: base.bodyLarge?.copyWith(
    fontSize: 17,
    height: 1.6,
    color: scheme.onSurface,
  ),
  bodyMedium: base.bodyMedium?.copyWith(
    fontSize: 15,
    height: 1.55,
    color: scheme.onSurfaceVariant,
  ),
  bodySmall: base.bodySmall?.copyWith(
    fontSize: 13,
    height: 1.45,
    color: scheme.onSurfaceVariant,
  ),
);
