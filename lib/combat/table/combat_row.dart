import 'package:combat_tracker/campaign/campaign_manager.dart';
import 'package:combat_tracker/combat/damage_stats/damage_stats_dialog.dart';
import 'package:combat_tracker/combat/table/fields/combat_custom_field.dart';
import 'package:combat_tracker/datamodel/extension/custom_field_extension.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:combat_tracker/combat/table/fields/combat_initiative_field.dart';
import 'package:combat_tracker/combat/table/fields/combat_life_field.dart';
import 'package:combat_tracker/combat/table/fields/combat_name_field.dart';
import 'package:combat_tracker/combat/table/fields/combat_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CombatRow extends StatefulWidget {
  const CombatRow({
    super.key,
    required this.combat,
    required this.character,
    this.showDelete = false,
    this.onDelete,
    this.changed,
  });

  final Combat combat;
  final Character character;
  final bool showDelete;
  final Function()? onDelete;
  final Function()? changed;

  @override
  State<CombatRow> createState() => _CombatRowState();
}

class _CombatRowState extends State<CombatRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (value) {
        setState(() {
          _hovering = false;
        });
      },
      child: SizedBox(
        height: 48,
        child: Container(
          decoration: BoxDecoration(
            color: _hovering
                ? ColorScheme.of(context).surfaceContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Gap(4.0),
              SizedBox(
                width: 40,
                child: CombatTypeSelector(
                  character: widget.character,
                  changed: widget.changed,
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CombatInitiativeField(
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CombatNameField(
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              VerticalDivider(),
              for (var field
                  in CampaignManager.instance.campaign!.options.customFields
                      .where((x) => x.enabledCombat && x.isValid)) ...[
                SizedBox(
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CombatCustomField(
                      character: widget.character,
                      field: field,
                      changed: widget.changed,
                    ),
                  ),
                ),
                VerticalDivider(),
              ],
              SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CombatLifeField(
                    combat: widget.combat,
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              VerticalDivider(),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => DamageStatsDialog(
                    combat: widget.combat,
                    character: widget.character,
                  ),
                ),
                icon: Icon(Icons.history),
              ),
              if (widget.showDelete) VerticalDivider(),
              AnimatedSize(
                duration: Duration(milliseconds: 120),
                child: SizedBox(
                  width: widget.showDelete ? 40 : 0,
                  child: Opacity(
                    opacity: widget.showDelete ? 1 : 0,
                    child: IconButton(
                      onPressed: widget.onDelete,
                      icon: Icon(Icons.delete_outline),
                      color: ColorScheme.of(context).error,
                    ),
                  ),
                ),
              ),
              Gap(4.0),
            ],
          ),
        ),
      ),
    );
  }
}
