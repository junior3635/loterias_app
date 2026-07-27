import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../lotteries/presentation/providers/lottery_providers.dart';
import '../../../lotteries/presentation/widgets/lottery_result_card.dart';
import '../../../news/presentation/providers/news_providers.dart';
import '../../../news/presentation/widgets/news_card.dart';

/// Pantalla de inicio: un panel de resumen con lo más relevante,
/// sin reemplazar las secciones completas de Sorteos y Noticias
/// (que tienen su propia pestaña con más detalle/filtros).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(latestUsResultsProvider);
    final newsAsync = ref.watch(latestNewsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Loterías Internacionales')),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.refresh(latestUsResultsProvider.future),
            ref.refresh(latestNewsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            _SectionHeader(title: 'Resultados recientes'),
            resultsAsync.when(
              data: (results) => Column(
                children: results
                    .take(3)
                    .map((r) => LotteryResultCard(result: r))
                    .toList(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error al cargar resultados: $error'),
              ),
            ),
            const SizedBox(height: 8),
            _SectionHeader(title: 'Noticias'),
            newsAsync.when(
              data: (articles) => Column(
                children: articles
                    .take(2)
                    .map((a) => NewsCard(article: a))
                    .toList(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error al cargar noticias: $error'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
