import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_page.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick location'),
      ),
      body: GoogleMap(
        initialCameraPosition: MapPage.mapPosition,
        onTap: (LatLng location) {
          Navigator.of(context).pop(location);
        },
      ),
    );
  }
}
