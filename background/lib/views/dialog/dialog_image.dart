import 'dart:typed_data';
import 'dart:ui';

import 'package:background/model/local_image.dart';
import 'package:background/utils/Constant.dart';
import 'package:background/utils/controller/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final int totalImage;

  const ImageScreen({Key? key, required this.totalImage}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      click: () {
        Navigator.of(context).pop();
      },
      height: 160,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: List.generate(
                widget.totalImage,
                (index) => ImageWidget(
                      index: index,
                    ))),
      ),
    );
  }
}

class ImageWidget extends StatefulWidget {
  final int index;

  const ImageWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  var _itemCache = Map<int, LocalImage>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 2.0,
          child: FutureBuilder(
              future: _getItem(widget.index),
              builder: (context, snapshot) {
                LocalImage? item = snapshot.data as LocalImage?;
                if (item != null) {
                  return Image.memory(item.bytes!, fit: BoxFit.cover);
                }

                return Container();
              }),
        ));
  }

  Future<LocalImage> _getItem(int index) async {
    if (_itemCache[index] != null) {
      return _itemCache[index]!;
    } else {
      var channelResponse =
          await methodChannel.invokeMethod(MyStrings.channelMethodFetchImage, index);
      var item = Map<String, dynamic>.from(channelResponse);

      var galleryImage = LocalImage(
          bytes: item['data'],
          id: item['id'],
          dateCreated: item['created'],
          location: item['location']);

      _itemCache[index] = galleryImage;

      return galleryImage;
    }
  }
}
