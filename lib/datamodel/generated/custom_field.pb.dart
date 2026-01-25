// This is a generated file - do not edit.
//
// Generated from custom_field.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'character.pbenum.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CustomField extends $pb.GeneratedMessage {
  factory CustomField({
    $core.String? id,
    $core.String? name,
    $core.bool? enabledCharacter,
    $core.bool? enabledCombat,
    $core.Iterable<$0.CharacterType>? enabledCharacterTypes,
    $core.String? shortName,
    $core.bool? builtIn,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (enabledCharacter != null) result.enabledCharacter = enabledCharacter;
    if (enabledCombat != null) result.enabledCombat = enabledCombat;
    if (enabledCharacterTypes != null)
      result.enabledCharacterTypes.addAll(enabledCharacterTypes);
    if (shortName != null) result.shortName = shortName;
    if (builtIn != null) result.builtIn = builtIn;
    return result;
  }

  CustomField._();

  factory CustomField.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomField.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomField',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'enabledCharacter',
        protoName: 'enabledCharacter')
    ..aOB(4, _omitFieldNames ? '' : 'enabledCombat', protoName: 'enabledCombat')
    ..pc<$0.CharacterType>(
        5, _omitFieldNames ? '' : 'enabledCharacterTypes', $pb.PbFieldType.KE,
        protoName: 'enabledCharacterTypes',
        valueOf: $0.CharacterType.valueOf,
        enumValues: $0.CharacterType.values,
        defaultEnumValue: $0.CharacterType.Player)
    ..aOS(6, _omitFieldNames ? '' : 'shortName', protoName: 'shortName')
    ..aOB(7, _omitFieldNames ? '' : 'builtIn', protoName: 'builtIn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomField clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomField copyWith(void Function(CustomField) updates) =>
      super.copyWith((message) => updates(message as CustomField))
          as CustomField;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomField create() => CustomField._();
  @$core.override
  CustomField createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CustomField getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomField>(create);
  static CustomField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get enabledCharacter => $_getBF(2);
  @$pb.TagNumber(3)
  set enabledCharacter($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEnabledCharacter() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnabledCharacter() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get enabledCombat => $_getBF(3);
  @$pb.TagNumber(4)
  set enabledCombat($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEnabledCombat() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnabledCombat() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$0.CharacterType> get enabledCharacterTypes => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get shortName => $_getSZ(5);
  @$pb.TagNumber(6)
  set shortName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasShortName() => $_has(5);
  @$pb.TagNumber(6)
  void clearShortName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get builtIn => $_getBF(6);
  @$pb.TagNumber(7)
  set builtIn($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBuiltIn() => $_has(6);
  @$pb.TagNumber(7)
  void clearBuiltIn() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
