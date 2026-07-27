import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/us_states.dart';
import '../../../../shared/providers/country_providers.dart';
import '../../../lotteries/domain/entities/lottery_result.dart';
import '../../../lotteries/presentation/providers/lottery_providers.dart';

// Nota: `selectedCountryProvider` ahora vive en
// `shared/providers/country_providers.dart`, porque tanto Home como
// Sorteos necesitan conocer el país activo (antes vivía solo acá).

/// Estado/provincia seleccionado en el filtro de Sorteos.
/// `null` = "Todos los estados".
final selectedStateProvider = StateProvider<String?>((ref) => null);

/// Lista de estados disponibles PARA el país seleccionado, derivada de
/// los resultados que sí tienen datos (no de la lista completa de 51).
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

/// Igual que `availableStatesProvider`, pero devuelve `UsState`
/// (código + nombre) en vez de solo el nombre, para poder reutilizar
/// `UsStatesList` tanto en Home como en el picker de estados.
final statesWithLotteriesProvider = Provider<List<UsState>>((ref) {
  final names = ref.watch(availableStatesProvider).toSet();
  return kUsStates.where((s) => names.contains(s.name)).toList();
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
