import 'dart:typed_data';

class LocalImage {
  Uint8List? bytes;
  String? id;
  int? dateCreated;
  String? location;
  int? width;
  int? height;
  String? filePath;

  LocalImage({this.bytes, this.id, this.dateCreated, this.location,this.width,this.height,this.filePath});
}
