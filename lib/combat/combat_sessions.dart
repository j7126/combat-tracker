import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/combat/combat_page.dart';
import 'package:combat_tracker/combat/create_combat_dialog.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CombatSessions extends StatefulWidget {
  const CombatSessions({super.key});

  @override
  State<CombatSessions> createState() => _CombatSessionsState();
}

class _CombatSessionsState extends State<CombatSessions> {
  void createSession() async {
    var name = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return CreateCombatDialog();
      },
    );
    if (name == null || !mounted) {
      return;
    }
    var combat = Combat(
      id: Uuid().v4(),
      name: name,
      createdTimestamp: TimestampExtension.now(),
    );
    CampaignManager.instance.campaign!.combats.add(combat);
    CampaignManager.instance.saveCampaign();
    openCombat(combat);
  }

  void deleteSession(Combat combat) async {
    var shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: combat.name.isEmpty
              ? Text(
                  'Are you sure you want to delete unnamed combat?\nThis cannot be undone.',
                )
              : Text(
                  'Are you sure you want to delete combat "${combat.name}"?\nThis cannot be undone.',
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
    if (!mounted || shouldDelete != true) {
      return;
    }
    setState(() {
      CampaignManager.instance.campaign!.combats.removeWhere(
        (x) => x.id == combat.id,
      );
      CampaignManager.instance.saveCampaign();
    });
  }

  void openCombat(Combat combat) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => CombatPage(combat: combat)));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text("Combat Sessions", style: TextTheme.of(context).titleMedium),
              Spacer(),
              IconButton(onPressed: createSession, icon: Icon(Icons.add)),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var combat
                    in CampaignManager.instance.campaign!.combats.reversed)
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () => openCombat(combat),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      combat.name,
                                      style: TextTheme.of(context).titleLarge,
                                    ),
                                    Text(
                                      DateFormat.yMd().add_jm().format(
                                        combat.createdTimestamp.toDateTime().toLocal(),
                                      ),
                                      style: TextTheme.of(context).bodySmall
                                          ?.copyWith(
                                            color: ColorScheme.of(
                                              context,
                                            ).onSurface.withAlpha(100),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteSession(combat),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
