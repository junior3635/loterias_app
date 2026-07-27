import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/entities/news_article.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryMockImpl();
});

final latestNewsProvider = FutureProvider<List<NewsArticle>>((ref) async {
  final repository = ref.watch(newsRepositoryProvider);
  return repository.getLatestNews();
});
