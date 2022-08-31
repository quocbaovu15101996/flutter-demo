import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
            initialCameraPosition: const CameraPosition(
                target: LatLng(20.978057, 105.7938073), zoom: 12),
          ),
        ),
      ],
    );
  }
}
