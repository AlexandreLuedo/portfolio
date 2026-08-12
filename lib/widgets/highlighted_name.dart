import 'package:flutter/material.dart';

import '../theme.dart';

/// Le nom, surligné au marqueur.
///
/// Volontairement pas un `TextStyle.background` : celui-ci peint un rectangle
/// collé à la boîte du glyphe, ce qui donne une sélection de texte, pas un coup
/// de surligneur. Le trait est ici plus large que le texte et ne couvre que le
/// bas des lettres, en laissant respirer les hampes.
class HighlightedName extends StatelessWidget {
  final String text;

  /// Part de la hauteur du texte couverte par le marqueur.
  final double coverage;

  /// Débord horizontal, de chaque côté.
  final double bleed;

  const HighlightedName(
    this.text, {
    super.key,
    this.coverage = 0.62,
    this.bleed = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Sous le texte : le Stack se dimensionne sur le Text, le marqueur
        // s'étire ensuite jusqu'aux bords de cette boîte (padding compris).
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: coverage,
              widthFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // `primaryContainer` plutôt qu'un rouge en transparence :
                  // c'est la couleur que Material 3 prévoit pour poser un
                  // accent derrière du texte lisible, et elle est déjà
                  // accordée au reste du thème.
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: bleed),
          child: Text(
            text,
            style: theme.textTheme.displaySmall?.copyWith(
              fontFamily: kMono,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
