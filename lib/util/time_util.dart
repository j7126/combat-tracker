class TimeUtil {
  static String timeDiffString(DateTime dt) {
    var diff =
        DateTime.now().millisecondsSinceEpoch - dt.millisecondsSinceEpoch;
    diff ~/= 1000;
    var s = diff % 60;
    diff ~/= 60;
    var m = diff % 60;
    diff ~/= 60;
    var h = diff % 24;
    diff ~/= 24;
    var d = diff;
    if (d != 0) {
      return "$d d";
    } else if (h != 0) {
      return "$h h";
    } else if (m != 0) {
      return "$m m";
    } else {
      return "$s s";
    }
  }
}
