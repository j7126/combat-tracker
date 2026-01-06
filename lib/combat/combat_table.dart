import 'package:combat_tracker/combat/player_character_selector.dart';
import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/character_extension.dart';
import 'package:combat_tracker/datamodel/extension/combat_extension.dart';
import 'package:combat_tracker/combat/character_row.dart';
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
      if (keyEvent.logicalKey == LogicalKeyboardKey.shiftLeft || keyEvent.logicalKey == LogicalKeyboardKey.shiftRight) {
        _isShiftDown = true;
      } else if (keyEvent.logicalKey == LogicalKeyboardKey.keyN) {
        nextTurn(goBack: _isShiftDown);
        return KeyEventResult.handled;
      }
    } else if (keyEvent is KeyUpEvent) {
      if (keyEvent.logicalKey == LogicalKeyboardKey.shiftLeft || keyEvent.logicalKey == LogicalKeyboardKey.shiftRight) {
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
    });
  }

  void changed() {
    if (_enableSort) {
      setState(() {
        widget.combat.characters.sort((a, b) => b.initiative - a.initiative);
      });
    }
  }

  void nextTurn({bool goBack = false}) {
    if (widget.combat.characters.isEmpty) {
      return;
    }

    setState(() {
      var currentIndex = widget.combat.characters.indexWhere((x) => x.id == widget.combat.currentTurn);
      if (currentIndex < 0) {
        currentIndex = 0;
      } else {
        currentIndex += goBack ? -1 : 1;
      }

      if (currentIndex < 0) {
        currentIndex = widget.combat.characters.length - 1;
      } else if (currentIndex >= widget.combat.characters.length) {
        currentIndex = 0;
      }

      widget.combat.currentTurn = widget.combat.characters[currentIndex].id;

      if (_enableTargetedDamage) {
        widget.combat.activePlayer = widget.combat.currentTurn;
      }
    });
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
                      onPressed: widget.combat.characters.isNotEmpty ? nextTurn : null,
                      style: widget.combat.characters.isNotEmpty
                          ? ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(ColorScheme.of(context).primary),
                              foregroundColor: WidgetStatePropertyAll(ColorScheme.of(context).onPrimary),
                              overlayColor: WidgetStatePropertyAll(ColorScheme.of(context).onPrimary.withAlpha(20)),
                            )
                          : null,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: _enableSort ? "Sorting Enabled" : "Sorting Disabled",
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _enableSort = !_enableSort;
                          changed();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(_enableSort ? ColorScheme.of(context).tertiary : null),
                        foregroundColor: WidgetStatePropertyAll(_enableSort ? ColorScheme.of(context).onTertiary : ColorScheme.of(context).tertiary),
                        overlayColor: WidgetStatePropertyAll(ColorScheme.of(context).tertiary.withAlpha(20)),
                      ),
                      child: Icon(Icons.arrow_downward),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: _enableTargetedDamage ? "Damage Source Tracked" : "Damage Source Not Tracked",
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _enableTargetedDamage = !_enableTargetedDamage;
                          if (_enableTargetedDamage) {
                            widget.combat.activePlayer = widget.combat.currentTurn;
                          } else {
                            widget.combat.activePlayer = "";
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(_enableTargetedDamage ? ColorScheme.of(context).error : null),
                        foregroundColor: WidgetStatePropertyAll(_enableTargetedDamage ? ColorScheme.of(context).onError : ColorScheme.of(context).error),
                        overlayColor: WidgetStatePropertyAll(ColorScheme.of(context).error.withAlpha(20)),
                      ),
                      child: Icon(Icons.track_changes),
                    ),
                  ),
                  Spacer(),
                  Tooltip(
                    message: "Select Players",
                    child: FilledButton(
                      onPressed: () async {
                        await showDialog<void>(
                          context: this.context,
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
                                            child: Text("Select Characters", style: TextTheme.of(context).headlineSmall, textAlign: TextAlign.center),
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
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        overlayColor: WidgetStatePropertyAll(Colors.blue.withAlpha(20)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      child: Icon(Icons.person),
                    ),
                  ),
                  Gap(16.0),
                  Tooltip(
                    message: "Add NPC / Enemy",
                    child: FilledButton(onPressed: addCharacter, child: Icon(Icons.add)),
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
                        backgroundColor: WidgetStatePropertyAll(_showDelete ? ColorScheme.of(context).error : null),
                        overlayColor: WidgetStatePropertyAll(ColorScheme.of(context).error.withAlpha(20)),
                        foregroundColor: WidgetStatePropertyAll(_showDelete ? ColorScheme.of(context).onError : ColorScheme.of(context).error),
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
                    child: Tooltip(message: "Initiative", child: Icon(Icons.numbers, size: 16)),
                  ),
                  VerticalDivider(),
                  Expanded(child: Text("Name", textAlign: TextAlign.center)),
                  VerticalDivider(),
                  SizedBox(width: 100, child: Text("Life", textAlign: TextAlign.center)),
                  if (_showDelete) VerticalDivider(),
                  AnimatedSize(
                    duration: Duration(milliseconds: 120),
                    child: SizedBox(
                      width: _showDelete ? 64 : 0,
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
                              ? Icon(Icons.arrow_forward, color: character.id == widget.combat.activePlayer ? Colors.red : Colors.lightGreen)
                              : Text((i + 1).toString(), style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha(100))),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var character in widget.combat.characters)
                        CharacterRow(
                          key: ValueKey(character.id),
                          combat: widget.combat,
                          character: character,
                          showDelete: _showDelete,
                          onDelete: () {
                            setState(() {
                              widget.combat.deleteCharacter(character);
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
                            Text("Add a character to get started.", style: TextTheme.of(context).titleMedium),
                            Gap(8.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: PlayerCharacterSelector(combat: widget.combat),
                            ),
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  _showAddCharacter = false;
                                });
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
