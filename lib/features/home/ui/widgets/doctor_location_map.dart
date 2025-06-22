import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class DoctorLocationMap extends StatelessWidget {
  final String locationUrl;

  const DoctorLocationMap({super.key, required this.locationUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: _getLatLngFromUrl(locationUrl),
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: _getLatLngFromUrl(locationUrl),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LatLng _getLatLngFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.queryParameters.containsKey('q')) {
        final coords = uri.queryParameters['q']!.split(',');
        if (coords.length >= 2) {
          final lat = double.parse(coords[0]);
          final lng = double.parse(coords[1]);
          return LatLng(lat, lng);
        }
      }
    } catch (e) {
      debugPrint('Error parsing location URL: $e');
    }
    // Fallback to Cairo coordinates
    return const LatLng(30.033333, 31.233334);
  }
}
