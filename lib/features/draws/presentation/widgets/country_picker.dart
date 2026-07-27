import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class AppBarCountryFlag extends StatefulWidget {
  final String initialCountryCode;
  final ValueChanged<Country>? onCountryChanged;
  final double flagSize;

  const AppBarCountryFlag({
    super.key,
    this.initialCountryCode = 'US', // EE. UU. por defecto
    this.onCountryChanged,
    this.flagSize = 24.0,
  });

  @override
  State<AppBarCountryFlag> createState() => _AppBarCountryFlagState();
}

class _AppBarCountryFlagState extends State<AppBarCountryFlag> {
  late String _currentFlag;

  @override
  void initState() {
    super.initState();
    try {
      _currentFlag = Country.parse(widget.initialCountryCode).flagEmoji;
    } catch (e) {
      _currentFlag = '🇺🇸'; // Fallback a EE. UU.
    }
  }

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      // 🔒 Restringe la lista exclusivamente a EE. UU. y Canadá
      countryFilter: <String>['US', 'CA'], 
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Buscar país',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _currentFlag = country.flagEmoji;
        });
        widget.onCountryChanged?.call(country);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openCountryPicker(context),
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          _currentFlag,
          style: TextStyle(
            fontSize: widget.flagSize,
          ),
        ),
      ),
    );
  }
}