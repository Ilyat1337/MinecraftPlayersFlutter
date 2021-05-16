import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minecraft_players/src/models/users_model.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'details_page.dart';

class MapPage extends StatefulWidget {
  static final CameraPosition mapPosition = CameraPosition(
      target: LatLng(53.89168, 27.54893),
      zoom: 5.7
  );

  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
      builder: (context, userModel, child) {
        return GoogleMap(
          initialCameraPosition: MapPage.mapPosition,
          markers: userModel.users.where((user) => user.position != null)
            .map((user) {
              return Marker(
                markerId: MarkerId(user.id),
                position: user.position,
                infoWindow: InfoWindow(
                  title: user.nickname,
                  snippet: Utils.translateEnum(context, user.occupation),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DetailsPage(user: user))
                    );
                  }
                ),
              );
            })
            .toSet(),
        );
        // return SafeArea(
        //   child: ListView.separated(
        //     itemBuilder: (context, index) {
        //       final user = loggedUserModel.users[index];
        //       return ListTile(
        //         leading: Image.network(user.avatarUrl),
        //         title: Text(user.nickname),
        //         subtitle: Text('${user.occupation} ${user.age} y.o.'),
        //         onTap: () {
        //           Navigator.of(context).push(
        //               MaterialPageRoute(builder: (_) => DetailsPage(user: user))
        //           );
        //         },
        //       );
        //     },
        //     separatorBuilder: (context, index) => Divider(),
        //     itemCount: loggedUserModel.users.length,
        //   ),
        // );
      },
    );
  }
}
