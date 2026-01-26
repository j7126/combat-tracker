import 'package:combat_tracker/campaign/campaign_manager.dart';
import 'package:combat_tracker/combat/player_character_selector.dart';
import 'package:combat_tracker/combat/table/round_tracker.dart';
import 'package:combat_tracker/datamodel/extension/custom_field_extension.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/character_extension.dart';
import 'package:combat_tracker/datamodel/extension/combat_extension.dart';
import 'package:combat_tracker/combat/table/combat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class CombatTable extends StatefulWidget {
  const CombatTable({super.key, required this.combat});

  final Combat combat;

  @override
  State<CombatTable> createState() => _CombatTableState();
}

class _CombatTableState extends State<CombatTable> {
  bool _showDelete = false;
  bool _enableSort = true;
  bool _enableTargetedDamage = true;
  bool _isShiftDown = false;
  bool _showAddCharacter = true;

  FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    focusScopeNode.addListener(() {
      if (!focusScopeNode.hasFocus) {
        _isShiftDown = false;
      }
    });

    _enableTargetedDamage =
        widget.combat.currentTurn.isEmpty ||
        widget.combat.activePlayer.isNotEmpty;

    super.initState();
  }

  @override
  void dispose() {
    focusScopeNode.dispose();
    super.dispose();
  }

  KeyEventResult _keyboardCallback(FocusNode node, KeyEvent keyEvent) {
    if (!node.hasPrimaryFocus) {
      return KeyEventResult.ignored;
    }

    if (keyEvent is KeyDownEvent) {
      if (keyEvent.logicalKey == LogicalKeyboardKey.shiftLeft ||
          keyEvent.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftDown = true;
      } else if (keyEvent.logicalKey == LogicalKeyboardKey.keyN) {
        nextTurn(goBack: _isShiftDown);
        return KeyEventResult.handled;
      }
    } else if (keyEvent is KeyUpEvent) {
      if (keyEvent.logicalKey == LogicalKeyboardKey.shiftLeft ||
          keyEvent.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftDown = false;
      }
    }

    return KeyEventResult.ignored;
  }

  void addCharacter() {
    setState(() {
      var character = CharacterExtension.createCharacter();
      character.type = CharacterType.Enemy;
      widget.combat.characters.add(character);
      CampaignManager.instance.saveCampaign();
    });
  }

  void changed() {
    if (_enableSort) {
      setState(() {
        int sortPriority(Character character) {
          // prioritise by initiative
          var priority = character.initiative * 10;
          // prioritise by character type
          priority -= CampaignManager
              .instance
              .campaign!
              .options
              .initiativePriority
              .indexOf(character.type);
          return priority;
        }

        widget.combat.characters.sort(
          (a, b) => sortPriority(b) - sortPriority(a),
        );
      });
    }
    CampaignManager.instance.saveCampaign();
  }

  void nextTurn({bool goBack = false}) {
    if (widget.combat.characters.isEmpty) {
      return;
    }

    setState(() {
      var currentIndex = widget.combat.characters.indexWhere(
        (x) => x.id == widget.combat.currentTurn,
      );
      if (currentIndex < 0) {
        currentIndex = 0;
      } else {
        currentIndex += goBack ? -1 : 1;
      }

      if (currentIndex < 0) {
        currentIndex = widget.combat.characters.length - 1;
        widget.combat.round--;
        if (widget.combat.round < 0) {
          widget.combat.round = 0;
        }
      } else if (currentIndex >= widget.combat.characters.length) {
        currentIndex = 0;
        widget.combat.round++;
        if (widget.combat.round > 98) {
          widget.combat.round = 98;
        }
      }

      widget.combat.currentTurn = widget.combat.characters[currentIndex].id;

      if (_enableTargetedDamage) {
        widget.combat.activePlayer = widget.combat.currentTurn;
      }

      CampaignManager.instance.saveCampaign();
    });
  }

  void selectPlayers() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Select Characters",
                          style: TextTheme.of(context).headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Gap(8.0),
                  PlayerCharacterSelector(combat: widget.combat),
                  Gap(8.0),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (mounted) {
      setState(() {});
      changed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      onKeyEvent: _keyboardCallback,
      node: focusScopeNode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Gap(16.0),
                  Tooltip(
                    message: "Next Turn (n)",
                    child: OutlinedButton(
                      onPressed: widget.combat.characters.isNotEmpty
                          ? nextTurn
                          : null,
                      style: widget.combat.characters.isNotEmpty
                          ? ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                ColorScheme.of(context).primary,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                ColorScheme.of(context).onPrimary,
                              ),
                              overlayColor: WidgetStatePropertyAll(
                                ColorScheme.of(context).onPrimary.withAlpha(20),
                              ),
                            )
                          : null,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: "Enable Sorting",
                    child: Switch(
                      value: _enableSort,
                      onChanged: (val) {
                        setState(() {
                          _enableSort = val;
                          changed();
                        });
                      },
                      thumbIcon: WidgetStatePropertyAll(
                        Icon(
                          Icons.arrow_downward,
                          color: ColorScheme.of(context).onTertiary,
                        ),
                      ),
                      activeThumbColor: ColorScheme.of(context).tertiary,
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: "Track Damage Source",
                    child: Switch(
                      value: _enableTargetedDamage,
                      onChanged: (val) {
                        setState(() {
                          _enableTargetedDamage = val;
                          if (_enableTargetedDamage) {
                            widget.combat.activePlayer =
                                widget.combat.currentTurn;
                          } else {
                            widget.combat.activePlayer = "";
                          }
                          CampaignManager.instance.saveCampaign();
                        });
                      },
                      thumbIcon: WidgetStatePropertyAll(
                        Icon(
                          Icons.track_changes,
                          color: ColorScheme.of(context).onError,
                        ),
                      ),
                      activeThumbColor: ColorScheme.of(context).error,
                    ),
                  ),
                  RoundTracker(combat: widget.combat),
                  Spacer(),
                  Tooltip(
                    message: "Select Players",
                    child: FilledButton(
                      onPressed: selectPlayers,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        overlayColor: WidgetStatePropertyAll(
                          Colors.blue.withAlpha(20),
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      child: Icon(Icons.person),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: "Add NPC / Enemy",
                    child: FilledButton(
                      onPressed: addCharacter,
                      child: Icon(Icons.add),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: _showDelete ? "Done" : "Delete",
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _showDelete = !_showDelete;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          _showDelete ? ColorScheme.of(context).error : null,
                        ),
                        overlayColor: WidgetStatePropertyAll(
                          ColorScheme.of(context).error.withAlpha(20),
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          _showDelete
                              ? ColorScheme.of(context).onError
                              : ColorScheme.of(context).error,
                        ),
                      ),
                      child: Icon(_showDelete ? Icons.check : Icons.delete),
                    ),
                  ),
                  Gap(16.0),
                ],
              ),
            ),
            SizedBox(
              height: 22,
              child: Row(
                children: [
                  SizedBox(width: 92),
                  VerticalDivider(),
                  SizedBox(
                    width: 48,
                    child: Tooltip(
                      message: "Initiative",
                      child: Icon(Icons.numbers, size: 16),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(child: Text("Name", textAlign: TextAlign.center)),
                  VerticalDivider(),
                  for (var field
                      in CampaignManager.instance.campaign!.options.customFields
                          .where((x) => x.enabledCombat && x.isValid)) ...[
                    SizedBox(
                      width: 80,
                      child: Text(field.shortName, textAlign: TextAlign.center),
                    ),
                    VerticalDivider(),
                  ],
                  SizedBox(
                    width: 100,
                    child: Text("Life", textAlign: TextAlign.center),
                  ),
                  VerticalDivider(),
                  SizedBox(width: 40),
                  if (_showDelete) VerticalDivider(),
                  AnimatedSize(
                    duration: Duration(milliseconds: 120),
                    child: SizedBox(
                      width: _showDelete ? 40 : 0,
                      child: Text("", textAlign: TextAlign.center),
                    ),
                  ),
                  Gap(4.0),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var (i, character) in widget.combat.characters.indexed)
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              widget.combat.currentTurn = character.id;
                              widget.combat.activePlayer = character.id;
                            });
                          },
                          icon: character.id == widget.combat.currentTurn
                              ? Icon(
                                  Icons.arrow_forward,
                                  color:
                                      character.id == widget.combat.activePlayer
                                      ? Colors.red
                                      : Colors.lightGreen,
                                )
                              : Text(
                                  (i + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                        ?.withAlpha(100),
                                  ),
                                ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var character in widget.combat.characters)
                        CombatRow(
                          key: ValueKey(character.id),
                          combat: widget.combat,
                          character: character,
                          showDelete: _showDelete,
                          onDelete: () {
                            setState(() {
                              widget.combat.deleteCharacter(character);
                              CampaignManager.instance.saveCampaign();
                            });
                          },
                          changed: changed,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.combat.characters.isEmpty && _showAddCharacter)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Card(
                        child: Column(
                          children: [
                            Gap(12.0),
                            Text(
                              "Add a character to get started.",
                              style: TextTheme.of(context).titleMedium,
                            ),
                            Gap(8.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: PlayerCharacterSelector(
                                combat: widget.combat,
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  _showAddCharacter = false;
                                });
                                CampaignManager.instance.saveCampaign();
                              },
                              child: Text("Done"),
                            ),
                            Gap(8.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
