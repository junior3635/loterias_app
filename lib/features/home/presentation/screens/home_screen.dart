import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../draws/presentation/providers/draws_providers.dart';
import '../../../draws/presentation/widgets/us_states_list.dart';
import '../../../lotteries/presentation/providers/lottery_providers.dart';
import '../../../lotteries/presentation/widgets/lottery_result_card.dart';
import '../../../news/presentation/providers/news_providers.dart';
import '../../../news/presentation/widgets/news_card.dart';
import '../../../../shared/providers/country_providers.dart';
import '../../../../shared/widgets/country_selector_button.dart';

/// Pantalla de inicio. Para el país seleccionado (selector en el AppBar)
/// muestra, en este orden:
///   1. Loterías principales/nacionales (ej. Powerball, Mega Millions)
///   2. Loterías por estado (lista de 2 columnas, igual que el picker)
///   3. Noticias
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryInfo = ref.watch(selectedCountryInfoProvider);
    final featuredAsync = ref.watch(featuredLotteriesProvider);
    final states = ref.watch(statesWithLotteriesProvider);
    final newsAsync = ref.watch(latestNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loterías Internacionales'),
        actions: const [CountrySelectorButton(), SizedBox(width: 8)],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.refresh(allResultsProvider.future),
            ref.refresh(latestNewsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // --- 1. Loterías principales ---
            _SectionHeader(
              title: 'Loterías principales · ${countryInfo.flagEmoji} ${countryInfo.name}',
            ),
            featuredAsync.when(
              data: (results) => results.isEmpty
                  ? const _EmptySection(
                      message: 'Sin loterías nacionales para este país todavía.',
                    )
                  : Column(
                      children: results
                          .map((r) => LotteryResultCard(result: r))
                          .toList(),
                    ),
              loading: () => const _LoadingSection(),
              error: (error, stack) => _ErrorSection(message: '$error'),
            ),

            const SizedBox(height: 8),

            // --- 2. Loterías por estado ---
            _SectionHeader(title: 'Loterías por estado'),
            if (states.isEmpty)
              const _EmptySection(
                message: 'Sin loterías estatales para este país todavía.',
              )
            else ...[
              UsStatesList(
                states: states,
                shrinkWrap: true,
                onStateSelected: (state) {
                  ref.read(selectedStateProvider.notifier).state =
                      state.name;
                  context.go('/draws');
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => context.push('/draws/states'),
                    icon: const Icon(Icons.list_alt, size: 18),
                    label: const Text('Ver todos los estados'),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 8),

            // --- 3. Noticias ---
            _SectionHeader(title: 'Noticias'),
            newsAsync.when(
              data: (articles) => Column(
                children: articles
                    .take(2)
                    .map((a) => NewsCard(article: a))
                    .toList(),
              ),
              loading: () => const _LoadingSection(),
              error: (error, stack) => _ErrorSection(message: '$error'),
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

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
}

class _ErrorSection extends StatelessWidget {
  const _ErrorSection({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Ocurrió un error: $message'),
      );
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
}
