import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/combat/combat_table.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:flutter/material.dart';

class CombatPage extends StatefulWidget {
  const CombatPage({super.key, required this.combat});

  final Combat combat;

  @override
  State<CombatPage> createState() => _CombatPageState();
}

class _CombatPageState extends State<CombatPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.combat.name);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: nameController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                widget.combat.name = value;
                CampaignManager.instance.saveCampaign();
              });
            }
          },
          decoration: InputDecoration(border: InputBorder.none),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: CombatTable(combat: widget.combat),
    );
  }
}
