// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModal _$ProfileModalFromJson(Map<String, dynamic> json) => ProfileModal(
  name: json['name'] as String,
  address: json['address'] as String,
  number: (json['number'] as num?)?.toInt(),
  age: (json['age'] as num).toInt(),
);

Map<String, dynamic> _$ProfileModalToJson(ProfileModal instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'number': instance.number,
      'age': instance.age,
    };
