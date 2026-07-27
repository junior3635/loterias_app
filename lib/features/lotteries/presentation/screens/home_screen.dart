import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lottery_providers.dart';
import '../widgets/lottery_result_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(latestUsResultsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Resultados de Loterías · EE. UU.')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(latestUsResultsProvider.future),
        child: resultsAsync.when(
          data: (results) => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) =>
                LotteryResultCard(result: results[index]),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 80),
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              Center(child: Text('No se pudieron cargar los resultados')),
              Center(child: Text('$error')),
            ],
          ),
        ),
      ),
    );
  }
}
