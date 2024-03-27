import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

extension ImageUtils on Image {

  /// Adds a border to the image
  /// USAGE: myImage.addBorder(Colors.red, 1.0)
  Widget addBorder(Color color, double width) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
      ),
      child: this,
    );
  }

  /// Converts the image to grayscale
  /// USAGE: myImage.toGrayscale()
  ColorFiltered toGrayscale() {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.grey,
        BlendMode.saturation,
      ),
      child: this,
    );
  }

  /// Rounds the corners of the image
  /// USAGE: myImage.roundedCorners(10.0);
  Widget roundedCorners(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// Applies a circular mask to the image
  /// USAGE: myImage.circularMask();
  Widget circularMask() {
    return ClipOval(child: this);
  }

  /// Adds a shadow to the image
  /// USAGE: myImage.addShadow(color: Colors.grey, blurRadius: 15.0)
  Widget addShadow({
    Color color = Colors.black,
    double blurRadius = 10.0,
    Offset offset = const Offset(5.0, 5.0),
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            offset: offset,
          ),
        ],
      ),
      child: this,
    );
  }

  /// Applies a sepia tone to the image
  /// USAGE: myImage.toSepia()
  ColorFiltered toSepia() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.393, 0.769, 0.189, 0, 0,
        0.349, 0.686, 0.168, 0, 0,
        0.272, 0.534, 0.131, 0, 0,
        0,     0,     0,     1, 0,
      ]),
      child: this,
    );
  }

  /// Inverts the colors of the image
  /// USAGE: myImage.invertColors()
  ColorFiltered invertColors() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        -1,  0,  0, 0, 255,
        0, -1,  0, 0, 255,
        0,  0, -1, 0, 255,
        0,  0,  0, 1,   0,
      ]),
      child: this,
    );
  }

  /// Adjusts the brightness of the image
  /// USAGE: myImage.adjustBrightness(1.0)
  Widget adjustBrightness(double adjustment) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix([
        adjustment, 0, 0, 0, 0,
        0, adjustment, 0, 0, 0,
        0, 0, adjustment, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      child: this,
    );
  }

  /// Adjust image exposure
  /// USAGE: myImage.adjustExposure(1.0);
  Widget adjustExposure(double exposure) {
    final matrix = <double>[
      1, 0, 0, 0, exposure * 255,
      0, 1, 0, 0, exposure * 255,
      0, 0, 1, 0, exposure * 255,
      0, 0, 0, 1, 0,
    ];
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(matrix),
      child: this,
    );
  }

  /// Applies a blur effect to the image
  /// USAGE: myImage.blurImage(1.0, 1.0)
  Widget blurImage(double sigmaX, double sigmaY) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: this,
    );
  }

  /// Converts the image to a circle with a border
  /// USAGE: myImage.circleWithBorder(Colors.red, 1.0);
  Widget circleWithBorder(Color borderColor, double borderWidth) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(child: this),
    );
  }

  /// Adds a color overlay to the image
  /// USAGE: myImage.colorOverlay(Colors.red);
  Widget colorOverlay(Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.color,
      ),
      child: this,
    );
  }

  /// Creates a mirror effect of the image
  /// USAGE: myImage.mirrorImage(Axis.vertical);
  Widget mirrorImage(Axis axis) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(axis == Axis.horizontal ? pi : 0)..rotateX(axis == Axis.vertical ? pi : 0),
      child: this,
    );
  }

  /// Rotates the image by a given number of degrees
  /// USAGE: myImage.rotate(90);
  Widget rotate(double degrees) {
    final radians = degrees * pi / 180;
    return Transform.rotate(
      angle: radians,
      child: this,
    );
  }

  /// Flips the image horizontally
  /// USAGE: myImage.flipHorizontally();
  Widget flipHorizontally() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: this,
    );
  }

  /// Flips the image vertically
  /// USAGE: myImage.flipVertically();
  Widget flipVertically() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationX(pi),
      child: this,
    );
  }

  /// Crops the image to the specified width and height
  /// USAGE: myImage.crop(100, 150);
  Widget crop(double width, double height) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: SizedBox(
          width: width,
          height: height,
          child: this,
        ),
      ),
    );
  }

  /// Convert the image to Base64
  /// USAGE: myImage.toBase64().then((String base64String) { });
  Future<String> toBase64() async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    // Use the image property of the Image widget to resolve the image.
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );
    final ui.Image resolvedImage = await completer.future;
    final ByteData? byteData = await resolvedImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert image to byte data');
    }
    final Uint8List uInt8list = byteData.buffer.asUint8List();
    return base64Encode(uInt8list);
  }

}