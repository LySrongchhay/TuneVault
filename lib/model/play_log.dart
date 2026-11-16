import 'track.dart';

class PlayLog {
  final String id;
  final Track track;
  final int secondsPlayed;
  DateTime playedAt = DateTime.now();

  PlayLog({
    required this.id,
    required this.track,
    this.secondsPlayed = 0,
    DateTime? playedAt,
  }) {
    if (playedAt != null) {
      this.playedAt = playedAt;
    }
  }

  @override
  String toString() {
    return 'PlayLog(id: $id, track: ${track.title}, playedAt: $playedAt)';
  }
}
