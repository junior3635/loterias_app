import '../../domain/entities/news_article.dart';

/// Fuente de noticias. Hoy es un mock; a futuro puede consumir un CMS,
/// un feed RSS de los sitios oficiales de las loterías, o un backend
/// propio (ver PLAN.md → Fase 3).
abstract class NewsRepository {
  Future<List<NewsArticle>> getLatestNews();
}

class NewsRepositoryMockImpl implements NewsRepository {
  @override
  Future<List<NewsArticle>> getLatestNews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockNews;
  }

  static final List<NewsArticle> _mockNews = [
    NewsArticle(
      id: '1',
      title: 'El jackpot de Powerball supera los 150 millones de dólares',
      summary:
          'Nadie acertó los 5 números más el Powerball en el último sorteo, '
          'por lo que el premio mayor sigue acumulándose para el próximo.',
      publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
      sourceName: 'Powerball.com',
    ),
    NewsArticle(
      id: '2',
      title: 'Mega Millions ajusta el precio del boleto',
      summary:
          'A partir del próximo mes, el costo del boleto cambia y se '
          'incorpora una opción de multiplicador de premio por defecto.',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      sourceName: 'MegaMillions.com',
    ),
    NewsArticle(
      id: '3',
      title: '¿Cómo se eligen los números ganadores?',
      summary:
          'Un repaso rápido al proceso de sorteo, la maquinaria certificada '
          'y las auditorías que garantizan resultados aleatorios y justos.',
      publishedAt: DateTime.now().subtract(const Duration(days: 3)),
      sourceName: 'Loterías App',
    ),
  ];
}
