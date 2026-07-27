// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lottery_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LotteryResult {
  String get id => throw _privateConstructorUsedError;
  String get lotteryName =>
      throw _privateConstructorUsedError; // ej. "Powerball", "Mega Millions"
  String get country => throw _privateConstructorUsedError; // ej. "US"
  String? get state =>
      throw _privateConstructorUsedError; // ej. "Florida" (algunas loterías son estatales)
  DateTime get drawDate => throw _privateConstructorUsedError;
  List<int> get numbers => throw _privateConstructorUsedError;
  int? get bonusNumber =>
      throw _privateConstructorUsedError; // ej. Powerball number, Mega Ball
  double? get jackpotAmount => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  /// Create a copy of LotteryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LotteryResultCopyWith<LotteryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LotteryResultCopyWith<$Res> {
  factory $LotteryResultCopyWith(
          LotteryResult value, $Res Function(LotteryResult) then) =
      _$LotteryResultCopyWithImpl<$Res, LotteryResult>;
  @useResult
  $Res call(
      {String id,
      String lotteryName,
      String country,
      String? state,
      DateTime drawDate,
      List<int> numbers,
      int? bonusNumber,
      double? jackpotAmount,
      String? currency});
}

/// @nodoc
class _$LotteryResultCopyWithImpl<$Res, $Val extends LotteryResult>
    implements $LotteryResultCopyWith<$Res> {
  _$LotteryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LotteryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lotteryName = null,
    Object? country = null,
    Object? state = freezed,
    Object? drawDate = null,
    Object? numbers = null,
    Object? bonusNumber = freezed,
    Object? jackpotAmount = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lotteryName: null == lotteryName
          ? _value.lotteryName
          : lotteryName // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      drawDate: null == drawDate
          ? _value.drawDate
          : drawDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      bonusNumber: freezed == bonusNumber
          ? _value.bonusNumber
          : bonusNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      jackpotAmount: freezed == jackpotAmount
          ? _value.jackpotAmount
          : jackpotAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LotteryResultImplCopyWith<$Res>
    implements $LotteryResultCopyWith<$Res> {
  factory _$$LotteryResultImplCopyWith(
          _$LotteryResultImpl value, $Res Function(_$LotteryResultImpl) then) =
      __$$LotteryResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String lotteryName,
      String country,
      String? state,
      DateTime drawDate,
      List<int> numbers,
      int? bonusNumber,
      double? jackpotAmount,
      String? currency});
}

/// @nodoc
class __$$LotteryResultImplCopyWithImpl<$Res>
    extends _$LotteryResultCopyWithImpl<$Res, _$LotteryResultImpl>
    implements _$$LotteryResultImplCopyWith<$Res> {
  __$$LotteryResultImplCopyWithImpl(
      _$LotteryResultImpl _value, $Res Function(_$LotteryResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of LotteryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lotteryName = null,
    Object? country = null,
    Object? state = freezed,
    Object? drawDate = null,
    Object? numbers = null,
    Object? bonusNumber = freezed,
    Object? jackpotAmount = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$LotteryResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lotteryName: null == lotteryName
          ? _value.lotteryName
          : lotteryName // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      drawDate: null == drawDate
          ? _value.drawDate
          : drawDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numbers: null == numbers
          ? _value._numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      bonusNumber: freezed == bonusNumber
          ? _value.bonusNumber
          : bonusNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      jackpotAmount: freezed == jackpotAmount
          ? _value.jackpotAmount
          : jackpotAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LotteryResultImpl implements _LotteryResult {
  const _$LotteryResultImpl(
      {required this.id,
      required this.lotteryName,
      required this.country,
      this.state,
      required this.drawDate,
      required final List<int> numbers,
      this.bonusNumber,
      this.jackpotAmount,
      this.currency})
      : _numbers = numbers;

  @override
  final String id;
  @override
  final String lotteryName;
// ej. "Powerball", "Mega Millions"
  @override
  final String country;
// ej. "US"
  @override
  final String? state;
// ej. "Florida" (algunas loterías son estatales)
  @override
  final DateTime drawDate;
  final List<int> _numbers;
  @override
  List<int> get numbers {
    if (_numbers is EqualUnmodifiableListView) return _numbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_numbers);
  }

  @override
  final int? bonusNumber;
// ej. Powerball number, Mega Ball
  @override
  final double? jackpotAmount;
  @override
  final String? currency;

  @override
  String toString() {
    return 'LotteryResult(id: $id, lotteryName: $lotteryName, country: $country, state: $state, drawDate: $drawDate, numbers: $numbers, bonusNumber: $bonusNumber, jackpotAmount: $jackpotAmount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LotteryResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lotteryName, lotteryName) ||
                other.lotteryName == lotteryName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.drawDate, drawDate) ||
                other.drawDate == drawDate) &&
            const DeepCollectionEquality().equals(other._numbers, _numbers) &&
            (identical(other.bonusNumber, bonusNumber) ||
                other.bonusNumber == bonusNumber) &&
            (identical(other.jackpotAmount, jackpotAmount) ||
                other.jackpotAmount == jackpotAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lotteryName,
      country,
      state,
      drawDate,
      const DeepCollectionEquality().hash(_numbers),
      bonusNumber,
      jackpotAmount,
      currency);

  /// Create a copy of LotteryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LotteryResultImplCopyWith<_$LotteryResultImpl> get copyWith =>
      __$$LotteryResultImplCopyWithImpl<_$LotteryResultImpl>(this, _$identity);
}

abstract class _LotteryResult implements LotteryResult {
  const factory _LotteryResult(
      {required final String id,
      required final String lotteryName,
      required final String country,
      final String? state,
      required final DateTime drawDate,
      required final List<int> numbers,
      final int? bonusNumber,
      final double? jackpotAmount,
      final String? currency}) = _$LotteryResultImpl;

  @override
  String get id;
  @override
  String get lotteryName; // ej. "Powerball", "Mega Millions"
  @override
  String get country; // ej. "US"
  @override
  String? get state; // ej. "Florida" (algunas loterías son estatales)
  @override
  DateTime get drawDate;
  @override
  List<int> get numbers;
  @override
  int? get bonusNumber; // ej. Powerball number, Mega Ball
  @override
  double? get jackpotAmount;
  @override
  String? get currency;

  /// Create a copy of LotteryResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LotteryResultImplCopyWith<_$LotteryResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
