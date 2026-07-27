import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/us_states.dart';
import '../providers/draws_providers.dart';
import '../widgets/us_states_list.dart';

/// Pantalla dedicada para elegir un estado, siguiendo el diseño de
/// referencia ("State lotteries"): lista completa en 2 columnas +
/// buscador arriba (útil porque son 51 jurisdicciones).
///
/// Al tocar un estado, se guarda en `selectedStateProvider` (Riverpod)
/// y se vuelve a la pantalla de Sorteos, que ya queda filtrada.
class StatePickerScreen extends ConsumerStatefulWidget {
  const StatePickerScreen({super.key});

  @override
  ConsumerState<StatePickerScreen> createState() => _StatePickerScreenState();
}

class _StatePickerScreenState extends ConsumerState<StatePickerScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCode = ref.watch(selectedStateProvider);

    final filteredStates = _query.isEmpty
        ? kUsStates
        : kUsStates
              .where(
                (s) =>
                    s.name.toLowerCase().contains(_query.toLowerCase()) ||
                    s.code.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('State lotteries')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar estado...',
                prefixIcon: Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: filteredStates.isEmpty
                ? const Center(child: Text('Sin resultados'))
                : UsStatesList(
                    states: filteredStates,
                    selectedCode: selectedCode,
                    onStateSelected: (state) {
                      // Buscamos el nombre completo del estado (así queda
                      // consistente con lo que ya usa filteredResultsProvider,
                      // que compara LotteryResult.state por nombre).
                      ref.read(selectedStateProvider.notifier).state =
                          state.name;
                      Navigator.of(context).pop();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
