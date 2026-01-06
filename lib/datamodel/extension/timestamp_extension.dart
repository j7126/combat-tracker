import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:fixnum/fixnum.dart';

extension TimestampExtension on Timestamp {
  DateTime toDateTime() {
    return DateTime.fromMicrosecondsSinceEpoch((seconds * 1000000 + nanos ~/ 1000).toInt());
  }

  static Timestamp now() {
    var now = DateTime.now().microsecondsSinceEpoch;
    return Timestamp(seconds: Int64(now ~/ 1000000), nanos: ((now % 1000000) * 1000));
  }
}