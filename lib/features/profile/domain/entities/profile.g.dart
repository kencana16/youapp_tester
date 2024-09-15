// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      imageBytes: _$JsonConverterFromJson<String, Uint8List>(
          json['imageBytes'], const Uint8ListJsonConverter().fromJson),
      email: json['email'] as String?,
      username: json['username'] as String?,
      imageUrl: json['imageUrl'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      name: json['name'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'imageBytes': _$JsonConverterToJson<String, Uint8List>(
          instance.imageBytes, const Uint8ListJsonConverter().toJson),
      'email': instance.email,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
      'gender': _$GenderEnumMap[instance.gender],
      'name': instance.name,
      'birthday': instance.birthday?.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'interests': instance.interests,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
