import 'playlist_entry.dart';
import 'track.dart';

class Playlist {
  final String id;
  String name;
  DateTime dateCreated = DateTime.now();
  String? coverAsset;
  final List<PlaylistEntry> entries = [];

  Playlist({
    required this.id,
    required this.name,
    DateTime? dateCreated,
    this.coverAsset,
    List<PlaylistEntry>? entries,
  }) {
    if (dateCreated != null) {
      this.dateCreated = dateCreated;
    }
    if (entries != null) {
      this.entries.addAll(entries);
    }
  }

  bool get isEmpty {
    return entries.isEmpty;
  }

  int get trackCount {
    return entries.length;
  }

  List<Track> get tracks {
    final List<Track> result = [];
    for (final entry in entries) {
      result.add(entry.track);
    }
    return result;
  }

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, entries: ${entries.length})';
  }
}
