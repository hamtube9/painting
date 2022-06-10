import 'dart:typed_data';

class LocalImage {
  Uint8List? bytes;
  String? id;
  int? dateCreated;
  String? location;

  LocalImage({this.bytes, this.id, this.dateCreated, this.location});
}
