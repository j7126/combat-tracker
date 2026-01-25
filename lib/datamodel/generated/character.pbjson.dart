// This is a generated file - do not edit.
//
// Generated from character.proto.

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

@$core.Deprecated('Use characterTypeDescriptor instead')
const CharacterType$json = {
  '1': 'CharacterType',
  '2': [
    {'1': 'Player', '2': 0},
    {'1': 'FriendlyNPC', '2': 1},
    {'1': 'Enemy', '2': 2},
    {'1': 'UnknownNPC', '2': 3},
  ],
};

/// Descriptor for `CharacterType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List characterTypeDescriptor = $convert.base64Decode(
    'Cg1DaGFyYWN0ZXJUeXBlEgoKBlBsYXllchAAEg8KC0ZyaWVuZGx5TlBDEAESCQoFRW5lbXkQAh'
    'IOCgpVbmtub3duTlBDEAM=');

@$core.Deprecated('Use characterDescriptor instead')
const Character$json = {
  '1': 'Character',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'life', '3': 3, '4': 1, '5': 5, '10': 'life'},
    {'1': 'maxLife', '3': 4, '4': 1, '5': 5, '10': 'maxLife'},
    {
      '1': 'type',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.combat_tracker.CharacterType',
      '10': 'type'
    },
    {'1': 'initiative', '3': 6, '4': 1, '5': 5, '10': 'initiative'},
    {
      '1': 'damageEvents',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.combat_tracker.DamageEvent',
      '10': 'damageEvents'
    },
    {
      '1': 'customFieldValues',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.combat_tracker.Character.CustomFieldValuesEntry',
      '10': 'customFieldValues'
    },
  ],
  '3': [Character_CustomFieldValuesEntry$json],
};

@$core.Deprecated('Use characterDescriptor instead')
const Character_CustomFieldValuesEntry$json = {
  '1': 'CustomFieldValuesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Character`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterDescriptor = $convert.base64Decode(
    'CglDaGFyYWN0ZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEbGlmZR'
    'gDIAEoBVIEbGlmZRIYCgdtYXhMaWZlGAQgASgFUgdtYXhMaWZlEjEKBHR5cGUYBSABKA4yHS5j'
    'b21iYXRfdHJhY2tlci5DaGFyYWN0ZXJUeXBlUgR0eXBlEh4KCmluaXRpYXRpdmUYBiABKAVSCm'
    'luaXRpYXRpdmUSPwoMZGFtYWdlRXZlbnRzGAcgAygLMhsuY29tYmF0X3RyYWNrZXIuRGFtYWdl'
    'RXZlbnRSDGRhbWFnZUV2ZW50cxJeChFjdXN0b21GaWVsZFZhbHVlcxgIIAMoCzIwLmNvbWJhdF'
    '90cmFja2VyLkNoYXJhY3Rlci5DdXN0b21GaWVsZFZhbHVlc0VudHJ5UhFjdXN0b21GaWVsZFZh'
    'bHVlcxpEChZDdXN0b21GaWVsZFZhbHVlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbH'
    'VlGAIgASgJUgV2YWx1ZToCOAE=');
