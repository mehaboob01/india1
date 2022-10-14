import 'package:flutter/material.dart';
import 'package:india_one/widgets/text_io.dart';

class HomeEachTileIO extends StatefulWidget {
  String imagePath, title, bgImage;
  var onpressed;

  HomeEachTileIO(this.imagePath, this.title, this.onpressed, this.bgImage,
      {Key? key})
      : super(key: key);

  @override
  State<HomeEachTileIO> createState() => _HomeEachTileIOState();
}

class _HomeEachTileIOState extends State<HomeEachTileIO> {
  double widthIs = 0;
  double tileWidth = 0;

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    tileWidth = widthIs / 3.42;
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
        margin: EdgeInsets.all(5),
        child: Stack(
          children: [
            Image.asset(
              "assets/tile_images/" + widget.bgImage,
              width: tileWidth,
              height: tileWidth,
              fit: BoxFit.fill,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/tile_images/" + widget.imagePath,
                  width: tileWidth / 2,
                  height: tileWidth / 2,
                ),
                TextIO(
                  widget.title,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
