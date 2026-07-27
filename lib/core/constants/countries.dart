/// Representa un país dentro del selector de país de la app.
///
/// `available` marca si YA tenemos datos/lógica para ese país. Los que
/// están en `false` se muestran en el selector como "Próximamente" —
/// así el selector queda listo desde ya para la expansión internacional
/// (ver PLAN.md → Fase 5) sin tener que rediseñar la UI más adelante.
class Country {
  const Country({
    required this.code,
    required this.name,
    required this.flagEmoji,
    required this.available,
  });

  final String code;
  final String name;
  final String flagEmoji;
  final bool available;
}

const List<Country> kSupportedCountries = [
  Country(code: 'US', name: 'Estados Unidos', flagEmoji: '🇺🇸', available: true),
  Country(code: 'MX', name: 'México', flagEmoji: '🇲🇽', available: false),
  Country(code: 'ES', name: 'España', flagEmoji: '🇪🇸', available: false),
  Country(code: 'AR', name: 'Argentina', flagEmoji: '🇦🇷', available: false),
];
