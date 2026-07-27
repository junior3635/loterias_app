import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/draws_providers.dart';

class DrawsFilterBar extends ConsumerWidget {
  const DrawsFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(availableCountriesProvider);
    final states = ref.watch(availableStatesProvider);
    final selectedCountry = ref.watch(selectedCountryProvider);
    final selectedState = ref.watch(selectedStateProvider);

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
              items: countries
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(_countryLabel(c)),
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

  String _countryLabel(String code) {
    switch (code) {
      case 'US':
        return 'Estados Unidos';
      default:
        return code;
    }
  }
}
