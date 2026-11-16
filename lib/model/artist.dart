import 'album.dart';

class Artist {
  final String id;
  final String name;
  final String? imageAsset;
  final List<Album> albums = [];

  Artist({
    required this.id,
    required this.name,
    this.imageAsset,
    List<Album>? albums,
  }) {
    if (albums != null) {
      this.albums.addAll(albums);
    }
  }

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, albums: ${albums.length})';
  }
}
