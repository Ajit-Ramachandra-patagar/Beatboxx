// // audio_handler.dart
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:beatboxx/song.dart';

// class AudioPlayerHandler extends BaseAudioHandler {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   AudioPlayerHandler() {
//     _init();
//   }

//   Future<void> _init() async {
//     // Listen to audio player state changes
//     _audioPlayer.playerStateStream.listen((playerState) {
//       final isPlaying = playerState.playing;
//       final processingState = const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[playerState.processingState]!;

//       playbackState.add(playbackState.value.copyWith(
//         controls: [
//           MediaControl.skipToPrevious,
//           if (isPlaying) MediaControl.pause else MediaControl.play,
//           MediaControl.skipToNext,
//         ],
//         systemActions: const {
//           MediaAction.seek,
//           MediaAction.seekForward,
//           MediaAction.seekBackward,
//         },
//         androidCompactActionIndices: const [0, 1, 2],
//         processingState: processingState,
//         playing: isPlaying,
//         updatePosition: _audioPlayer.position,
//         bufferedPosition: _audioPlayer.bufferedPosition,
//         speed: _audioPlayer.speed,
//         queueIndex: 0,
//       ));
//     });

//     // Listen to position changes
//     _audioPlayer.positionStream.listen((position) {
//       playbackState.add(playbackState.value.copyWith(
//         updatePosition: position,
//       ));
//     });
//   }

//   Future<void> playFromAsset(String assetPath, Song song) async {
//     try {
//       // Update media item
//       mediaItem.add(MediaItem(
//         id: song.audioPath,
//         album: "BeatBox",
//         title: song.songName,
//         artist: song.artistName,
//         duration: null,
//         artUri: Uri.parse('asset:///${song.albumArtImagePath}'),
//       ));

//       await _audioPlayer.setAsset(assetPath);
//       await _audioPlayer.play();
//     } catch (e) {
//       print("Error playing from asset: $e");
//     }
//   }

//   @override
//   Future<void> play() => _audioPlayer.play();

//   @override
//   Future<void> pause() => _audioPlayer.pause();

//   @override
//   Future<void> seek(Duration position) => _audioPlayer.seek(position);

//   @override
//   Future<void> skipToNext() async {
//     // This will be handled by your PlaylistProvider
//   }

//   @override
//   Future<void> skipToPrevious() async {
//     // This will be handled by your PlaylistProvider
//   }

//   @override
//   Future<void> stop() async {
//     await _audioPlayer.stop();
//     await super.stop();
//   }

//   Stream<Duration> get positionStream => _audioPlayer.positionStream;
//   Stream<Duration?> get durationStream => _audioPlayer.durationStream;
//   Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

//   @override
//   Future<void> onTaskRemoved() async {
//     // Handle when app is removed from recent apps
//     await stop();
//   }
// }
