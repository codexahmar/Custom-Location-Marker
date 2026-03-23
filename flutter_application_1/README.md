# Custom Marker OpenStreetMap App

Flutter app with OpenStreetMap and a custom widget-based marker.

## Project Structure

- `lib/main.dart`: app entry point
- `lib/map/map_page.dart`: map screen and map logic
- `lib/map/custom_marker_widget.dart`: custom marker UI

## Why OpenStreetMap

- No Google Maps API key required
- Safer for public GitHub repositories
- Simple tile setup using `flutter_map`

## Run The App

```bash
flutter pub get
flutter run
```

## Notes

- Map tiles are loaded from OpenStreetMap tile servers.
- Custom marker code remains separated from map page code.

## Attribution

OpenStreetMap data requires attribution. This app shows attribution on the map using:

- OpenStreetMap contributors
