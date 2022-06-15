enum TypeItem { text, localImage, itemImage }

class ItemWidget {
  final TypeItem? type;
  final String? image;
  final double? dx;
  final double? dy;
  final double? width;
  final double? height;

  ItemWidget({this.type, this.image, this.dx, this.dy, this.width, this.height});

  ItemWidget.coppyWith({
    TypeItem? type,
    String? image,
    double? dx,
    double? dy,
    double? width,
    double? height,
  }) : this(width: width, height: height, image: image, type: type, dx: dx, dy: dy);
}
