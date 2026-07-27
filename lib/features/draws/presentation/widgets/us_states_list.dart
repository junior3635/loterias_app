import 'package:flutter/material.dart';
import '../../../../core/constants/us_states.dart';

/// Lista de estados en 2 columnas (código + nombre), con una línea
/// divisoria bajo cada fila — replica el patrón de la imagen de
/// referencia ("State lotteries").
///
/// Es genérico respecto a la fuente de estados (recibe `states`), así
/// que el mismo widget sirve tanto para "elegir estado" (con `onTap`)
/// como para mostrarlos de solo lectura si hiciera falta.
class UsStatesList extends StatelessWidget {
  const UsStatesList({
    required this.states,
    this.onStateSelected,
    this.selectedCode,
    super.key,
  });

  final List<UsState> states;
  final ValueChanged<UsState>? onStateSelected;
  final String? selectedCode;

  @override
  Widget build(BuildContext context) {
    // Agrupamos los estados de a 2 para pintar cada fila con 2 columnas,
    // igual que en la imagen de referencia (izquierda/derecha).
    final rows = <List<UsState>>[];
    for (var i = 0; i < states.length; i += 2) {
      final end = (i + 2 <= states.length) ? i + 2 : states.length;
      rows.add(states.sublist(i, end));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final row = rows[index];
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: _StateCell(
                  state: row[0],
                  isSelected: row[0].code == selectedCode,
                  onTap: onStateSelected,
                )),
                Expanded(
                  child: row.length > 1
                      ? _StateCell(
                          state: row[1],
                          isSelected: row[1].code == selectedCode,
                          onTap: onStateSelected,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}

class _StateCell extends StatelessWidget {
  const _StateCell({
    required this.state,
    required this.isSelected,
    this.onTap,
  });

  final UsState state;
  final bool isSelected;
  final ValueChanged<UsState>? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap == null ? null : () => onTap!(state),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                state.code,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                state.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check, size: 16, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
