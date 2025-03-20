import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_ops/features/auth/domain/entities/role.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
abstract class RoleModel with _$RoleModel {
  const RoleModel._();

  const factory RoleModel({
    required String id,
    required String name,
    required String description,
    required List<String> permissions,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  factory RoleModel.fromEntity(Role role) => RoleModel(
    id: role.id,
    name: role.name,
    description: role.description,
    permissions: role.permissions,
  );

  Role toEntity() => Role(
    id: id,
    name: name,
    description: description,
    permissions: permissions,
  );
}