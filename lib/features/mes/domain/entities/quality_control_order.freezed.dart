// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quality_control_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QualityControlOrder {

/// Mã lệnh kiểm tra - định danh duy nhất
 String get id;/// Công đoạn kiểm tra
 QualityControlStage get stage;/// Ghi chú từ bộ phận quản lý chất lượng
 String? get note;/// Số lượng cần kiểm tra theo kế hoạch
 int get plannedQuantity;/// Số lượng đã kiểm tra
 int get inspectedQuantity;/// Số lượng sản phẩm đạt yêu cầu
 int get passedQuantity;/// Số lượng sản phẩm lỗi
 int get failedQuantity;/// Trạng thái kiểm tra
 QualityControlStatus get status;/// Hạn kiểm tra
 DateTime get deadline;/// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
 DateTime? get completedDate;
/// Create a copy of QualityControlOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualityControlOrderCopyWith<QualityControlOrder> get copyWith => _$QualityControlOrderCopyWithImpl<QualityControlOrder>(this as QualityControlOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityControlOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.note, note) || other.note == note)&&(identical(other.plannedQuantity, plannedQuantity) || other.plannedQuantity == plannedQuantity)&&(identical(other.inspectedQuantity, inspectedQuantity) || other.inspectedQuantity == inspectedQuantity)&&(identical(other.passedQuantity, passedQuantity) || other.passedQuantity == passedQuantity)&&(identical(other.failedQuantity, failedQuantity) || other.failedQuantity == failedQuantity)&&(identical(other.status, status) || other.status == status)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,stage,note,plannedQuantity,inspectedQuantity,passedQuantity,failedQuantity,status,deadline,completedDate);

@override
String toString() {
  return 'QualityControlOrder(id: $id, stage: $stage, note: $note, plannedQuantity: $plannedQuantity, inspectedQuantity: $inspectedQuantity, passedQuantity: $passedQuantity, failedQuantity: $failedQuantity, status: $status, deadline: $deadline, completedDate: $completedDate)';
}


}

