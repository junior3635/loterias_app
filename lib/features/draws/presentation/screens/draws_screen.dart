import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../lotteries/presentation/widgets/lottery_result_card.dart';
import '../providers/draws_providers.dart';
import '../widgets/draws_filter_bar.dart';

class DrawsScreen extends ConsumerWidget {
  const DrawsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredResults = ref.watch(filteredResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorteos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Ver todos los estados',
            onPressed: () => context.push('/draws/states'),
          ),
        ],
      ),
      body: Column(
        children: [
          const DrawsFilterBar(),
          const Divider(height: 1),
          Expanded(
            child: filteredResults.when(
              data: (results) {
                if (results.isEmpty) {
                  return const Center(
                    child: Text('No hay sorteos para este filtro todavía.'),
                  );
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) =>
                      LotteryResultCard(result: results[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text('Error al cargar sorteos: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
