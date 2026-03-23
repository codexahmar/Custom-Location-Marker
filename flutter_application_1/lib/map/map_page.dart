import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'custom_marker_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const _markerPosition = LatLng(39.4818, -0.3559);
  static const _battery = 82;
  static const _imageUrl = 'https://i.pravatar.cc/100?img=13';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: _markerPosition,
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_application_1',
          ),
          MarkerLayer(
            markers: const [
              Marker(
                point: _markerPosition,
                width: 90,
                height: 110,
                child: CustomMarkerWidget(
                  imageUrl: _imageUrl,
                  battery: _battery,
                ),
              ),
            ],
          ),
          const RichAttributionWidget(
            attributions: [TextSourceAttribution('OpenStreetMap contributors')],
          ),
        ],
      ),
    );
  }
}
