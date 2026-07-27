import '../../domain/entities/lottery_result.dart';
import '../../domain/repositories/lottery_repository.dart';

/// Implementación MOCK del repositorio.
///
/// Objetivo: que el proyecto compile y se pueda ver la UI funcionando
/// desde el día 1, sin depender todavía de una API externa definida.
///
/// Cuando se resuelva la fuente de datos real (PLAN.md → Fase 2),
/// se crea `LotteryRepositoryImpl` usando `LotteryRemoteDataSourceImpl`
/// y se cambia el binding en `providers/lottery_providers.dart`.
class LotteryRepositoryMockImpl implements LotteryRepository {
  @override
  Future<List<LotteryResult>> getLatestResults({
    required String countryCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockResults;
  }

  @override
  Future<List<LotteryResult>> getHistory({
    required String lotteryId,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockResults
        .where((r) => r.lotteryName.toLowerCase() == lotteryId.toLowerCase())
        .take(limit)
        .toList();
  }

  @override
  Future<List<LotteryResult>> getAllResults() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockResults;
  }

  static final List<LotteryResult> _mockResults = [
    // --- Loterías nacionales (no atadas a un estado) ---
    LotteryResult(
      id: '1',
      lotteryName: 'Powerball',
      country: 'US',
      drawDate: DateTime.now().subtract(const Duration(days: 1)),
      numbers: const [4, 19, 27, 46, 55],
      bonusNumber: 12,
      jackpotAmount: 152000000,
      currency: 'USD',
    ),
    LotteryResult(
      id: '2',
      lotteryName: 'Mega Millions',
      country: 'US',
      drawDate: DateTime.now().subtract(const Duration(days: 2)),
      numbers: const [7, 15, 22, 34, 41],
      bonusNumber: 6,
      jackpotAmount: 89000000,
      currency: 'USD',
    ),
    // --- Loterías estatales ---
    LotteryResult(
      id: '3',
      lotteryName: 'Florida Lotto',
      country: 'US',
      state: 'Florida',
      drawDate: DateTime.now().subtract(const Duration(days: 1)),
      numbers: const [3, 11, 18, 29, 33, 44],
      currency: 'USD',
    ),
    LotteryResult(
      id: '4',
      lotteryName: 'California Fantasy 5',
      country: 'US',
      state: 'California',
      drawDate: DateTime.now().subtract(const Duration(days: 1)),
      numbers: const [2, 14, 21, 28, 39],
      currency: 'USD',
    ),
    LotteryResult(
      id: '5',
      lotteryName: 'New York Take 5',
      country: 'US',
      state: 'New York',
      drawDate: DateTime.now().subtract(const Duration(hours: 12)),
      numbers: const [5, 9, 16, 24, 37],
      currency: 'USD',
    ),
    LotteryResult(
      id: '6',
      lotteryName: 'Texas Cash Five',
      country: 'US',
      state: 'Texas',
      drawDate: DateTime.now().subtract(const Duration(days: 2)),
      numbers: const [8, 13, 19, 25, 33],
      currency: 'USD',
    ),
  ];
}
