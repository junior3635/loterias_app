import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../lotteries/domain/entities/lottery_result.dart';
import '../../../lotteries/presentation/providers/lottery_providers.dart';

/// País seleccionado en el filtro. Por ahora solo soportamos 'US',
/// pero se deja como String para poder agregar más países sin
/// romper la UI (ver PLAN.md → Fase 5, expansión internacional).
final selectedCountryProvider = StateProvider<String>((ref) => 'US');

/// Estado/provincia seleccionado. `null` = "Todos los estados".
final selectedStateProvider = StateProvider<String?>((ref) => null);

/// Lista de países disponibles, derivada de los datos.
/// Cuando haya más países reales, esto puede venir de una lista fija
/// de configuración en vez de derivarse de los resultados.
final availableCountriesProvider = Provider<List<String>>((ref) {
  final resultsAsync = ref.watch(allResultsProvider);
  return resultsAsync.maybeWhen(
    data: (results) => results.map((r) => r.country).toSet().toList()
      ..sort(),
    orElse: () => const ['US'],
  );
});

/// Lista de estados disponibles PARA el país seleccionado.
final availableStatesProvider = Provider<List<String>>((ref) {
  final country = ref.watch(selectedCountryProvider);
  final resultsAsync = ref.watch(allResultsProvider);
  return resultsAsync.maybeWhen(
    data: (results) => results
        .where((r) => r.country == country && r.state != null)
        .map((r) => r.state!)
        .toSet()
        .toList()
      ..sort(),
    orElse: () => const [],
  );
});

/// Resultados filtrados por país y (opcionalmente) estado.
/// Es un Provider "derivado": no vuelve a pedir datos, solo recalcula
/// sobre lo que ya trajo `allResultsProvider`.
final filteredResultsProvider = Provider<AsyncValue<List<LotteryResult>>>((
  ref,
) {
  final country = ref.watch(selectedCountryProvider);
  final state = ref.watch(selectedStateProvider);
  final resultsAsync = ref.watch(allResultsProvider);

  return resultsAsync.whenData((results) {
    return results.where((r) {
      final matchesCountry = r.country == country;
      final matchesState = state == null || r.state == state;
      return matchesCountry && matchesState;
    }).toList();
  });
});
