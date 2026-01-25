import 'package:combat_tracker/datamodel/extension/custom_field_extension.dart';
import 'package:combat_tracker/datamodel/extension/custom_field_type_extension.dart';
import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:combat_tracker/util/always_disabled_focus_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class CustomFieldRow extends StatefulWidget {
  const CustomFieldRow({
    super.key,
    required this.field,
    required this.onDelete,
  });

  final CustomField field;
  final Function() onDelete;

  @override
  State<CustomFieldRow> createState() => _CustomFieldRowState();
}

class _CustomFieldRowState extends State<CustomFieldRow> {
  late TextEditingController nameController;
  late TextEditingController shortNameController;
  FocusNode menuFocusNode = FocusNode();

  Widget _typeMenuEntry(CustomFieldType type) => MenuItemButton(
    onPressed: () {
      if (widget.field.builtIn) {
        return;
      }
      setState(() {
        widget.field.type = type;
      });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [type.getIcon(), Gap(8.0), Text(type.getName())],
      ),
    ),
  );

  @override
  void initState() {
    nameController = TextEditingController(text: widget.field.name);
    shortNameController = TextEditingController(text: widget.field.shortName);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    shortNameController.dispose();
    menuFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              MenuAnchor(
                menuChildren: [
                  _typeMenuEntry(CustomFieldType.Text),
                  _typeMenuEntry(CustomFieldType.Numeric),
                ],
                builder: (_, MenuController controller, Widget? child) {
                  return IconButton(
                    onPressed: widget.field.builtIn
                        ? null
                        : () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                    icon: widget.field.type.getIcon(),
                  );
                },
              ),
              VerticalDivider(),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: shortNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: widget.field.builtIn ? null : "Short Name",
                    errorText: widget.field.shortName.isEmpty
                        ? "Can't Be Empty"
                        : null,
                  ),
                  onChanged: (val) {
                    setState(() {
                      widget.field.shortName = val;
                    });
                  },
                  readOnly: widget.field.builtIn,
                  focusNode: widget.field.builtIn
                      ? AlwaysDisabledFocusNode()
                      : null,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: widget.field.builtIn ? null : "Name",
                    errorText: widget.field.name.isEmpty
                        ? "Value Can't Be Empty"
                        : null,
                  ),
                  onChanged: (val) {
                    setState(() {
                      widget.field.name = val;
                    });
                  },
                  readOnly: widget.field.builtIn,
                  focusNode: widget.field.builtIn
                      ? AlwaysDisabledFocusNode()
                      : null,
                ),
              ),
              if (widget.field.enabledCharacter != widget.field.enabledCombat)
                widget.field.enabledCombat
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "Only in Combat",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "Player character only",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
              Switch(
                value:
                    (widget.field.enabledCharacter ||
                        widget.field.enabledCombat) &&
                    widget.field.isValid,
                onChanged: !widget.field.isValid
                    ? null
                    : (val) {
                        var current =
                            widget.field.enabledCharacter ||
                            widget.field.enabledCombat;
                        if (current == val) {
                          return;
                        }
                        setState(() {
                          widget.field.enabledCharacter = val;
                          widget.field.enabledCombat = val;
                        });
                      },
              ),
              MenuAnchor(
                childFocusNode: menuFocusNode,
                menuChildren: [
                  if (!widget.field.builtIn)
                    SizedBox(
                      width: 300,
                      child: ListTile(
                        title: Text("Delete"),
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.delete_outline),
                        ),
                        iconColor: ColorScheme.of(context).error,
                        textColor: ColorScheme.of(context).error,
                        onTap: widget.onDelete,
                      ),
                    ),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      value: widget.field.enabledCharacter,
                      onChanged: (value) {
                        setState(() {
                          widget.field.enabledCharacter = value ?? false;
                        });
                      },
                      title: Text("Player Character"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                      value: widget.field.enabledCombat,
                      onChanged: (value) {
                        setState(() {
                          widget.field.enabledCombat = value ?? false;
                        });
                      },
                      title: Text("In Combat"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
                builder:
                    (
                      BuildContext context,
                      MenuController controller,
                      Widget? child,
                    ) {
                      return IconButton(
                        focusNode: menuFocusNode,
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: Icon(Icons.more_vert),
                      );
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
