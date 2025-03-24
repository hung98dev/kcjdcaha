// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {

 String get id;// ID duy nhất của user
 String get email;// Email của user, dùng để đăng nhập
 String get fullName;// Tên đầy đủ của user
 String? get photoUrl;// URL ảnh đại diện, có thể null
 List<String> get roles;// Danh sách các vai trò của user
 bool get isActive;// Trạng thái hoạt động của user
 DateTime get createdAt;// Thời điểm tạo tài khoản
 DateTime? get lastLogin;// Thời điểm đăng nhập cuối cùng, có thể null
 String? get token;// Token xác thực, có thể null
 DateTime? get tokenExpiry;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenExpiry, tokenExpiry) || other.tokenExpiry == tokenExpiry));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,fullName,photoUrl,const DeepCollectionEquality().hash(roles),isActive,createdAt,lastLogin,token,tokenExpiry);

@override
String toString() {
  return 'User(id: $id, email: $email, fullName: $fullName, photoUrl: $photoUrl, roles: $roles, isActive: $isActive, createdAt: $createdAt, lastLogin: $lastLogin, token: $token, tokenExpiry: $tokenExpiry)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String fullName, String? photoUrl, List<String> roles, bool isActive, DateTime createdAt, DateTime? lastLogin, String? token, DateTime? tokenExpiry
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? photoUrl = freezed,Object? roles = null,Object? isActive = null,Object? createdAt = null,Object? lastLogin = freezed,Object? token = freezed,Object? tokenExpiry = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiry: freezed == tokenExpiry ? _self.tokenExpiry : tokenExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _User implements User {
  const _User({required this.id, required this.email, required this.fullName, this.photoUrl, required final  List<String> roles, required this.isActive, required this.createdAt, this.lastLogin, this.token, this.tokenExpiry}): _roles = roles;
  

@override final  String id;
// ID duy nhất của user
@override final  String email;
// Email của user, dùng để đăng nhập
@override final  String fullName;
// Tên đầy đủ của user
@override final  String? photoUrl;
// URL ảnh đại diện, có thể null
 final  List<String> _roles;
// URL ảnh đại diện, có thể null
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

// Danh sách các vai trò của user
@override final  bool isActive;
// Trạng thái hoạt động của user
@override final  DateTime createdAt;
// Thời điểm tạo tài khoản
@override final  DateTime? lastLogin;
// Thời điểm đăng nhập cuối cùng, có thể null
@override final  String? token;
// Token xác thực, có thể null
@override final  DateTime? tokenExpiry;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenExpiry, tokenExpiry) || other.tokenExpiry == tokenExpiry));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,fullName,photoUrl,const DeepCollectionEquality().hash(_roles),isActive,createdAt,lastLogin,token,tokenExpiry);

@override
String toString() {
  return 'User(id: $id, email: $email, fullName: $fullName, photoUrl: $photoUrl, roles: $roles, isActive: $isActive, createdAt: $createdAt, lastLogin: $lastLogin, token: $token, tokenExpiry: $tokenExpiry)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String fullName, String? photoUrl, List<String> roles, bool isActive, DateTime createdAt, DateTime? lastLogin, String? token, DateTime? tokenExpiry
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? photoUrl = freezed,Object? roles = null,Object? isActive = null,Object? createdAt = null,Object? lastLogin = freezed,Object? token = freezed,Object? tokenExpiry = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiry: freezed == tokenExpiry ? _self.tokenExpiry : tokenExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
