import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/lottery_repository_impl.dart';
import '../../domain/entities/lottery_result.dart';
import '../../domain/repositories/lottery_repository.dart';

/// Provider del repositorio.
/// Hoy apunta al mock; cuando exista la fuente real, se cambia SOLO aquí.
final lotteryRepositoryProvider = Provider<LotteryRepository>((ref) {
  return LotteryRepositoryMockImpl();
});

/// Provider asíncrono (FutureProvider) que expone los últimos resultados
/// de EE. UU. a la UI, con manejo automático de loading/error/data.
/// Lo usa la pantalla de Home (destacados/recientes).
final latestUsResultsProvider = FutureProvider<List<LotteryResult>>((
  ref,
) async {
  final repository = ref.watch(lotteryRepositoryProvider);
  return repository.getLatestResults(countryCode: 'US');
});

/// Provider con TODOS los resultados disponibles, sin filtrar.
/// Lo consume la sección de "Sorteos" para aplicar filtros de
/// país/estado en el cliente (ver draws_providers.dart).
final allResultsProvider = FutureProvider<List<LotteryResult>>((ref) async {
  final repository = ref.watch(lotteryRepositoryProvider);
  return repository.getAllResults();
});
