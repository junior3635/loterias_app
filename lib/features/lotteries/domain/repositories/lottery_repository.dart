import '../entities/lottery_result.dart';

/// Contrato que define QUÉ puede hacer el feature de loterías,
/// sin decir CÓMO (esa parte vive en la capa de `data`).
///
/// Esto permite:
/// - Testear la capa de dominio/presentación con un fake/mock.
/// - Cambiar de fuente de datos (API pública, scraping, backend propio)
///   sin tocar la UI.
abstract class LotteryRepository {
  /// Devuelve los últimos resultados disponibles para un país.
  Future<List<LotteryResult>> getLatestResults({required String countryCode});

  /// Devuelve TODOS los resultados disponibles, sin filtrar.
  /// Lo usa la sección "Sorteos" para filtrar en el cliente por
  /// país/estado. Cuando haya una API real, esto probablemente se
  /// reemplace por un endpoint que acepte los filtros como parámetros
  /// (ver PLAN.md → Fase 2).
  Future<List<LotteryResult>> getAllResults();

  /// Devuelve el historial de una lotería específica (ej. "powerball").
  Future<List<LotteryResult>> getHistory({
    required String lotteryId,
    int limit = 20,
  });
}
