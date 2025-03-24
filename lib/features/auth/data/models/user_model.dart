import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String fullName,
    String? photoUrl,
    required List<String> roles,
    required bool isActive,
    required DateTime createdAt,
    DateTime? lastLogin,
    String? token,
    DateTime? tokenExpiry,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    fullName: user.fullName,
    photoUrl: user.photoUrl,
    roles: user.roles,
    isActive: user.isActive,
    createdAt: user.createdAt,
    lastLogin: user.lastLogin,
    token: user.token,
    tokenExpiry: user.tokenExpiry,
  );

  User toEntity() => User(
    id: id,
    email: email,
    fullName: fullName,
    photoUrl: photoUrl,
    roles: roles,
    isActive: isActive,
    createdAt: createdAt,
    lastLogin: lastLogin,
    token: token,
    tokenExpiry: tokenExpiry,
  );
}
