import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/track.dart';
import '../providers/music_provider.dart';

class TrackDetailScreen extends StatefulWidget {
  final Track track;
  const TrackDetailScreen({super.key, required this.track});

  @override
  State<TrackDetailScreen> createState() => _TrackDetailScreenState();
}

class _TrackDetailScreenState extends State<TrackDetailScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  MusicProvider? _musicProvider;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<MusicProvider>(context);
    if (_musicProvider != provider) {
      _musicProvider?.removeListener(_onMusicChanged);
      _musicProvider = provider;
      _musicProvider?.addListener(_onMusicChanged);
      // Iniciar/pausar según estado actual
      if (_musicProvider!.isPlaying) {
        _rotationController.repeat();
      } else {
        _rotationController.stop(canceled: false);
      }
    }
  }

  void _onMusicChanged() {
    if (!mounted) return;
    final isPlaying = _musicProvider?.isPlaying ?? false;
    if (isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop(canceled: false);
    }
  }

  @override
  void dispose() {
    _musicProvider?.removeListener(_onMusicChanged);
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = context.watch<MusicProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.track.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _rotationController,
              child: Hero(
                tag: 'avatar-${widget.track.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(widget.track.image, width: 300, height: 300, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(widget.track.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(widget.track.artist, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 40),
            AnimatedScale(
              scale: musicProvider.isPlaying ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                iconSize: 80,
                icon: Icon(musicProvider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                onPressed: () => musicProvider.playTrack(widget.track),
              ),
            )
          ],
        ),
      ),
    );
  }
}