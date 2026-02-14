import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundTracker extends StatefulWidget {
  const RoundTracker({super.key, required this.combat});

  final Combat combat;

  int get round => combat.round + 1;
  set round(int val) {
    if (val < 1) {
      val = 1;
    }
    if (val > 99) {
      val = 99;
    }
    combat.round = val - 1;
  }

  @override
  State<RoundTracker> createState() => _RoundTrackerState();
}

class _RoundTrackerState extends State<RoundTracker> {
  late int currentRound;
  late TextEditingController controller;
  FocusNode node = FocusNode();

  @override
  void initState() {
    currentRound = widget.round;
    controller = TextEditingController(text: widget.round.toString());
    node.addListener(() {
      if (!node.hasFocus) {
        valueChanged();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  void valueChanged() {
    var value = int.tryParse(controller.text);
    if (value != currentRound) {
      setState(() {
        if (value != null) {
          widget.round = value;
          currentRound = widget.round;
        }
        controller.text = currentRound.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.round != currentRound) {
      currentRound = widget.round;
      controller.text = currentRound.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          node.requestFocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorScheme.of(context).surfaceBright,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            child: SizedBox(
              width: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Round ", style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: node,
                      onEditingComplete: () {
                        node.unfocus();
                        valueChanged();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                        decimal: false,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(2),
                      ],
                      onTap: () => controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.value.text.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
