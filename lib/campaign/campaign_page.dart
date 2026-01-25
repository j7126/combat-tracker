import 'package:combat_tracker/campaign/campaign_manager.dart';
import 'package:combat_tracker/characters/character_table.dart';
import 'package:combat_tracker/combat/combat_sessions.dart';
import 'package:combat_tracker/campaign_options/options_page.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Tooltip(
              message: "Campaign Options",
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OptionsPage()),
                  );
                },
                icon: Icon(Icons.settings),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(child: CharacterTable()),
            VerticalDivider(),
            Expanded(child: CombatSessions()),
          ],
        ),
      ),
    );
  }
}
