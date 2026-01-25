import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';

extension CustomFieldExtension on CustomField {
  bool get isValid => name.isNotEmpty && shortName.isNotEmpty;
}
