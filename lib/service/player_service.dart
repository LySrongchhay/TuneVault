import 'dart:math';

import '../model/playlist.dart';
import '../model/track.dart';

enum RepeatMode { off, all, one }

class PlayerService {

  final List<Track> _originalQueue = [];
  List<Track> _queue = [];
  int _currentIndex = -1;
  bool _isShuffle = false;
  RepeatMode _repeatMode = RepeatMode.off;
  

  Track? get currentTrack {
    if (_currentIndex < 0 || _currentIndex >= _queue.length) {
      return null;
    }
    return _queue[_currentIndex];
  }

  List<Track> get queue {
    return List.from(_queue);
  }
  bool get isShuffled => _isShuffle;
  RepeatMode get repeatMode => _repeatMode;


 void loadPlaylist(Playlist playlist, {int startIndex = 0}) {
    loadQueue(playlist.tracks, startIndex: startIndex);
  }

 void loadQueue (List<Track> tracks , {int startIndex = 0}){
    _originalQueue.clear();
    _originalQueue.addAll(tracks);

    _queue = List.from(_originalQueue);
    _isShuffle = false;

    if(_queue.isEmpty){
        _currentIndex = -1;
    }else if (startIndex < 0){
        _currentIndex = 0;
    }else if (startIndex >= _queue.length){
        _currentIndex = queue.length-1;
    }else{
        _currentIndex = startIndex;
    }


 }

 void setRepeatMode(RepeatMode mode){
    _repeatMode = mode;
 }

 void toggleShuffle(){
    _isShuffle = !_isShuffle;

    if(_queue.isEmpty){
        return;
    }

    final Track? activeTrack = currentTrack;

    if(_isShuffle){
        _queue = List.from(_originalQueue);
        _queue.shuffle(Random());
    }else{
        _queue = List.from(_originalQueue);
    }

    if(activeTrack != null){
        _currentIndex = _queue.indexOf(activeTrack);
    }

 }

 Track? next(){
    
    if (_queue.isEmpty){
        return null;
    }

    switch(_repeatMode){
        
        case RepeatMode.one: return currentTrack;
        case RepeatMode.all:
            if (_currentIndex + 1 < _queue.length) {
            _currentIndex++;
            } else {
            _currentIndex = 0;
            }
            return currentTrack;
        case RepeatMode.off:
            if (_currentIndex + 1 < _queue.length) {
            _currentIndex++;
            return currentTrack;
            }

        return null;

        
    }

 }



  



}
