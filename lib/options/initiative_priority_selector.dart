import 'dart:ui';

import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/datamodel/extension/character_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InitiativePrioritySelector extends StatefulWidget {
  const InitiativePrioritySelector({super.key});

  @override
  State<InitiativePrioritySelector> createState() =>
      _InitiativePrioritySelectorState();
}

class _InitiativePrioritySelectorState
    extends State<InitiativePrioritySelector> {
  static const double itemHeight = 42;

  @override
  Widget build(BuildContext context) {
    var cards = <Card>[
      for (var characterType
          in CampaignManager.instance.campaign!.options.initiativePriority)
        Card(
          key: Key(characterType.value.toString()),
          child: SizedBox(
            height: itemHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  characterType.getIcon(),
                  Gap(8.0),
                  Text(characterType.getName()),
                ],
              ),
            ),
          ),
        ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Initiative Priority", style: TextTheme.of(context).titleLarge),
        Text(
          "This controls the order in which different character types will be placed, if they share the same initiative.",
          style: TextTheme.of(context).bodyMedium,
        ),
        Gap(8.0),
        SizedBox(
          height: (itemHeight + 8) * cards.length,
          child: DragBoundary(
            child: ReorderableListView(
              proxyDecorator: (child, index, animation) => AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  final double animValue = Curves.easeInOut.transform(
                    animation.value,
                  );
                  final double elevation = lerpDouble(1, 6, animValue)!;
                  final double scale = lerpDouble(1, 1.02, animValue)!;
                  return Transform.scale(
                    scale: scale,
                    child: Card(elevation: elevation, child: cards[index].child),
                  );
                },
                child: child,
              ),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = CampaignManager
                      .instance
                      .campaign!
                      .options
                      .initiativePriority
                      .removeAt(oldIndex);
                  CampaignManager.instance.campaign!.options.initiativePriority
                      .insert(newIndex, item);
                });
              },
              children: cards,
            ),
          ),
        ),
      ],
    );
  }
}
