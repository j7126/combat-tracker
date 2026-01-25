import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:flutter/material.dart';

extension CustomFieldTypeExtension on CustomFieldType {
  Widget getIcon() => switch (this) {
    CustomFieldType.Numeric => Icon(Icons.numbers),
    CustomFieldType.Text => Icon(Icons.text_fields),
    _ => Container(),
  };

  String getName() => switch (this) {
    CustomFieldType.Numeric => "Numeric",
    CustomFieldType.Text => "Text",
    _ => "",
  };
}
