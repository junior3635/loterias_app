import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/news_providers.dart';
import '../widgets/news_card.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(latestNewsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Noticias')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(latestNewsProvider.future),
        child: newsAsync.when(
          data: (articles) => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index) =>
                NewsCard(article: articles[index]),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudieron cargar las noticias')),
              Center(child: Text('$error')),
            ],
          ),
        ),
      ),
    );
  }
}
