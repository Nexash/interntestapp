import 'package:json_annotation/json_annotation.dart';
part 'profileModal.g.dart';

@JsonSerializable()
class ProfileModal {

  final String name;
  final String address;
  final int? number;
  final int age;

  ProfileModal({
    required this.name,
    required this.address,
    this.number,
    required this.age,
  });

factory ProfileModal.fromJson(Map<String,dynamic>json) => _$ProfileModalFromJson(json);
  Map<String,dynamic> toJson() => _$ProfileModalToJson(this);

}