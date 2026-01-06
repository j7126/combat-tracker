import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/combat_page.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !CampaignManager.instance.isOpen
            ? Text("No Campaign Is Open")
            : Text(
                basenameWithoutExtension(CampaignManager.instance.file!.path),
              ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                var combat = Combat(
                  name: "test",
                  createdTimestamp: TimestampExtension.now(),
                );
                CampaignManager.instance.campaign!.combats.add(combat);
              });
            },
            icon: Icon(Icons.add),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var combat in CampaignManager.instance.campaign!.combats)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CombatPage(combat: combat),
                          ),
                        );
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Text(combat.name),
                            Text(
                              combat.createdTimestamp.toDateTime().toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
