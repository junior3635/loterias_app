// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryResultModel _$LotteryResultModelFromJson(Map<String, dynamic> json) =>
    LotteryResultModel(
      id: json['id'] as String,
      lotteryName: json['lotteryName'] as String,
      country: json['country'] as String,
      state: json['state'] as String?,
      drawDate: DateTime.parse(json['drawDate'] as String),
      numbers: (json['numbers'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      bonusNumber: (json['bonusNumber'] as num?)?.toInt(),
      jackpotAmount: (json['jackpotAmount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$LotteryResultModelToJson(LotteryResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lotteryName': instance.lotteryName,
      'country': instance.country,
      'state': instance.state,
      'drawDate': instance.drawDate.toIso8601String(),
      'numbers': instance.numbers,
      'bonusNumber': instance.bonusNumber,
      'jackpotAmount': instance.jackpotAmount,
      'currency': instance.currency,
    };
