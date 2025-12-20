import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/damage_event.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
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
    var now = DateTime.now().millisecondsSinceEpoch;
    var damageEvent = DamageEvent(
      previousLife: life,
      change: newLife - life,
      source: source,
      timestamp: Timestamp(seconds: Int64(now ~/ 1000), nanos: ((now % 1000) * 1000000)),
    );
    life = newLife;
    damageEvents.add(damageEvent);
  }

  static Character createCharacter() {
    return Character(id: Uuid().v4());
  }
}
