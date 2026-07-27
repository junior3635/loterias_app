import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/lottery_result.dart';

part 'lottery_result_model.g.dart';

/// DTO (Data Transfer Object): representa el JSON tal cual viene de la API.
/// Se mantiene separado de la entidad de dominio a propósito, para que
/// si la API cambia sus campos, solo se ajuste este archivo.
@JsonSerializable()
class LotteryResultModel {
  LotteryResultModel({
    required this.id,
    required this.lotteryName,
    required this.country,
    this.state,
    required this.drawDate,
    required this.numbers,
    this.bonusNumber,
    this.jackpotAmount,
    this.currency,
  });

  factory LotteryResultModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryResultModelFromJson(json);

  final String id;
  final String lotteryName;
  final String country;
  final String? state;
  final DateTime drawDate;
  final List<int> numbers;
  final int? bonusNumber;
  final double? jackpotAmount;
  final String? currency;

  Map<String, dynamic> toJson() => _$LotteryResultModelToJson(this);

  /// Convierte el DTO a la entidad de dominio que usa el resto de la app.
  LotteryResult toEntity() => LotteryResult(
        id: id,
        lotteryName: lotteryName,
        country: country,
        state: state,
        drawDate: drawDate,
        numbers: numbers,
        bonusNumber: bonusNumber,
        jackpotAmount: jackpotAmount,
        currency: currency,
      );
}
