class Track {
  final String id;
  final String title;
  final int durationSec;
  final String genre;
  final String? artistName;
  final String? albumTitle;
  final String? audioAsset;
  final String? localFilePath;
  final bool isImported;

  Track({
    required this.id,
    required this.title,
    this.durationSec = 0,
    this.genre = 'Unknown',
    this.artistName,
    this.albumTitle,
    this.audioAsset,
    this.localFilePath,
    this.isImported = false,
  });

  String? get sourcePath {
    if (isImported) {
      return localFilePath;
    }
    return audioAsset;
  }

  @override
  String toString() {
    return 'Track(id: $id, title: $title, genre: $genre, isImported: $isImported)';
  }
}
