// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductionOrderModel _$ProductionOrderModelFromJson(
  Map<String, dynamic> json,
) => _ProductionOrderModel(
  id: json['id'] as String,
  priority: json['priority'] as String,
  note: json['note'] as String?,
  plannedQuantity: (json['plannedQuantity'] as num).toInt(),
  completedQuantity: (json['completedQuantity'] as num?)?.toInt() ?? 0,
  plannedStartDate: DateTime.parse(json['plannedStartDate'] as String),
  plannedEndDate: DateTime.parse(json['plannedEndDate'] as String),
  actualEndDate:
      json['actualEndDate'] == null
          ? null
          : DateTime.parse(json['actualEndDate'] as String),
);

Map<String, dynamic> _$ProductionOrderModelToJson(
  _ProductionOrderModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'priority': instance.priority,
  'note': instance.note,
  'plannedQuantity': instance.plannedQuantity,
  'completedQuantity': instance.completedQuantity,
  'plannedStartDate': instance.plannedStartDate.toIso8601String(),
  'plannedEndDate': instance.plannedEndDate.toIso8601String(),
  'actualEndDate': instance.actualEndDate?.toIso8601String(),
};
