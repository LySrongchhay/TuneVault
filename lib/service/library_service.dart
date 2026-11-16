import '../model/track.dart';

class LibraryService {

final List<Track> _tracks = [];

 List<Track> get tracks {
    return List.from(_tracks);
 }
void addTrack(Track track) {
    _tracks.add(track);
  }

void loadTracks(List<Track> tracks) {
    _tracks.clear();
    _tracks.addAll(tracks);
  }

 List<Track> searchTracks(String query) {
    final String cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return List.from(_tracks);
    }
    final List<Track> results = [];
    for (final track in _tracks) {
      final String title = track.title.toLowerCase();
      final String artist = (track.artistName ?? '').toLowerCase();
      final String album = (track.albumTitle ?? '').toLowerCase();
      if (title.contains(cleanQuery) ||
          artist.contains(cleanQuery) ||
          album.contains(cleanQuery)) {
        results.add(track);
      }
    }
    return results;
  }


bool validateImport(String filepath){
  final String cleanPath = filepath.trim().toLowerCase();

  if(cleanPath.isEmpty || !cleanPath.endsWith('.mp3')){
    return false;
  }

  for(final track in _tracks){
    if(track.localFilePath != null){
      final String existing = track.localFilePath!.trim().toLowerCase();
      if(existing == cleanPath){
        return false;
      }
    }
  }


  return true;
}



}