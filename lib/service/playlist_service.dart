import 'package:tune_vault/model/playlist.dart';
import 'package:tune_vault/model/playlist_entry.dart';
import 'package:tune_vault/model/track.dart';

const int notInTheList = -999;

class PlaylistService {
  void addTrack(Playlist playlist, Track track) {
    for (final entry in playlist.entries) {
      if (entry.track.id == track.id) {
        throw StateError('Track "${track.title}" is already in the playlist.');
      }
    }

    final int nextPosition = playlist.entries.length + 1;
    final PlaylistEntry newEntry = PlaylistEntry(
      track: track,
      position: nextPosition,
    );

    playlist.entries.add(newEntry);
  }

  void removeTrack(Playlist playlist, Track track) {
    int indexToRemove = notInTheList;
    for (int i = 0; i < playlist.entries.length; i++) {
      if (playlist.entries[i].track.id == track.id) {
        indexToRemove = i;
        break;
      }
    }

    if (indexToRemove == notInTheList) {
      throw StateError(
        'The Track "${track.title}" is not in the playlist.rack ',
      );
    }

    playlist.entries.removeAt(indexToRemove);
    _reindexPositions(playlist);
  }

  void moveTrack(Playlist playlist, int fromPosition, int toPosition) {
    final int endPostion = playlist.entries.length;
    if (fromPosition < 1 || fromPosition > endPostion){
      throw RangeError('Invalid fromPosition: $fromPosition');
    }
    if (toPosition < 1 || toPosition > endPostion){
      throw RangeError('Invalid fromPosition: $fromPosition');
    }

    if ( toPosition == fromPosition) {
      // move the song to the same location
      return;
    }

    final int fromIndex = fromPosition -1;
    final int toIndex = toPosition -1;
    final PlaylistEntry entryToMove = playlist.entries.removeAt(fromIndex);
    playlist.entries.insert(toIndex, entryToMove);
    _reindexPositions(playlist);

  }

  void _reindexPositions(Playlist playlist) {
    for (int i = 0; i < playlist.entries.length; i++) {
      playlist.entries[i].position = i + 1;
    }
  }
}
