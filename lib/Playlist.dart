import 'package:audioplayers/audioplayers.dart';
import 'package:beatboxx/song.dart';
import 'package:flutter/material.dart';

class Playlist {
  final String name;
  final List<Song> songs;

  Playlist({required this.name, required this.songs});
}

class PlaylistProvider extends ChangeNotifier {
  final List<Playlist> _playlists = [
    // Pop Hits Playlist
    Playlist(
      name: "Pop Hits",
      songs: [
        Song(
          songName: "Ranjaha",
          artistName: "Arijit Singh",
          albumArtImagePath: "assets/images/ranjah.jpg",
          audioPath: "songs/ranjah.mp3",
        ),
        Song(
          songName: "Phele Bhi mai",
          artistName: "Vishal",
          albumArtImagePath: "assets/images/pele.jpg",
          audioPath: "songs/phele.mp3",
        ),
        Song(
          songName: "Sajani Re",
          artistName: "Arijit Singh",
          albumArtImagePath: "assets/images/sajni.png",
          audioPath: "songs/sajni.mp3",
        ),
      ],
    ),

    // South Vibes Playlist
    Playlist(
      name: "South Vibes",
      songs: [
        Song(
          songName: "Anuv Jain Song",
          artistName: "Anuv Jain",
          albumArtImagePath: "assets/images/anuv.jpg",
          audioPath: "songs/anuv.mp3",
        ),
        Song(
          songName: "Soni Soni",
          artistName: "Arijit Singh",
          albumArtImagePath: "assets/images/soni.jpg",
          audioPath: "songs/sonioni.mp3",
        ),
        Song(
          songName: "Chaleya",
          artistName: "Arijit Singh",
          albumArtImagePath: "assets/images/chaleya.webp",
          audioPath: "songs/Chaleya.mp3",
        ),
      ],
    ),

    // Romantic Playlist
    Playlist(
      name: "Romantic",
      songs: [
        Song(
          songName: "Saiyara",
          artistName: "Mohit Chauhan",
          albumArtImagePath: "assets/images/saiyara.jpg",
          audioPath: "songs/Saiyara.mp3",
        ),
        Song(
          songName: "Tu Hai Kaha",
          artistName: "AUR",
          albumArtImagePath: "assets/images/tuhaikaha.jpg",
          audioPath: "songs/tuhaikaha.mp3",
        ),
        Song(
          songName: "Akhiyaan",
          artistName: "Mitraz",
          albumArtImagePath: "assets/images/akhiyan.jpg",
          audioPath: "songs/Akhiyaan.mp3",
        ),
      ],
    ),
  ];

  int? _currentPlaylistIndex;
  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    if (_currentPlaylistIndex == null || _currentSongIndex == null) return;
    final String path =
        _playlists[_currentPlaylistIndex!].songs[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentPlaylistIndex == null || _currentSongIndex == null) return;
    if (_currentSongIndex! <
        _playlists[_currentPlaylistIndex!].songs.length - 1) {
      currentSongIndex = _currentSongIndex! + 1;
    } else {
      currentSongIndex = 0;
    }
  }

  void playPreviousSong() async {
    if (_currentPlaylistIndex == null || _currentSongIndex == null) return;
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlists[_currentPlaylistIndex!].songs.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Playlist> get playlists => _playlists;
  int? get currentPlaylistIndex => _currentPlaylistIndex;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentPlaylistIndex(int? newIndex) {
    _currentPlaylistIndex = newIndex;
    _currentSongIndex = null; // Reset song index when changing playlist
    notifyListeners();
  }

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
