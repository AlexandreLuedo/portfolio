/// Typographie française appliquée à l'affichage, pour que le contenu reste
/// écrit normalement.
library;

final _beforePunctuation = RegExp(r' ([:;!?»])');
final _afterOpeningQuote = RegExp('(«) ');

extension FrenchTypography on String {
  /// Remplace l'espace avant `: ; ! ?` et autour des guillemets par une espace
  /// fine insécable (U+202F).
  ///
  /// Sans elle, la ponctuation double se retrouve seule en début de ligne quand
  /// le texte passe à la ligne — ce qu'un lecteur français repère aussitôt.
  String get fr => replaceAllMapped(
    _beforePunctuation,
    (m) => '\u202f${m[1]}',
  ).replaceAllMapped(_afterOpeningQuote, (m) => '${m[1]}\u202f');
}
