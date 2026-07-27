import '../models/lottery_result_model.dart';

/// Contrato de la fuente de datos remota.
abstract class LotteryRemoteDataSource {
  Future<List<LotteryResultModel>> fetchLatestResults(String countryCode);
  Future<List<LotteryResultModel>> fetchHistory(String lotteryId, int limit);
}

/// NOTA IMPORTANTE (ver PLAN.md → "Fuentes de datos"):
/// Aún no hemos decidido/confirmado la API oficial a consumir para
/// Powerball / Mega Millions / loterías estatales de EE.UU.
/// Opciones típicas:
///   1. API no oficial de terceros (rápida pero menos confiable).
///   2. Scraping de los sitios oficiales (powerball.com, megamillions.com).
///   3. Backend propio (Cloud Function) que centraliza y cachea resultados.
/// Esta clase queda como contrato; la implementación concreta se agrega
/// cuando se decida la fuente (Fase 2).
class LotteryRemoteDataSourceImpl implements LotteryRemoteDataSource {
  LotteryRemoteDataSourceImpl();

  @override
  Future<List<LotteryResultModel>> fetchLatestResults(
    String countryCode,
  ) async {
    throw UnimplementedError(
      'Falta definir la fuente de datos real. Ver PLAN.md → Fase 2.',
    );
  }

  @override
  Future<List<LotteryResultModel>> fetchHistory(
    String lotteryId,
    int limit,
  ) async {
    throw UnimplementedError(
      'Falta definir la fuente de datos real. Ver PLAN.md → Fase 2.',
    );
  }
}
