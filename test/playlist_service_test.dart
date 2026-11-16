import 'package:test/test.dart';
import 'package:tune_vault/model/playlist.dart';
import 'package:tune_vault/model/track.dart';
import 'package:tune_vault/service/playlist_service.dart';

void main() {
  late PlaylistService service;
  late Playlist playlist;
  late Track t1;
  late Track t2;
  late Track t3;
  late Track t4;
  late Track t5;

  setUp(() {
    service = PlaylistService();
    playlist = Playlist(id: 'p1', name: 'Study Mix');
    t1 = Track(id: 't1', title: 'Track 1');
    t2 = Track(id: 't2', title: 'Track 2');
    t3 = Track(id: 't3', title: 'Track 3');
    t4 = Track(id: 't4', title: 'Track 4');
    t5 = Track(id: 't5', title: 'Track 5');
  });

  group('PlaylistService.addTrack', () {
    test('adds a new track at the end with position 1, 2, ...', () {
      service.addTrack(playlist, t1);
      service.addTrack(playlist, t2);

      expect(playlist.trackCount, 2);
      expect(playlist.entries[0].track.id, 't1');
      expect(playlist.entries[0].position, 1);
      expect(playlist.entries[1].track.id, 't2');
      expect(playlist.entries[1].position, 2);
    });

    test('throws StateError when adding a duplicate track', () {
      service.addTrack(playlist, t1);

      expect(() => service.addTrack(playlist, t1), throwsStateError);
      expect(playlist.trackCount, 1);
    });
  });

  group('PlaylistService.removeTrack', () {
    test('removes a middle track and keeps positions 1, 2, 3...', () {
      service.addTrack(playlist, t1);
      service.addTrack(playlist, t2);
      service.addTrack(playlist, t3);

      service.removeTrack(playlist, t2);

      expect(playlist.trackCount, 2);
      expect(playlist.entries[0].track.id, 't1');
      expect(playlist.entries[0].position, 1);
      expect(playlist.entries[1].track.id, 't3');
      expect(playlist.entries[1].position, 2);
    });

    test('removing the last remaining track makes playlist empty', () {
      service.addTrack(playlist, t1);

      service.removeTrack(playlist, t1);

      expect(playlist.isEmpty, isTrue);
      expect(playlist.trackCount, 0);
    });
  });

  group('PlaylistService.moveTrack', () {
    test('moves track from position 5 to position 2 and keeps positions consecutive', () {
      service.addTrack(playlist, t1);
      service.addTrack(playlist, t2);
      service.addTrack(playlist, t3);
      service.addTrack(playlist, t4);
      service.addTrack(playlist, t5);

      service.moveTrack(playlist, 5, 2);

      expect(playlist.tracks.map((t) => t.id).toList(), ['t1', 't5', 't2', 't3', 't4']);
      for (int i = 0; i < playlist.entries.length; i++) {
        expect(playlist.entries[i].position, i + 1);
      }
    });

    test('throws RangeError when moving to or from an invalid position', () {
      service.addTrack(playlist, t1);
      service.addTrack(playlist, t2);

      expect(() => service.moveTrack(playlist, 1, 5), throwsRangeError);
      expect(() => service.moveTrack(playlist, 0, 1), throwsRangeError);
      expect(playlist.tracks.map((t) => t.id).toList(), ['t1', 't2']);
    });

    test('moving a track to its own position leaves playlist unchanged', () {
      service.addTrack(playlist, t1);
      service.addTrack(playlist, t2);
      service.addTrack(playlist, t3);

      service.moveTrack(playlist, 2, 2);

      expect(playlist.tracks.map((t) => t.id).toList(), ['t1', 't2', 't3']);
      expect(playlist.entries[0].position, 1);
      expect(playlist.entries[1].position, 2);
      expect(playlist.entries[2].position, 3);
    });
  });
}