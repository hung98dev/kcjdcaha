// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quality_control_order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QualityControlOrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityControlOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderEvent()';
}


}

/// @nodoc
class $QualityControlOrderEventCopyWith<$Res>  {
$QualityControlOrderEventCopyWith(QualityControlOrderEvent _, $Res Function(QualityControlOrderEvent) __);
}


/// @nodoc


class LoadQualityControlOrders implements QualityControlOrderEvent {
  const LoadQualityControlOrders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadQualityControlOrders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderEvent.loadQualityControlOrders()';
}


}




/// @nodoc


class LoadMoreQualityControlOrders implements QualityControlOrderEvent {
  const LoadMoreQualityControlOrders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreQualityControlOrders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderEvent.loadMoreQualityControlOrders()';
}


}




/// @nodoc


class SearchQualityControlOrders implements QualityControlOrderEvent {
  const SearchQualityControlOrders({required this.keyword});
  

 final  String keyword;

/// Create a copy of QualityControlOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQualityControlOrdersCopyWith<SearchQualityControlOrders> get copyWith => _$SearchQualityControlOrdersCopyWithImpl<SearchQualityControlOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQualityControlOrders&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'QualityControlOrderEvent.searchQualityControlOrders(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $SearchQualityControlOrdersCopyWith<$Res> implements $QualityControlOrderEventCopyWith<$Res> {
  factory $SearchQualityControlOrdersCopyWith(SearchQualityControlOrders value, $Res Function(SearchQualityControlOrders) _then) = _$SearchQualityControlOrdersCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$SearchQualityControlOrdersCopyWithImpl<$Res>
    implements $SearchQualityControlOrdersCopyWith<$Res> {
  _$SearchQualityControlOrdersCopyWithImpl(this._self, this._then);

  final SearchQualityControlOrders _self;
  final $Res Function(SearchQualityControlOrders) _then;

/// Create a copy of QualityControlOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(SearchQualityControlOrders(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClearQualityControlOrderSearch implements QualityControlOrderEvent {
  const ClearQualityControlOrderSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearQualityControlOrderSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderEvent.clearQualityControlOrderSearch()';
}


}




/// @nodoc


class RefreshQualityControlOrders implements QualityControlOrderEvent {
  const RefreshQualityControlOrders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshQualityControlOrders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderEvent.refreshQualityControlOrders()';
}


}




/// @nodoc
mixin _$QualityControlOrderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityControlOrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderState()';
}


}

/// @nodoc
class $QualityControlOrderStateCopyWith<$Res>  {
$QualityControlOrderStateCopyWith(QualityControlOrderState _, $Res Function(QualityControlOrderState) __);
}


/// @nodoc


class Initial implements QualityControlOrderState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderState.initial()';
}


}




/// @nodoc


class Loading implements QualityControlOrderState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderState.loading()';
}


}




/// @nodoc


class LoadingMore implements QualityControlOrderState {
  const LoadingMore({required final  List<QualityControlOrder> currentOrders, required this.currentPage}): _currentOrders = currentOrders;
  

 final  List<QualityControlOrder> _currentOrders;
 List<QualityControlOrder> get currentOrders {
  if (_currentOrders is EqualUnmodifiableListView) return _currentOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentOrders);
}

 final  int currentPage;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingMoreCopyWith<LoadingMore> get copyWith => _$LoadingMoreCopyWithImpl<LoadingMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingMore&&const DeepCollectionEquality().equals(other._currentOrders, _currentOrders)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currentOrders),currentPage);

@override
String toString() {
  return 'QualityControlOrderState.loadingMore(currentOrders: $currentOrders, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $LoadingMoreCopyWith<$Res> implements $QualityControlOrderStateCopyWith<$Res> {
  factory $LoadingMoreCopyWith(LoadingMore value, $Res Function(LoadingMore) _then) = _$LoadingMoreCopyWithImpl;
@useResult
$Res call({
 List<QualityControlOrder> currentOrders, int currentPage
});




}
/// @nodoc
class _$LoadingMoreCopyWithImpl<$Res>
    implements $LoadingMoreCopyWith<$Res> {
  _$LoadingMoreCopyWithImpl(this._self, this._then);

  final LoadingMore _self;
  final $Res Function(LoadingMore) _then;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentOrders = null,Object? currentPage = null,}) {
  return _then(LoadingMore(
currentOrders: null == currentOrders ? _self._currentOrders : currentOrders // ignore: cast_nullable_to_non_nullable
as List<QualityControlOrder>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Loaded implements QualityControlOrderState {
  const Loaded({required final  List<QualityControlOrder> orders, required this.currentPage, required this.hasReachedMax}): _orders = orders;
  

 final  List<QualityControlOrder> _orders;
 List<QualityControlOrder> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  int currentPage;
 final  bool hasReachedMax;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),currentPage,hasReachedMax);

@override
String toString() {
  return 'QualityControlOrderState.loaded(orders: $orders, currentPage: $currentPage, hasReachedMax: $hasReachedMax)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $QualityControlOrderStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<QualityControlOrder> orders, int currentPage, bool hasReachedMax
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? currentPage = null,Object? hasReachedMax = null,}) {
  return _then(Loaded(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<QualityControlOrder>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Searching implements QualityControlOrderState {
  const Searching();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Searching);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QualityControlOrderState.searching()';
}


}




/// @nodoc


class SearchResult implements QualityControlOrderState {
  const SearchResult({required final  List<QualityControlOrder> orders, required this.keyword}): _orders = orders;
  

 final  List<QualityControlOrder> _orders;
 List<QualityControlOrder> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  String keyword;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultCopyWith<SearchResult> get copyWith => _$SearchResultCopyWithImpl<SearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResult&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),keyword);

@override
String toString() {
  return 'QualityControlOrderState.searchResult(orders: $orders, keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $SearchResultCopyWith<$Res> implements $QualityControlOrderStateCopyWith<$Res> {
  factory $SearchResultCopyWith(SearchResult value, $Res Function(SearchResult) _then) = _$SearchResultCopyWithImpl;
@useResult
$Res call({
 List<QualityControlOrder> orders, String keyword
});




}
/// @nodoc
class _$SearchResultCopyWithImpl<$Res>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._self, this._then);

  final SearchResult _self;
  final $Res Function(SearchResult) _then;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? keyword = null,}) {
  return _then(SearchResult(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<QualityControlOrder>,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Error implements QualityControlOrderState {
  const Error({required this.message});
  

 final  String message;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'QualityControlOrderState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $QualityControlOrderStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of QualityControlOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
