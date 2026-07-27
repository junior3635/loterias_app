/// Representa una noticia o pieza informativa relacionada con loterías
/// (cambios de reglas, jackpots históricos, avisos, curiosidades, etc.).
class NewsArticle {
  const NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.publishedAt,
    this.imageUrl,
    this.sourceName,
  });

  final String id;
  final String title;
  final String summary;
  final DateTime publishedAt;
  final String? imageUrl;
  final String? sourceName;
}
