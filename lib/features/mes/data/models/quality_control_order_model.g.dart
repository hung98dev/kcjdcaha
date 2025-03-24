// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_control_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QualityControlOrderModel _$QualityControlOrderModelFromJson(
  Map<String, dynamic> json,
) => _QualityControlOrderModel(
  id: json['id'] as String,
  stage: json['stage'] as String,
  note: json['note'] as String?,
  plannedQuantity: (json['plannedQuantity'] as num).toInt(),
  inspectedQuantity: (json['inspectedQuantity'] as num?)?.toInt() ?? 0,
  passedQuantity: (json['passedQuantity'] as num?)?.toInt() ?? 0,
  failedQuantity: (json['failedQuantity'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? 'pending',
  deadline: DateTime.parse(json['deadline'] as String),
  completedDate:
      json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
);

Map<String, dynamic> _$QualityControlOrderModelToJson(
  _QualityControlOrderModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'stage': instance.stage,
  'note': instance.note,
  'plannedQuantity': instance.plannedQuantity,
  'inspectedQuantity': instance.inspectedQuantity,
  'passedQuantity': instance.passedQuantity,
  'failedQuantity': instance.failedQuantity,
  'status': instance.status,
  'deadline': instance.deadline.toIso8601String(),
  'completedDate': instance.completedDate?.toIso8601String(),
};
