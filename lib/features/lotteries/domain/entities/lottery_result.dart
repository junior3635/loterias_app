import 'package:freezed_annotation/freezed_annotation.dart';

part 'lottery_result.freezed.dart';

/// Representa el resultado de un sorteo de lotería.
///
/// Es una entidad de DOMINIO: no sabe nada de JSON, HTTP ni UI.
/// Mantenerla "pura" facilita testear la lógica de negocio sin mocks pesados.
@freezed
class LotteryResult with _$LotteryResult {
  const factory LotteryResult({
    required String id,
    required String lotteryName, // ej. "Powerball", "Mega Millions"
    required String country, // ej. "US"
    String? state, // ej. "Florida" (algunas loterías son estatales)
    required DateTime drawDate,
    required List<int> numbers,
    int? bonusNumber, // ej. Powerball number, Mega Ball
    double? jackpotAmount,
    String? currency, // ej. "USD"
  }) = _LotteryResult;
}
