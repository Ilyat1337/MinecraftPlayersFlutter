import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minecraft_players/src/models/user.dart';
import 'package:minecraft_players/src/pages/location_picker.dart';
import 'package:minecraft_players/src/services/media_service.dart';
import 'package:minecraft_players/src/services/storage_service.dart';
import 'package:minecraft_players/src/widgets/enum_dropdown.dart';
import 'package:minecraft_players/src/widgets/section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils.dart';

class DisplayedImage {
  final String path;
  final bool isUploaded;

  DisplayedImage(this.path, {this.isUploaded = true});
}

typedef AddImageCallback = void Function(String imagePath);
typedef DeleteImageCallback = void Function(int imageIndex);

class ImageEditor extends StatelessWidget {
  final List<DisplayedImage> displayedImages;
  final AddImageCallback addImageCallback;
  final DeleteImageCallback deleteImageCallback;
  final picker = ImagePicker();

  ImageEditor({Key key,
    @required this.displayedImages,
    @required this.addImageCallback,
    @required this.deleteImageCallback}) : super(key: key);

  void _addImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      addImageCallback(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: displayedImages.map((displayedImage) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                      width: 70,
                      height: 50,
                      child: displayedImage.isUploaded ?
                        Image.network(displayedImage.path, fit: BoxFit.cover) :
                        Image.file(File(displayedImage.path), fit: BoxFit.cover)
                    )
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      var index = displayedImages.indexOf(displayedImage);
                      deleteImageCallback(index);
                    },
                    child: Text(AppLocalizations.of(context).delete)
                  )
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row (
          children: [
            Spacer(),
            SizedBox(
              width: 250,
              child: ElevatedButton(onPressed: _addImage,
                  child: Text(AppLocalizations.of(context).addImage)),
            ),
            Spacer()
          ],
        )
      ],
    );
  }
}

typedef SetVideoPathCallback = void Function(String videoPath);

class VideoEditor extends StatelessWidget {
  final SetVideoPathCallback setVideoPathCallback;
  final bool isVideoSelected;
  final picker = ImagePicker();

  VideoEditor({Key key, @required this.setVideoPathCallback,
    @required this.isVideoSelected}) : super(key: key);

  void _addVideo() async {
    final pickedVideo = await picker.getVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setVideoPathCallback(pickedVideo.path);
    }
  }

  void _deleteVideo() {
    setVideoPathCallback(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Spacer(),
            SizedBox(
              width: 250,
              child: isVideoSelected ?
              ElevatedButton(onPressed: _deleteVideo,
                  child: Text(AppLocalizations.of(context).deleteVideo),
                style: ElevatedButton.styleFrom(primary: Colors.red)) :
              ElevatedButton(onPressed: _addVideo,
                  child: Text(AppLocalizations.of(context).addVideo))
            ),
            Spacer()
          ],
        )
      ],
    );
  }
}