/// @nodoc
abstract mixin class $QualityControlOrderCopyWith<$Res>  {
  factory $QualityControlOrderCopyWith(QualityControlOrder value, $Res Function(QualityControlOrder) _then) = _$QualityControlOrderCopyWithImpl;
@useResult
$Res call({
 String id, QualityControlStage stage, String? note, int plannedQuantity, int inspectedQuantity, int passedQuantity, int failedQuantity, QualityControlStatus status, DateTime deadline, DateTime? completedDate
});




}
/// @nodoc
class _$QualityControlOrderCopyWithImpl<$Res>
    implements $QualityControlOrderCopyWith<$Res> {
  _$QualityControlOrderCopyWithImpl(this._self, this._then);

  final QualityControlOrder _self;
  final $Res Function(QualityControlOrder) _then;

/// Create a copy of QualityControlOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? stage = null,Object? note = freezed,Object? plannedQuantity = null,Object? inspectedQuantity = null,Object? passedQuantity = null,Object? failedQuantity = null,Object? status = null,Object? deadline = null,Object? completedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as QualityControlStage,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,plannedQuantity: null == plannedQuantity ? _self.plannedQuantity : plannedQuantity // ignore: cast_nullable_to_non_nullable
as int,inspectedQuantity: null == inspectedQuantity ? _self.inspectedQuantity : inspectedQuantity // ignore: cast_nullable_to_non_nullable
as int,passedQuantity: null == passedQuantity ? _self.passedQuantity : passedQuantity // ignore: cast_nullable_to_non_nullable
as int,failedQuantity: null == failedQuantity ? _self.failedQuantity : failedQuantity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QualityControlStatus,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _QualityControlOrder extends QualityControlOrder {
  const _QualityControlOrder({required this.id, required this.stage, this.note, required this.plannedQuantity, this.inspectedQuantity = 0, this.passedQuantity = 0, this.failedQuantity = 0, this.status = QualityControlStatus.pending, required this.deadline, this.completedDate}): super._();
  

/// Mã lệnh kiểm tra - định danh duy nhất
@override final  String id;
/// Công đoạn kiểm tra
@override final  QualityControlStage stage;
/// Ghi chú từ bộ phận quản lý chất lượng
@override final  String? note;
/// Số lượng cần kiểm tra theo kế hoạch
@override final  int plannedQuantity;
/// Số lượng đã kiểm tra
@override@JsonKey() final  int inspectedQuantity;
/// Số lượng sản phẩm đạt yêu cầu
@override@JsonKey() final  int passedQuantity;
/// Số lượng sản phẩm lỗi
@override@JsonKey() final  int failedQuantity;
/// Trạng thái kiểm tra
@override@JsonKey() final  QualityControlStatus status;
/// Hạn kiểm tra
@override final  DateTime deadline;
/// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
@override final  DateTime? completedDate;

/// Create a copy of QualityControlOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityControlOrderCopyWith<_QualityControlOrder> get copyWith => __$QualityControlOrderCopyWithImpl<_QualityControlOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityControlOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.note, note) || other.note == note)&&(identical(other.plannedQuantity, plannedQuantity) || other.plannedQuantity == plannedQuantity)&&(identical(other.inspectedQuantity, inspectedQuantity) || other.inspectedQuantity == inspectedQuantity)&&(identical(other.passedQuantity, passedQuantity) || other.passedQuantity == passedQuantity)&&(identical(other.failedQuantity, failedQuantity) || other.failedQuantity == failedQuantity)&&(identical(other.status, status) || other.status == status)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,stage,note,plannedQuantity,inspectedQuantity,passedQuantity,failedQuantity,status,deadline,completedDate);

@override
String toString() {
  return 'QualityControlOrder(id: $id, stage: $stage, note: $note, plannedQuantity: $plannedQuantity, inspectedQuantity: $inspectedQuantity, passedQuantity: $passedQuantity, failedQuantity: $failedQuantity, status: $status, deadline: $deadline, completedDate: $completedDate)';
}


}

/// @nodoc
abstract mixin class _$QualityControlOrderCopyWith<$Res> implements $QualityControlOrderCopyWith<$Res> {
  factory _$QualityControlOrderCopyWith(_QualityControlOrder value, $Res Function(_QualityControlOrder) _then) = __$QualityControlOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, QualityControlStage stage, String? note, int plannedQuantity, int inspectedQuantity, int passedQuantity, int failedQuantity, QualityControlStatus status, DateTime deadline, DateTime? completedDate
});




}
/// @nodoc
class __$QualityControlOrderCopyWithImpl<$Res>
    implements _$QualityControlOrderCopyWith<$Res> {
  __$QualityControlOrderCopyWithImpl(this._self, this._then);

  final _QualityControlOrder _self;
  final $Res Function(_QualityControlOrder) _then;

/// Create a copy of QualityControlOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? stage = null,Object? note = freezed,Object? plannedQuantity = null,Object? inspectedQuantity = null,Object? passedQuantity = null,Object? failedQuantity = null,Object? status = null,Object? deadline = null,Object? completedDate = freezed,}) {
  return _then(_QualityControlOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as QualityControlStage,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,plannedQuantity: null == plannedQuantity ? _self.plannedQuantity : plannedQuantity // ignore: cast_nullable_to_non_nullable
as int,inspectedQuantity: null == inspectedQuantity ? _self.inspectedQuantity : inspectedQuantity // ignore: cast_nullable_to_non_nullable
as int,passedQuantity: null == passedQuantity ? _self.passedQuantity : passedQuantity // ignore: cast_nullable_to_non_nullable
as int,failedQuantity: null == failedQuantity ? _self.failedQuantity : failedQuantity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QualityControlStatus,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
