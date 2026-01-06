import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/combat_page.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CombatSessions extends StatefulWidget {
  const CombatSessions({super.key});

  @override
  State<CombatSessions> createState() => _CombatSessionsState();
}

class _CombatSessionsState extends State<CombatSessions> {
  void createSession() {
    setState(() {
      var combat = Combat(name: "test", createdTimestamp: TimestampExtension.now());
      CampaignManager.instance.campaign!.combats.add(combat);
    });
    CampaignManager.instance.saveCampaign();
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
                for (var combat in CampaignManager.instance.campaign!.combats)
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CombatPage(combat: combat)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(combat.name, style: TextTheme.of(context).titleLarge),
                              Text(
                                DateFormat.yMd().add_jm().format(combat.createdTimestamp.toDateTime()),
                                style: TextTheme.of(context).bodySmall?.copyWith(color: ColorScheme.of(context).onSurface.withAlpha(100)),
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
