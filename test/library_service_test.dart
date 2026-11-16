import 'package:test/test.dart';
import 'package:tune_vault/model/track.dart';
import 'package:tune_vault/service/library_service.dart';

void main() {
  final track1 = Track(
    id: '1',
    title: 'Numb',
    artistName: 'Linkin Park',
    albumTitle: 'Meteora',
    audioAsset: 'assets/audio/numb.mp3',
  );

  final track2 = Track(
    id: '2',
    title: 'Shape of You',
    artistName: 'Ed Sheeran',
    albumTitle: 'Divide',
    localFilePath: 'C:/Music/shape_of_you.mp3',
    isImported: true,
  );

  // --- searchTracks() tests ---

  test('Searching a song by its title', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final results = libraryService.searchTracks('Numb');

    expect(results.length, 1);
    expect(results.first.title, 'Numb');
  });

  test('Searching with different uppercase and lowercase letters', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final results = libraryService.searchTracks('sHaPe Of YoU');

    expect(results.length, 1);
    expect(results.first.title, 'Shape of You');
  });

  test('Searching for a word that matches nothing (empty result)', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final results = libraryService.searchTracks('NonExistentSong');

    expect(results.isEmpty, true);
  });

  

  test('Importing a valid MP3 file', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final isValid = libraryService.validateImport('C:/Music/new_song.mp3');

    expect(isValid, true);
  });

  test('Attempting to import a file that is not an MP3', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final isValid = libraryService.validateImport('C:/Music/not_audio.wav');

    expect(isValid, false);
  });

  test('Attempting to import the same file twice', () {
    final libraryService = LibraryService();
    libraryService.loadTracks([track1, track2]);

    final isValid = libraryService.validateImport('C:/Music/shape_of_you.mp3');

    expect(isValid, false);
  });
}