// This is a generated file - do not edit.
//
// Generated from custom_field.proto.

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

@$core.Deprecated('Use customFieldTypeDescriptor instead')
const CustomFieldType$json = {
  '1': 'CustomFieldType',
  '2': [
    {'1': 'Text', '2': 0},
    {'1': 'Numeric', '2': 1},
  ],
};

/// Descriptor for `CustomFieldType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List customFieldTypeDescriptor = $convert
    .base64Decode('Cg9DdXN0b21GaWVsZFR5cGUSCAoEVGV4dBAAEgsKB051bWVyaWMQAQ==');

@$core.Deprecated('Use customFieldDescriptor instead')
const CustomField$json = {
  '1': 'CustomField',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'enabledCharacter', '3': 3, '4': 1, '5': 8, '10': 'enabledCharacter'},
    {'1': 'enabledCombat', '3': 4, '4': 1, '5': 8, '10': 'enabledCombat'},
    {
      '1': 'enabledCharacterTypes',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.combat_tracker.CharacterType',
      '10': 'enabledCharacterTypes'
    },
    {'1': 'shortName', '3': 6, '4': 1, '5': 9, '10': 'shortName'},
    {'1': 'builtIn', '3': 7, '4': 1, '5': 8, '10': 'builtIn'},
    {
      '1': 'type',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.combat_tracker.CustomFieldType',
      '10': 'type'
    },
  ],
};

/// Descriptor for `CustomField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customFieldDescriptor = $convert.base64Decode(
    'CgtDdXN0b21GaWVsZBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIqChBlbm'
    'FibGVkQ2hhcmFjdGVyGAMgASgIUhBlbmFibGVkQ2hhcmFjdGVyEiQKDWVuYWJsZWRDb21iYXQY'
    'BCABKAhSDWVuYWJsZWRDb21iYXQSUwoVZW5hYmxlZENoYXJhY3RlclR5cGVzGAUgAygOMh0uY2'
    '9tYmF0X3RyYWNrZXIuQ2hhcmFjdGVyVHlwZVIVZW5hYmxlZENoYXJhY3RlclR5cGVzEhwKCXNo'
    'b3J0TmFtZRgGIAEoCVIJc2hvcnROYW1lEhgKB2J1aWx0SW4YByABKAhSB2J1aWx0SW4SMwoEdH'
    'lwZRgIIAEoDjIfLmNvbWJhdF90cmFja2VyLkN1c3RvbUZpZWxkVHlwZVIEdHlwZQ==');
