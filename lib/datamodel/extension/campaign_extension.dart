import 'package:combat_tracker/datamodel/generated/campaign.pb.dart';
import 'package:combat_tracker/datamodel/extension/options_extension.dart';
import 'package:combat_tracker/datamodel/generated/options.pb.dart';

extension CampaignExtension on Campaign {
  void validate() {
    if (!hasOptions()) {
      options = Options();
    }
    options.validate();
  }
}