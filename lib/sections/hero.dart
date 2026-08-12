import 'package:flutter/material.dart';

import '../content/content.dart' as content;
import '../french.dart';
import '../widgets/highlighted_name.dart';
import '../widgets/section.dart';

/// Photo, nom surligné, pseudo, et ce que je veux faire.
///
/// Aligné à gauche comme le reste de la page : un bloc centré au-dessus de
/// sections alignées à gauche crée une cassure qu'on remarque sans savoir
/// pourquoi. Pour centrer quand même, il suffit de passer les deux
/// `CrossAxisAlignment` ci-dessous à `center`.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Photo(),
          const SizedBox(height: 24),
          HighlightedName(content.fullName),
          const SizedBox(height: 10),
          Text(
            content.pseudo,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Text(content.tagline.fr, style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              content.taglinePlain.fr,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo();

  static const double _size = 120;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final path = content.photo;

    return ClipOval(
      child: SizedBox.square(
        dimension: _size,
        child: path == null
            ? _placeholder(scheme)
            : Image.asset(
                path,
                fit: BoxFit.cover,
                // Un chemin d'image faux ne doit pas casser la page entière.
                errorBuilder: (_, _, _) => _placeholder(scheme),
              ),
      ),
    );
  }

  Widget _placeholder(ColorScheme scheme) => ColoredBox(
    color: scheme.surfaceContainerHighest,
    child: Icon(
      Icons.person_outline,
      size: _size * 0.45,
      color: scheme.onSurfaceVariant,
    ),
  );
}
