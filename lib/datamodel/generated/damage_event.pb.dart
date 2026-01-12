// This is a generated file - do not edit.
//
// Generated from damage_event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DamageEvent extends $pb.GeneratedMessage {
  factory DamageEvent({
    $core.int? change,
    $core.int? previousLife,
    $core.String? source,
    $0.Timestamp? timestamp,
  }) {
    final result = create();
    if (change != null) result.change = change;
    if (previousLife != null) result.previousLife = previousLife;
    if (source != null) result.source = source;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  DamageEvent._();

  factory DamageEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DamageEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DamageEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'change')
    ..aI(2, _omitFieldNames ? '' : 'previousLife', protoName: 'previousLife')
    ..aOS(3, _omitFieldNames ? '' : 'source')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DamageEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DamageEvent copyWith(void Function(DamageEvent) updates) =>
      super.copyWith((message) => updates(message as DamageEvent))
          as DamageEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DamageEvent create() => DamageEvent._();
  @$core.override
  DamageEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DamageEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DamageEvent>(create);
  static DamageEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get change => $_getIZ(0);
  @$pb.TagNumber(1)
  set change($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChange() => $_has(0);
  @$pb.TagNumber(1)
  void clearChange() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get previousLife => $_getIZ(1);
  @$pb.TagNumber(2)
  set previousLife($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreviousLife() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousLife() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get source => $_getSZ(2);
  @$pb.TagNumber(3)
  set source($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureTimestamp() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
