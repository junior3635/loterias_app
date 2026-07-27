import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pantalla de inicio: un panel de resumen con lo más relevante,
/// sin reemplazar las secciones completas de Sorteos y Noticias
/// (que tienen su propia pestaña con más detalle/filtros).
class LotteryScreen extends ConsumerWidget {

  final String lotteryId;

  const LotteryScreen({
    super.key,
    required this.lotteryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: Text('$lotteryId')),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([

          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [

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
