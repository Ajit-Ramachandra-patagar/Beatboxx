import 'package:beatboxx/My_drawer.dart';
import 'package:beatboxx/Playlist.dart';
import 'package:beatboxx/Playlistsongpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  // Define playlist cover images
  final List<String> playlistImages = [
    "assets/images/bollywood.jpg", // Pop Hits playlist image
    "assets/images/img2.webp", // South Vibes playlist image
    "assets/images/img3.webp" // Romantic playlist image
  ];

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToPlaylist(int playlistIndex) {
    playlistProvider.currentPlaylistIndex = playlistIndex;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaylistSongsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("B E A T  B O X"),
        backgroundColor: Colors.greenAccent[400],
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Playlist> playlists = value.playlists;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final Playlist playlist = playlists[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      playlist.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('${playlist.songs.length} songs'),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(playlistImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => goToPlaylist(index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