class EditPage extends StatefulWidget {
  final User user;
  const EditPage({Key key, @required this.user}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _serverController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  OccupationType _occupation;
  MobType _favouriteMob;
  PrivilegeType _privilege;
  bool _isSaving = false;
  List<DisplayedImage> _displayedImages = [];
  List<String> _imagesToDelete = [];
  String _selectedVideoPath;
  bool _videoNeedsDeleting = false;
  LatLng _position;

  @override
  void initState() {
    super.initState();

    final user = widget.user;
    _occupation = user.occupation;
    _favouriteMob = user.favouriteMob;
    _privilege = user.privilege;
    _serverController.text = user.favouriteServerAddress;
    _nameController.text = user.realworldName;
    _countryController.text = user.country;
    _cityController.text = user.city;
    _ageController.text = user.age.toString();

    _position = user.position;
    if (user.position != null) {
      _latitudeController.text = user.position.latitude.toString();
      _longitudeController.text = user.position.longitude.toString();
    }

    _selectedVideoPath = user.videoUrl;
    print(_selectedVideoPath);

    _displayedImages = user.imageUrls
       .map((imageUrl) => new DisplayedImage(imageUrl)).toList();

    //setState(() {  });
  }

  @override
  void dispose() {
    _serverController.dispose();
    _nameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();

    super.dispose();
  }

  void _addImage(String imagePath) {
    setState(() {
      _displayedImages.add(DisplayedImage(imagePath, isUploaded: false));
    });
  }

  void _deleteImage(int imageIndex) {
    final displayedImage = _displayedImages[imageIndex];
    if (displayedImage.isUploaded) {
      _imagesToDelete.add(displayedImage.path);
    }

    setState(() {
      _displayedImages.removeAt(imageIndex);
    });
  }

  void _setVideoPath(String videoPath) {
    if (videoPath == null && widget.user.videoUrl != null) {
      _videoNeedsDeleting = true;
    }

    setState(() {
      _selectedVideoPath = videoPath;
    });
  }

  void _updateUser() async {
    try {
      setState(() { _isSaving = true; });

      final user = widget.user;

      final mediaService = GetIt.I.get<MediaService>();
      await mediaService.deleteImages(_imagesToDelete);
      final uploadedImageUrls = await mediaService.uploadImages(user.id,
          _displayedImages
            .where((image) => !image.isUploaded)
            .map((image) => image.path).toList());

      var newVideoUrl = user.videoUrl;
      if (_videoNeedsDeleting) {
        await mediaService.deleteVideo(user.videoUrl);
        newVideoUrl = null;
      }
      if (user.videoUrl != _selectedVideoPath && _selectedVideoPath != null) {
        newVideoUrl = await mediaService.uploadVideo(user.id, _selectedVideoPath);
      }

      final updatedUser = _getUpdatedUser(uploadedImageUrls, newVideoUrl);
      final storageService = GetIt.I.get<StorageService>();
      await storageService.updateUser(updatedUser);

      _videoNeedsDeleting = false;
      _selectedVideoPath = updatedUser.videoUrl;
      _imagesToDelete.clear();
      _displayedImages = updatedUser.imageUrls
          .map((imageUrl) => new DisplayedImage(imageUrl)).toList();
    } catch (e) {
      _handleError(e.toString());
    } finally {
      setState(() { _isSaving = false; });
    }
  }

  User _getUpdatedUser(List<String> uploadedImageUrls, String newVideoUrl) {
    final user = widget.user;

    user.occupation = _occupation;
    user.favouriteMob = _favouriteMob;
    user.favouriteServerAddress = _serverController.text;
    user.privilege = _privilege;
    user.realworldName = _nameController.text;
    user.country = _countryController.text;
    user.city = _cityController.text;
    user.age = int.tryParse(_ageController.text) ?? 0;
    user.position = _position;

    var previousImageCount = _displayedImages
        .where((image) => image.isUploaded).length;
    user.imageUrls = _displayedImages
        .take(previousImageCount)
        .map((image) => image.path)
        .toList();
    user.imageUrls.addAll(uploadedImageUrls);

    user.videoUrl = newVideoUrl;

    return user;
  }

  void _handleError(String errorMessage) {
    Utils.showOkDialog(AppLocalizations.of(context).error, errorMessage, context);
  }

  void _addCoordinates() async {
    final coordinates = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LocationPicker())
    ) as LatLng;

    if (coordinates != null) {
      _position = coordinates;
      _latitudeController.text = coordinates.latitude.toString();
      _longitudeController.text = coordinates.longitude.toString();
    }
  }

  void _removeCoordinates() {
    _position = null;
    _latitudeController.text = "";
    _longitudeController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    print("Displayed images count: ${_displayedImages.length}");
    print("Added images count images count: ${_displayedImages.where((element) => !element.isUploaded).length}");
    print("Deleted images count: ${_imagesToDelete.length}");
    print("Is video selected: ${_selectedVideoPath != null}");
    print("Video need deleting: $_videoNeedsDeleting");
    print("");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              Section(sectionTitle: AppLocalizations.of(context).ingame, children: [
                EnumDropdown(value: _occupation, values: OccupationType.values,
                  onChanged: (occupation) {
                    setState(() {
                      _occupation = occupation;
                    });
                  }),
                EnumDropdown(value: _favouriteMob, values: MobType.values,
                  onChanged: (mob) {
                    setState(() {
                      _favouriteMob = mob;
                    });
                  }),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).favouriteServer, children: [
                TextField(
                  controller: _serverController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).serverAddress),
                ),
                EnumDropdown(value: _privilege, values: PrivilegeType.values,
                  onChanged: (privilege) {
                    setState(() {
                      _privilege = privilege;
                    });
                  }),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).realWorld, children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).name),
                ),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).country),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).city),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).age),
                ),
              ]),
              Section(
                  sectionTitle: AppLocalizations.of(context).coordinates,
                  rightWidget: Row(
                    children: [
                      GestureDetector(
                        onTap: _addCoordinates,
                        child: Icon(Icons.add_circle_outlined),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: _removeCoordinates,
                        child: Icon(Icons.remove_circle_outlined),
                      ),
                    ],
                  ),
                  children: [
                    TextField(
                      controller: _latitudeController,
                      enabled: false,
                      decoration: InputDecoration(labelText:
                        AppLocalizations.of(context).latitude),
                    ),
                    TextField(
                      controller: _longitudeController,
                      enabled: false,
                      decoration: InputDecoration(labelText:
                        AppLocalizations.of(context).longitude),
                    ),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).images, children: [
                ImageEditor(
                  displayedImages: _displayedImages,
                  addImageCallback: _addImage,
                  deleteImageCallback: _deleteImage
                )
              ]),
              Section(sectionTitle: AppLocalizations.of(context).video, children: [
                VideoEditor(
                  setVideoPathCallback: _setVideoPath,
                  isVideoSelected: _selectedVideoPath != null
                )
              ])
            ]),
        )
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).edit),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: _updateUser,
              child: _isSaving ?
                Center(child:
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(backgroundColor: Colors.white),
                  )
                ) :
                Icon(Icons.save),
            )
          )
        ],
      ),
    );
  }
}
