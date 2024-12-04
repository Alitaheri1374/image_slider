import 'package:flutter/material.dart';

class ImageSliderFullScreen extends StatefulWidget {
  final String tagName;
  final ImageProvider imageProvider;
  const ImageSliderFullScreen({super.key,
    required this.tagName,
    required this.imageProvider});

  @override
  State<ImageSliderFullScreen> createState() => _ImageSliderFullScreenState();
}

class _ImageSliderFullScreenState extends State<ImageSliderFullScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12.withOpacity(.3),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.black12.withOpacity(.3),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: widget.tagName,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                image: DecorationImage(image: widget.imageProvider,fit: BoxFit.scaleDown)
            ),
          ),
        ),
      ),
    );
  }


}
