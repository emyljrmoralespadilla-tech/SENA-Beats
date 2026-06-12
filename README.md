# Cambios Detectados

## Archivos modificados

### lib/main.dart
- Se añadió el import para la dependencia de Supabase.
- Se añadió la `url` y `anon_key` para el acceso a la base de datos de Supabase.
- Se pasó de usar `context.watch<MusicProvider>()` a usar `Consumer<MusicProvider>`.

### lib/models/track.dart
- Se añadió el método `fromJson` para leer la información de los datos en Supabase.

### lib/screens/main_screen.dart
- Se añadió el import para acceder a `remote_missions_screen.dart`.
- Se añadió una opción en `BottomNavigationBar` para permitir el acceso a `remote_missions_screen.dart`.
- En `BottomNavigationBar` se agregaron las propiedades:
  - `type: BottomNavigationBarType.fixed`
  - `backgroundColor: Theme.of(context).colorScheme.surface`
  - `selectedItemColor: Theme.of(context).colorScheme.primary`
  - `unselectedItemColor: Colors.grey`
- Los items en `BottomNavigationBar` pasaron a ser `const`.

### lib/screens/search_screen.dart
- Se añadió el import de `lib/screens/track_detail_screen.dart`.
- Se cambió el `GestureDetector` de ser una llamada directa a `MusicProvider.playTrack(track)` a que el `onTap` navegue a `TrackDetailScreen(track: track)`.
- Se cambió el `Stack` que mostraba la imagen junto al icono de reproducir/pausar superpuesto a ser un `Hero` widget con `ClipRRect` sin tener el icono de reproducir/pausar superpuesto.
- Se añadió un `errorBuilder` para mostrar un icono de `Icons.broken_image` en un `Container` gris oscuro.

### lib/screens/track_detail_screen.dart
- Se convirtió `TrackDetailScreen` en un `StatefulWidget`.
- Se añadió un `AnimationController` y un `RotationTransition` para que la carátula gire continuamente cuando `isPlaying == true`.
- La rotación se detiene en su posición actual cuando la reproducción se pausa.
- Se mantiene la lógica de botón de reproducción/pausa y el `Hero` para la carátula.

## Dependencias nuevas
- `supabase_flutter: ^2.12.4`

## Archivos nuevos
- `lib/screens/remote_missions_screen.dart` para leer y mostrar al usuario la información almacenada en Supabase.
- `lib/screens/track_detail_screen.dart` para poder pausar y reproducir las canciones.
- `lib/services/supabase_service.dart` para el servicio de conexión con la base de datos de Supabase.
