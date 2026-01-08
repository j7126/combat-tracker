import 'package:flutter/material.dart';

class CreateCombatDialog extends StatefulWidget {
  const CreateCombatDialog({super.key});

  @override
  State<CreateCombatDialog> createState() => _CreateCombatDialogState();
}

class _CreateCombatDialogState extends State<CreateCombatDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create Combat Session"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: "Name"),
        onChanged: (_) {
          setState(() {});
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        TextButton(
          onPressed: controller.text.isEmpty
              ? null
              : () {
                  Navigator.of(context).pop(controller.text);
                },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
