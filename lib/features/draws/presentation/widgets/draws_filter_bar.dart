import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/countries.dart';
import '../../../../shared/providers/country_providers.dart';
import '../providers/draws_providers.dart';

class DrawsFilterBar extends ConsumerWidget {
  const DrawsFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(availableStatesProvider);
    final selectedCountry = ref.watch(selectedCountryProvider);
    final selectedState = ref.watch(selectedStateProvider);

    // Por ahora solo mostramos países disponibles en el dropdown de
    // filtros (los "próximamente" se ven en el selector de Home, no
    // tiene sentido ofrecerlos acá porque no habría resultados).
    final availableCountries = kSupportedCountries
        .where((c) => c.available)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              initialValue: selectedCountry,
              decoration: const InputDecoration(
                labelText: 'País',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              items: availableCountries
                  .map(
                    (c) => DropdownMenuItem(
                      value: c.code,
                      child: Text('${c.flagEmoji} ${c.name}'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                ref.read(selectedCountryProvider.notifier).state = value;
                // Al cambiar de país, reseteamos el estado seleccionado.
                ref.read(selectedStateProvider.notifier).state = null;
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String?>(
              initialValue: selectedState,
              decoration: const InputDecoration(
                labelText: 'Estado',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todos'),
                ),
                ...states.map(
                  (s) => DropdownMenuItem<String?>(value: s, child: Text(s)),
                ),
              ],
              onChanged: (value) {
                ref.read(selectedStateProvider.notifier).state = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
