
import 'package:json_annotation/json_annotation.dart';

part 'taskModal.g.dart';


@JsonSerializable()
class TaskModal{
   String taskName;
   String taskDescrption;

  TaskModal({
    required this.taskName,
    required this.taskDescrption,
  });


factory TaskModal.fromJson(Map<String,dynamic> json) => _$TaskModalFromJson(json);
Map<String,dynamic> toJson() => _$TaskModalToJson(this);

}