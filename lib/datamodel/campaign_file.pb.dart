// This is a generated file - do not edit.
//
// Generated from campaign_file.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CampaignFile extends $pb.GeneratedMessage {
  factory CampaignFile({
    $core.String? path,
    $core.String? macosBookmark,
  }) {
    final result = create();
    if (path != null) result.path = path;
    if (macosBookmark != null) result.macosBookmark = macosBookmark;
    return result;
  }

  CampaignFile._();

  factory CampaignFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CampaignFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CampaignFile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'combat_tracker'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'macosBookmark', protoName: 'macosBookmark')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CampaignFile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CampaignFile copyWith(void Function(CampaignFile) updates) =>
      super.copyWith((message) => updates(message as CampaignFile))
          as CampaignFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CampaignFile create() => CampaignFile._();
  @$core.override
  CampaignFile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CampaignFile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CampaignFile>(create);
  static CampaignFile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get macosBookmark => $_getSZ(1);
  @$pb.TagNumber(2)
  set macosBookmark($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMacosBookmark() => $_has(1);
  @$pb.TagNumber(2)
  void clearMacosBookmark() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
