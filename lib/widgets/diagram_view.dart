import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../content/content.dart';
import '../french.dart';

/// Le schéma, rendu selon son format.
///
/// L'extension du chemin porte déjà l'information : `content.dart` n'a donc
/// rien à déclarer, on écrit un chemin de SVG ou de PNG et ça marche. Les deux
/// vues (la bande de l'aperçu et le plein écran) passent par ici, sinon l'une
/// des deux se met à afficher du vide selon le format.
Widget diagramImage(
  String asset, {
  required BoxFit fit,
  Alignment alignment = Alignment.center,
}) {
  if (asset.toLowerCase().endsWith('.svg')) {
    return SvgPicture.asset(
      asset,
      fit: fit,
      alignment: alignment,
      placeholderBuilder: (_) => const SizedBox.shrink(),
    );
  }

  return Image.asset(
    asset,
    fit: fit,
    alignment: alignment,
    // Un SVG reste net à n'importe quel zoom, un raster non : sans ça
    // l'InteractiveViewer à maxScale 5 crénelle visiblement.
    filterQuality: FilterQuality.medium,
    errorBuilder: (_, _, _) => const SizedBox.shrink(),
  );
}

/// Aperçu d'un schéma dans une carte : une bande, pas l'image entière.
///
/// Un schéma affiché en grand dans une liste rend chaque carte énorme et la
/// page illisible. On en montre le haut, et on ouvre le reste au clic.
class DiagramPreview extends StatelessWidget {
  final String asset;
  final double height;

  const DiagramPreview(this.asset, {super.key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Schéma du projet',
      button: true,
      child: Tooltip(
        message: Ui.zoomHint.fr,
        child: InkWell(
          onTap: () => showDiagram(context, asset),
          child: Container(
            height: height,
            width: double.infinity,
            color: scheme.surfaceContainerHighest,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                diagramImage(
                  asset,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                // La coupe nette d'un schéma donne l'impression d'une image
                // cassée (des flèches s'arrêtent dans le vide). Le dégradé fait
                // comprendre qu'il y a une suite, et qu'elle est à un clic.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: height * 0.45,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          scheme.surfaceContainerHighest.withValues(alpha: 0),
                          scheme.surfaceContainerHighest,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Le schéma en plein écran, zoomable.
Future<void> showDiagram(BuildContext context, String asset) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;

      return Dialog(
        insetPadding: const EdgeInsets.all(24),
        backgroundColor: scheme.surface,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5,
                child: diagramImage(asset, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: const Icon(Icons.close),
                tooltip: Ui.close,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
