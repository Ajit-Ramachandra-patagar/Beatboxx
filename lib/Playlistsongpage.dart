import 'package:beatboxx/Playlist.dart';
import 'package:beatboxx/Song_page.dart';
import 'package:beatboxx/song.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistSongsPage extends StatefulWidget {
  const PlaylistSongsPage({super.key});

  @override
  State<PlaylistSongsPage> createState() => _PlaylistSongsPageState();
}

class _PlaylistSongsPageState extends State<PlaylistSongsPage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final int? playlistIndex = value.currentPlaylistIndex;
        if (playlistIndex == null) {
          return const Scaffold(
            body: Center(child: Text("No playlist selected")),
          );
        }
        final Playlist playlist = value.playlists[playlistIndex];
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text(playlist.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.greenAccent[400],
          ),
          body: ListView.builder(
            itemCount: playlist.songs.length,
            itemBuilder: (context, index) {
              final Song song = playlist.songs[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          ),
        );
      },
    );
  }
}
