import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/country_providers.dart';
import '../../data/repositories/lottery_repository_impl.dart';
import '../../domain/entities/lottery_result.dart';
import '../../domain/repositories/lottery_repository.dart';

/// Provider del repositorio.
/// Hoy apunta al mock; cuando exista la fuente real, se cambia SOLO aquí.
final lotteryRepositoryProvider = Provider<LotteryRepository>((ref) {
  return LotteryRepositoryMockImpl();
});

/// Provider con TODOS los resultados disponibles, sin filtrar.
/// Lo consumen tanto Home (para derivar destacados) como Sorteos (para
/// aplicar filtros de país/estado en el cliente).
final allResultsProvider = FutureProvider<List<LotteryResult>>((ref) async {
  final repository = ref.watch(lotteryRepositoryProvider);
  return repository.getAllResults();
});

/// Loterías "principales/nacionales" del país seleccionado, para la
/// sección destacada de Home (ej. en EE. UU.: Powerball y Mega Millions).
///
/// Se consideran "nacionales" los resultados sin `state` asignado — si
/// mañana se agrega otro país, alcanza con que sus loterías nacionales
/// también tengan `state: null` para que aparezcan acá automáticamente,
/// sin tocar este provider.
final featuredLotteriesProvider = Provider<AsyncValue<List<LotteryResult>>>((
  ref,
) {
  final country = ref.watch(selectedCountryProvider);
  final resultsAsync = ref.watch(allResultsProvider);

  return resultsAsync.whenData(
    (results) =>
        results.where((r) => r.country == country && r.state == null).toList(),
  );
});
