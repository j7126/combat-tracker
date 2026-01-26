// This is a generated file - do not edit.
//
// Generated from combat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

import 'character.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Combat extends $pb.GeneratedMessage {
  factory Combat({
    $core.Iterable<$0.Character>? characters,
    $core.String? currentTurn,
    $core.String? activePlayer,
    $core.String? name,
    $1.Timestamp? createdTimestamp,
    $core.String? id,
    $core.int? round,
  }) {
    final result = create();
    if (characters != null) result.characters.addAll(characters);
    if (currentTurn != null) result.currentTurn = currentTurn;
    if (activePlayer != null) result.activePlayer = activePlayer;
    if (name != null) result.name = name;
    if (createdTimestamp != null) result.createdTimestamp = createdTimestamp;
    if (id != null) result.id = id;
    if (round != null) result.round = round;
    return result;
  }

  Combat._();

  factory Combat.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Combat.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Combat',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..pPM<$0.Character>(1, _omitFieldNames ? '' : 'characters',
        subBuilder: $0.Character.create)
    ..aOS(2, _omitFieldNames ? '' : 'CurrentTurn', protoName: 'CurrentTurn')
    ..aOS(3, _omitFieldNames ? '' : 'ActivePlayer', protoName: 'ActivePlayer')
    ..aOS(4, _omitFieldNames ? '' : 'Name', protoName: 'Name')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdTimestamp',
        protoName: 'createdTimestamp', subBuilder: $1.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'Id', protoName: 'Id')
    ..aI(7, _omitFieldNames ? '' : 'round')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Combat clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Combat copyWith(void Function(Combat) updates) =>
      super.copyWith((message) => updates(message as Combat)) as Combat;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Combat create() => Combat._();
  @$core.override
  Combat createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Combat getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Combat>(create);
  static Combat? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$0.Character> get characters => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get currentTurn => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentTurn($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentTurn() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentTurn() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get activePlayer => $_getSZ(2);
  @$pb.TagNumber(3)
  set activePlayer($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasActivePlayer() => $_has(2);
  @$pb.TagNumber(3)
  void clearActivePlayer() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get createdTimestamp => $_getN(4);
  @$pb.TagNumber(5)
  set createdTimestamp($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureCreatedTimestamp() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get id => $_getSZ(5);
  @$pb.TagNumber(6)
  set id($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasId() => $_has(5);
  @$pb.TagNumber(6)
  void clearId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get round => $_getIZ(6);
  @$pb.TagNumber(7)
  set round($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRound() => $_has(6);
  @$pb.TagNumber(7)
  void clearRound() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
