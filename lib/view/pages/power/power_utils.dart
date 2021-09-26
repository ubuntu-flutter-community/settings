import 'package:duration/duration.dart';

String formatTime(int seconds) {
  return prettyDuration(
    Duration(seconds: seconds),
    tersity: DurationTersity.minute,
  );
}
