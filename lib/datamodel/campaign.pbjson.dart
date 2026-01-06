// This is a generated file - do not edit.
//
// Generated from campaign.proto.

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

@$core.Deprecated('Use campaignDescriptor instead')
const Campaign$json = {
  '1': 'Campaign',
  '2': [
    {
      '1': 'combats',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.combat_tracker.Combat',
      '10': 'combats'
    },
    {
      '1': 'characters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.combat_tracker.PlayerCharacter',
      '10': 'characters'
    },
    {
      '1': 'createdTimestamp',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdTimestamp'
    },
  ],
};

/// Descriptor for `Campaign`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List campaignDescriptor = $convert.base64Decode(
    'CghDYW1wYWlnbhIwCgdjb21iYXRzGAEgAygLMhYuY29tYmF0X3RyYWNrZXIuQ29tYmF0Ugdjb2'
    '1iYXRzEj8KCmNoYXJhY3RlcnMYAiADKAsyHy5jb21iYXRfdHJhY2tlci5QbGF5ZXJDaGFyYWN0'
    'ZXJSCmNoYXJhY3RlcnMSRgoQY3JlYXRlZFRpbWVzdGFtcBgDIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSEGNyZWF0ZWRUaW1lc3RhbXA=');
