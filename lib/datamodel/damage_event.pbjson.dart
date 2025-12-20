// This is a generated file - do not edit.
//
// Generated from damage_event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use damageEventDescriptor instead')
const DamageEvent$json = {
  '1': 'DamageEvent',
  '2': [
    {'1': 'change', '3': 1, '4': 1, '5': 5, '10': 'change'},
    {'1': 'previousLife', '3': 2, '4': 1, '5': 5, '10': 'previousLife'},
    {'1': 'source', '3': 3, '4': 1, '5': 9, '10': 'source'},
    {
      '1': 'timestamp',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timestamp'
    },
  ],
};

/// Descriptor for `DamageEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List damageEventDescriptor = $convert.base64Decode(
    'CgtEYW1hZ2VFdmVudBIWCgZjaGFuZ2UYASABKAVSBmNoYW5nZRIiCgxwcmV2aW91c0xpZmUYAi'
    'ABKAVSDHByZXZpb3VzTGlmZRIWCgZzb3VyY2UYAyABKAlSBnNvdXJjZRI4Cgl0aW1lc3RhbXAY'
    'BCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA=');
