// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductionOrder {

/// Mã lệnh sản xuất - định danh duy nhất
 String get id;/// Mức độ ưu tiên của lệnh sản xuất
 PriorityLevel get priority;/// Ghi chú từ bộ phận quản lý sản xuất
 String? get note;/// Số lượng cần sản xuất theo kế hoạch
 int get plannedQuantity;/// Số lượng đã sản xuất (hoàn thành)
 int get completedQuantity;/// Ngày bắt đầu sản xuất theo kế hoạch
 DateTime get plannedStartDate;/// Ngày kết thúc dự kiến
 DateTime get plannedEndDate;/// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
 DateTime? get actualEndDate;
/// Create a copy of ProductionOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductionOrderCopyWith<ProductionOrder> get copyWith => _$ProductionOrderCopyWithImpl<ProductionOrder>(this as ProductionOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductionOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.note, note) || other.note == note)&&(identical(other.plannedQuantity, plannedQuantity) || other.plannedQuantity == plannedQuantity)&&(identical(other.completedQuantity, completedQuantity) || other.completedQuantity == completedQuantity)&&(identical(other.plannedStartDate, plannedStartDate) || other.plannedStartDate == plannedStartDate)&&(identical(other.plannedEndDate, plannedEndDate) || other.plannedEndDate == plannedEndDate)&&(identical(other.actualEndDate, actualEndDate) || other.actualEndDate == actualEndDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,priority,note,plannedQuantity,completedQuantity,plannedStartDate,plannedEndDate,actualEndDate);

@override
String toString() {
  return 'ProductionOrder(id: $id, priority: $priority, note: $note, plannedQuantity: $plannedQuantity, completedQuantity: $completedQuantity, plannedStartDate: $plannedStartDate, plannedEndDate: $plannedEndDate, actualEndDate: $actualEndDate)';
}


}

/// @nodoc
abstract mixin class $ProductionOrderCopyWith<$Res>  {
  factory $ProductionOrderCopyWith(ProductionOrder value, $Res Function(ProductionOrder) _then) = _$ProductionOrderCopyWithImpl;
@useResult
$Res call({
 String id, PriorityLevel priority, String? note, int plannedQuantity, int completedQuantity, DateTime plannedStartDate, DateTime plannedEndDate, DateTime? actualEndDate
});




}
/// @nodoc
class _$ProductionOrderCopyWithImpl<$Res>
    implements $ProductionOrderCopyWith<$Res> {
  _$ProductionOrderCopyWithImpl(this._self, this._then);

  final ProductionOrder _self;
  final $Res Function(ProductionOrder) _then;

/// Create a copy of ProductionOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? priority = null,Object? note = freezed,Object? plannedQuantity = null,Object? completedQuantity = null,Object? plannedStartDate = null,Object? plannedEndDate = null,Object? actualEndDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as PriorityLevel,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,plannedQuantity: null == plannedQuantity ? _self.plannedQuantity : plannedQuantity // ignore: cast_nullable_to_non_nullable
as int,completedQuantity: null == completedQuantity ? _self.completedQuantity : completedQuantity // ignore: cast_nullable_to_non_nullable
as int,plannedStartDate: null == plannedStartDate ? _self.plannedStartDate : plannedStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,plannedEndDate: null == plannedEndDate ? _self.plannedEndDate : plannedEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,actualEndDate: freezed == actualEndDate ? _self.actualEndDate : actualEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _ProductionOrder extends ProductionOrder {
  const _ProductionOrder({required this.id, required this.priority, this.note, required this.plannedQuantity, this.completedQuantity = 0, required this.plannedStartDate, required this.plannedEndDate, this.actualEndDate}): super._();
  

/// Mã lệnh sản xuất - định danh duy nhất
@override final  String id;
/// Mức độ ưu tiên của lệnh sản xuất
@override final  PriorityLevel priority;
/// Ghi chú từ bộ phận quản lý sản xuất
@override final  String? note;
/// Số lượng cần sản xuất theo kế hoạch
@override final  int plannedQuantity;
/// Số lượng đã sản xuất (hoàn thành)
@override@JsonKey() final  int completedQuantity;
/// Ngày bắt đầu sản xuất theo kế hoạch
@override final  DateTime plannedStartDate;
/// Ngày kết thúc dự kiến
@override final  DateTime plannedEndDate;
/// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
@override final  DateTime? actualEndDate;

/// Create a copy of ProductionOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductionOrderCopyWith<_ProductionOrder> get copyWith => __$ProductionOrderCopyWithImpl<_ProductionOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductionOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.note, note) || other.note == note)&&(identical(other.plannedQuantity, plannedQuantity) || other.plannedQuantity == plannedQuantity)&&(identical(other.completedQuantity, completedQuantity) || other.completedQuantity == completedQuantity)&&(identical(other.plannedStartDate, plannedStartDate) || other.plannedStartDate == plannedStartDate)&&(identical(other.plannedEndDate, plannedEndDate) || other.plannedEndDate == plannedEndDate)&&(identical(other.actualEndDate, actualEndDate) || other.actualEndDate == actualEndDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,priority,note,plannedQuantity,completedQuantity,plannedStartDate,plannedEndDate,actualEndDate);

@override
String toString() {
  return 'ProductionOrder(id: $id, priority: $priority, note: $note, plannedQuantity: $plannedQuantity, completedQuantity: $completedQuantity, plannedStartDate: $plannedStartDate, plannedEndDate: $plannedEndDate, actualEndDate: $actualEndDate)';
}


}

/// @nodoc
abstract mixin class _$ProductionOrderCopyWith<$Res> implements $ProductionOrderCopyWith<$Res> {
  factory _$ProductionOrderCopyWith(_ProductionOrder value, $Res Function(_ProductionOrder) _then) = __$ProductionOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, PriorityLevel priority, String? note, int plannedQuantity, int completedQuantity, DateTime plannedStartDate, DateTime plannedEndDate, DateTime? actualEndDate
});




}
/// @nodoc
class __$ProductionOrderCopyWithImpl<$Res>
    implements _$ProductionOrderCopyWith<$Res> {
  __$ProductionOrderCopyWithImpl(this._self, this._then);

  final _ProductionOrder _self;
  final $Res Function(_ProductionOrder) _then;

/// Create a copy of ProductionOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? priority = null,Object? note = freezed,Object? plannedQuantity = null,Object? completedQuantity = null,Object? plannedStartDate = null,Object? plannedEndDate = null,Object? actualEndDate = freezed,}) {
  return _then(_ProductionOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as PriorityLevel,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,plannedQuantity: null == plannedQuantity ? _self.plannedQuantity : plannedQuantity // ignore: cast_nullable_to_non_nullable
as int,completedQuantity: null == completedQuantity ? _self.completedQuantity : completedQuantity // ignore: cast_nullable_to_non_nullable
as int,plannedStartDate: null == plannedStartDate ? _self.plannedStartDate : plannedStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,plannedEndDate: null == plannedEndDate ? _self.plannedEndDate : plannedEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,actualEndDate: freezed == actualEndDate ? _self.actualEndDate : actualEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
