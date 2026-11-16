import 'package:test/test.dart';
import 'package:tune_vault/model/track.dart';
import 'package:tune_vault/service/player_service.dart';

void main() {
  final track1 = Track(id: '1', title: 'Song One');
  final track2 = Track(id: '2', title: 'Song Two');
  final track3 = Track(id: '3', title: 'Song Three');

  // --- next() tests ---

  test('Moving to the next song in the queue', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3]);

    final nextTrack = player.next();

    expect(nextTrack, track2);
    expect(player.currentTrack, track2);
  });

  test('Using next with repeat one (the same song plays again)', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3]);
    player.setRepeatMode(RepeatMode.one);

    final nextTrack = player.next();

    expect(nextTrack, track1);
    expect(player.currentTrack, track1);
  });

  test('Using next on the last song with repeat on (back to the first song)', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3], startIndex: 2);
    player.setRepeatMode(RepeatMode.all);

    final nextTrack = player.next();

    expect(nextTrack, track1);
    expect(player.currentTrack, track1);
  });

  test('Using next on the last song with repeat off (playback stops)', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3], startIndex: 2);
    player.setRepeatMode(RepeatMode.off);

    final nextTrack = player.next();

    expect(nextTrack, null);
  });

  // --- toggleShuffle() tests ---

  test('Shuffling a queue (same songs, no duplicates, none lost)', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3]);

    player.toggleShuffle();

    expect(player.isShuffled, true);
    expect(player.queue.length, 3);
    expect(player.queue.contains(track1), true);
    expect(player.queue.contains(track2), true);
    expect(player.queue.contains(track3), true);
  });

  test('Turning shuffle off (original order restored, current song unchanged)', () {
    final player = PlayerService();
    player.loadQueue([track1, track2, track3], startIndex: 1); // playing track2

    player.toggleShuffle(); // turn shuffle ON
    player.toggleShuffle(); // turn shuffle OFF

    expect(player.isShuffled, false);
    expect(player.queue, [track1, track2, track3]);
    expect(player.currentTrack, track2);
  });
}