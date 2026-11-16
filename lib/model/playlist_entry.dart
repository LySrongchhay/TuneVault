import 'track.dart';

class PlaylistEntry {
  final Track track;
  int position;
  DateTime addedAt = DateTime.now();

  PlaylistEntry({
    required this.track,
    required this.position,
    DateTime? addedAt,
  }) {
    if (addedAt != null) {
      this.addedAt = addedAt;
    }
  }

  @override
  String toString() {
    return 'PlaylistEntry(position: $position, track: ${track.title})';
  }
}
