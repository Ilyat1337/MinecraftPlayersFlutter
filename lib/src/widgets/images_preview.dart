import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minecraft_players/src/pages/gallery_page.dart';

class ImagesPreview extends StatelessWidget {
  final List<String> imageUrls;
  const ImagesPreview({Key key, @required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: imageUrls.take(4).map((imageUrl) =>
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.network(imageUrl, fit: BoxFit.cover)
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) =>
                GalleryPage(
                    imageUrls: imageUrls,
                    selectedTab: imageUrls.indexOf(imageUrl)
                )
              )
            );
          },
        )
      ).toList(),
    );
  }
}
