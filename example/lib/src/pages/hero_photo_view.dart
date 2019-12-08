import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class HeroPhotoViewWrapper extends StatefulWidget {
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  HeroPhotoViewWrapper({Key key, this.imageProvider, this.loadingChild, this.backgroundDecoration, this.minScale, this.maxScale}) : super(key: key);
  
  @override
  _HeroPhotoViewWrapperState createState() => _HeroPhotoViewWrapperState();
}

class _HeroPhotoViewWrapperState extends State<HeroPhotoViewWrapper> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: widget.imageProvider,
        loadingChild: widget.loadingChild,
        backgroundDecoration: widget.backgroundDecoration,
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
      ),
    );
  }
}