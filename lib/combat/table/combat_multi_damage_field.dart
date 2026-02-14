import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CombatMultiDamageField extends StatefulWidget {
  const CombatMultiDamageField({super.key, this.submit});

  final Function(int val)? submit;

  @override
  State<CombatMultiDamageField> createState() => _CombatMultiDamageFieldState();
}

class _CombatMultiDamageFieldState extends State<CombatMultiDamageField> {
  late TextEditingController lifeController;

  @override
  void initState() {
    lifeController = TextEditingController();
    super.initState();
  }

  void submit() {
    var intValue = int.tryParse(lifeController.text);
    if (intValue != null) {
      if (!lifeController.text.startsWith(RegExp(r'[\-+]'))) {
        intValue *= -1;
      }

      widget.submit?.call(intValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surfaceBright,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: SizedBox(
          width: 180,
          height: 24,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Damage", style: TextStyle(fontSize: 15)),
              VerticalDivider(),
              Expanded(
                child: TextField(
                  controller: lifeController,
                  onEditingComplete: widget.submit == null ? null : submit,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: false,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+]')),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onTap: () => lifeController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: lifeController.value.text.length,
                  ),
                ),
              ),
              VerticalDivider(),
              IconButton(
                onPressed: widget.submit == null ? null : submit,
                padding: EdgeInsets.zero,
                icon: Icon(Icons.check, color: widget.submit == null ? null : Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
