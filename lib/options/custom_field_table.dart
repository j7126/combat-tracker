import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:combat_tracker/options/custom_field_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class CustomFieldTable extends StatefulWidget {
  const CustomFieldTable({super.key});

  @override
  State<CustomFieldTable> createState() => _CustomFieldTableState();
}

class _CustomFieldTableState extends State<CustomFieldTable> {
  void deleteField(CustomField field) async {
    var shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: field.name.isEmpty
              ? Text(
                  'Are you sure you want to delete unnamed field?\nThis cannot be undone.',
                )
              : Text(
                  'Are you sure you want to delete field "${field.name}"?\nThis cannot be undone.',
                ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (mounted && shouldDelete == true) {
      setState(() {
        CampaignManager.instance.campaign!.options.customFields.remove(field);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customisable Fields", style: TextTheme.of(context).titleLarge),
          Text(
            "Additional character fields can be customised.",
            style: TextTheme.of(context).bodyMedium,
          ),
          Gap(8.0),
          Text("Built-in fields", style: TextTheme.of(context).bodyLarge),
          for (var field
              in CampaignManager.instance.campaign!.options.customFields.where(
                (x) => x.builtIn,
              ))
            CustomFieldRow(field: field, onDelete: () => deleteField(field)),
          Divider(),
          Row(
            children: [
              Text("Custom fields", style: TextTheme.of(context).bodyLarge),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    CampaignManager.instance.campaign!.options.customFields.add(
                      CustomField(
                        id: Uuid().v4(),
                        enabledCharacter: true,
                        enabledCombat: true,
                      ),
                    );
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          for (var field
              in CampaignManager.instance.campaign!.options.customFields.where(
                (x) => !x.builtIn,
              ))
            CustomFieldRow(
              key: Key(field.id),
              field: field,
              onDelete: () => deleteField(field),
            ),
        ],
      ),
    );
  }
}
