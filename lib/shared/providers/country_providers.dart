import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/countries.dart';

/// País seleccionado en la app. Es compartido (vive en `shared/`) porque
/// tanto Home (loterías principales + estados) como Sorteos (filtros)
/// necesitan saber cuál es el país activo.
///
/// Por ahora solo 'US' es seleccionable — ver `kSupportedCountries`.
final selectedCountryProvider = StateProvider<String>((ref) => 'US');

/// Devuelve el objeto `Country` completo correspondiente al código
/// actualmente seleccionado (nombre, bandera, etc.), para pintarlo en
/// la UI sin repetir lookups.
final selectedCountryInfoProvider = Provider<Country>((ref) {
  final code = ref.watch(selectedCountryProvider);
  return kSupportedCountries.firstWhere(
    (c) => c.code == code,
    orElse: () => kSupportedCountries.first,
  );
});
