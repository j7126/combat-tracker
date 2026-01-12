import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/damage_event.pb.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:uuid/uuid.dart';

extension CharacterExtension on Character {
  double get initiativeDouble => (initiative / 10);
  set initiativeDouble(double value) {
    initiative = (value * 10).round();
  }

  String get initiativeString => initiative % 10 == 0
      ? initiativeDouble.toStringAsFixed(0)
      : initiativeDouble.toStringAsFixed(1);

  int get initiativeInt => initiativeDouble.floor();

  void setLifeWithTrackedDamage(int newLife, String source) {
    var damageEvent = DamageEvent(
      previousLife: life,
      change: newLife - life,
      source: source,
      timestamp: TimestampExtension.now(),
    );
    life = newLife;
    damageEvents.add(damageEvent);
  }

  static Character createCharacter() {
    return Character(id: Uuid().v4());
  }
}
