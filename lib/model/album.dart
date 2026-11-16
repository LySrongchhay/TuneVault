import 'track.dart';

class Album {
  final String id;
  final String title;
  final DateTime? releaseDate;
  final String? coverAsset;
  final List<Track> tracks = [];

  Album({
    required this.id,
    required this.title,
    this.releaseDate,
    this.coverAsset,
    List<Track>? tracks,
  }) {
    if (tracks != null) {
      this.tracks.addAll(tracks);
    }
  }

  @override
  String toString() {
    return 'Album(id: $id, title: $title, tracks: ${tracks.length})';
  }
}
