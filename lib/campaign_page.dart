import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/characters/character_table.dart';
import 'package:combat_tracker/combat_sessions.dart';
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
        title: !CampaignManager.instance.isOpen ? Text("No Campaign Is Open") : Text(basenameWithoutExtension(CampaignManager.instance.file!.path)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            // combat sessions
            Expanded(child: CombatSessions()),
            VerticalDivider(),
            // characters
            Expanded(child: CharacterTable()),
          ],
        ),
      ),
    );
  }
}
