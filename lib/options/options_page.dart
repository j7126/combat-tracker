import 'package:combat_tracker/options/initiative_priority_selector.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Campaign Options")),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                InitiativePrioritySelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
