// This is a generated file - do not edit.
//
// Generated from options.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'character.pbenum.dart' as $1;
import 'custom_field.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Options extends $pb.GeneratedMessage {
  factory Options({
    $core.Iterable<$1.CharacterType>? initiativePriority,
    $core.Iterable<$0.CustomField>? customFields,
  }) {
    final result = create();
    if (initiativePriority != null)
      result.initiativePriority.addAll(initiativePriority);
    if (customFields != null) result.customFields.addAll(customFields);
    return result;
  }

  Options._();

  factory Options.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Options.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Options',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..pc<$1.CharacterType>(
        1, _omitFieldNames ? '' : 'initiativePriority', $pb.PbFieldType.KE,
        protoName: 'initiativePriority',
        valueOf: $1.CharacterType.valueOf,
        enumValues: $1.CharacterType.values,
        defaultEnumValue: $1.CharacterType.Player)
    ..pPM<$0.CustomField>(2, _omitFieldNames ? '' : 'customFields',
        protoName: 'customFields', subBuilder: $0.CustomField.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Options clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Options copyWith(void Function(Options) updates) =>
      super.copyWith((message) => updates(message as Options)) as Options;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Options create() => Options._();
  @$core.override
  Options createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Options getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Options>(create);
  static Options? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.CharacterType> get initiativePriority => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.CustomField> get customFields => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
