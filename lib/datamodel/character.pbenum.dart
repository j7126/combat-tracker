// This is a generated file - do not edit.
//
// Generated from character.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CharacterType extends $pb.ProtobufEnum {
  static const CharacterType PlayerCharacter =
      CharacterType._(0, _omitEnumNames ? '' : 'PlayerCharacter');
  static const CharacterType FriendlyNPC =
      CharacterType._(1, _omitEnumNames ? '' : 'FriendlyNPC');
  static const CharacterType Enemy =
      CharacterType._(2, _omitEnumNames ? '' : 'Enemy');

  static const $core.List<CharacterType> values = <CharacterType>[
    PlayerCharacter,
    FriendlyNPC,
    Enemy,
  ];

  static final $core.List<CharacterType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CharacterType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CharacterType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
