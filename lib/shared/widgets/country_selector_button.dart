import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/countries.dart';
import '../providers/country_providers.dart';

/// Botón de país para el AppBar (muestra bandera + código) que abre un
/// bottom sheet con el listado completo de `kSupportedCountries`.
///
/// Los países con `available: false` se muestran deshabilitados con la
/// etiqueta "Próximamente" — así queda visualmente claro que la app ya
/// está pensada para más países aunque hoy solo funcione EE. UU.
class CountrySelectorButton extends ConsumerWidget {
  const CountrySelectorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCountryInfoProvider);

    return TextButton.icon(
      onPressed: () => _showCountryPicker(context, ref),
      icon: Text(selected.flagEmoji, style: const TextStyle(fontSize: 18)),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(selected.code),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _showCountryPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selecciona un país',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              ...kSupportedCountries.map(
                (country) => ListTile(
                  leading: Text(
                    country.flagEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country.name),
                  trailing: country.available
                      ? null
                      : Chip(
                          label: const Text('Próximamente'),
                          visualDensity: VisualDensity.compact,
                        ),
                  enabled: country.available,
                  onTap: !country.available
                      ? null
                      : () {
                          ref.read(selectedCountryProvider.notifier).state =
                              country.code;
                          Navigator.of(context).pop();
                        },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
