// This is a generated file - do not edit.
//
// Generated from campaign.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $2;

import 'character.pb.dart' as $1;
import 'combat.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Campaign extends $pb.GeneratedMessage {
  factory Campaign({
    $core.Iterable<$0.Combat>? combats,
    $core.Iterable<$1.Character>? characters,
    $2.Timestamp? createdTimestamp,
  }) {
    final result = create();
    if (combats != null) result.combats.addAll(combats);
    if (characters != null) result.characters.addAll(characters);
    if (createdTimestamp != null) result.createdTimestamp = createdTimestamp;
    return result;
  }

  Campaign._();

  factory Campaign.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Campaign.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Campaign',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..pPM<$0.Combat>(1, _omitFieldNames ? '' : 'combats',
        subBuilder: $0.Combat.create)
    ..pPM<$1.Character>(2, _omitFieldNames ? '' : 'characters',
        subBuilder: $1.Character.create)
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'createdTimestamp',
        protoName: 'createdTimestamp', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Campaign clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Campaign copyWith(void Function(Campaign) updates) =>
      super.copyWith((message) => updates(message as Campaign)) as Campaign;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Campaign create() => Campaign._();
  @$core.override
  Campaign createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Campaign getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Campaign>(create);
  static Campaign? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$0.Combat> get combats => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$1.Character> get characters => $_getList(1);

  @$pb.TagNumber(3)
  $2.Timestamp get createdTimestamp => $_getN(2);
  @$pb.TagNumber(3)
  set createdTimestamp($2.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedTimestamp() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureCreatedTimestamp() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
