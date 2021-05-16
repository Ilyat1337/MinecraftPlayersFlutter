import 'package:flutter/material.dart';
import 'package:minecraft_players/src/models/user.dart';
import 'package:minecraft_players/src/pages/edit_page.dart';
import 'package:minecraft_players/src/widgets/details_row.dart';
import 'package:minecraft_players/src/widgets/images_preview.dart';
import 'package:minecraft_players/src/widgets/section.dart';
import 'package:minecraft_players/src/widgets/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils.dart';

class DetailsPage extends StatefulWidget {
  final User user;

  const DetailsPage({Key key, @required this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //final GlobalKey<VideoPlayerState> _videoPlayerKey = GlobalKey();

  Future<void> _onEdit() async {
    // if (widget.user.videoUrl != null) {
    //   _videoPlayerKey.currentState.pauseVideo();
    // }
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EditPage(user: widget.user))
    );
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child:Image.network(user.avatarUrl, width: 150, height: 150)
              ),
              Divider(thickness: 2, height: 30),
              Section(sectionTitle: AppLocalizations.of(context).ingame, children: [
                DetailsRow(
                  leftText: AppLocalizations.of(context).occupation,
                  rightText: Utils.translateEnum(context, user.occupation),
                ),
                DetailsRow(
                  leftText: AppLocalizations.of(context).favouriteMob,
                  rightText: Utils.translateEnum(context, user.favouriteMob),
                ),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).favouriteServer, children: [
                DetailsRow(
                  leftText: AppLocalizations.of(context).serverAddress,
                  rightText: user.favouriteServerAddress,
                ),
                DetailsRow(
                  leftText: AppLocalizations.of(context).privilege,
                  rightText: Utils.translateEnum(context, user.privilege),
                ),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).realWorld, children: [
                DetailsRow(
                  leftText: AppLocalizations.of(context).name,
                  rightText: user.realworldName,
                ),
                DetailsRow(
                  leftText: AppLocalizations.of(context).country,
                  rightText: user.country,
                ),
                DetailsRow(
                  leftText: AppLocalizations.of(context).city,
                  rightText: user.city,
                ),
                DetailsRow(
                    leftText: AppLocalizations.of(context).age,
                    rightText: user.age.toString(),
                ),
              ]),
              user.imageUrls.length != 0 ?
              Section(sectionTitle: AppLocalizations.of(context).gallery, children: [
                SizedBox(height: 10),
                ImagesPreview(imageUrls: user.imageUrls)
              ]) : SizedBox.shrink(),
              user.videoUrl != null ?
              Section(sectionTitle: AppLocalizations.of(context).video, children: [
                SizedBox(height: 10),
                VideoPlayer(
                  //key: _videoPlayerKey,
                  videoUrl: user.videoUrl
                )
              ]) : SizedBox.shrink()
            ]
          )
        )
      ),
      appBar: AppBar(
        title: Text(user.nickname),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: _onEdit,
              child: Icon(Icons.edit),
            )
          )
        ],
      ),
    );
  }
}
