import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:continuum/data/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime lastCheckInAt,
    @TimestampConverter() DateTime? updatedAt,
    String? fcmToken,
    // basic info
    @Default('Unknown') String name,
    String? email,
    String? photoUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json, String id) =>
      _$UserFromJson({...json, 'id': id});
}
