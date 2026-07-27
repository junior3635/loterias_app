import 'package:flutter/material.dart';

class CategoryChipsBar extends StatefulWidget {
  /// Lista de categorías u opciones a mostrar en los chips
  final List<String> categories;

  /// Índice seleccionado inicialmente (por defecto 0)
  final int initialIndex;

  /// Callback que se dispara al seleccionar una opción, retorna el índice y el texto
  final Function(int index, String category) onSelected;

  /// Altura del contenedor del scroll
  final double height;

  const CategoryChipsBar({
    super.key,
    required this.categories,
    required this.onSelected,
    this.initialIndex = 0,
    this.height = 48.0,
  });

  @override
  State<CategoryChipsBar> createState() => _CategoryChipsBarState();
}

class _CategoryChipsBarState extends State<CategoryChipsBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          final categoryName = widget.categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(categoryName),
              selected: isSelected,
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],
              showCheckmark: false, // Oculta el Checkmark por defecto si prefieres un diseño más limpio
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide.none,
              onSelected: (bool selected) {
                if (!isSelected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onSelected(index, categoryName);
                }
              },
            ),
          );
        },
      ),
    );
  }
}