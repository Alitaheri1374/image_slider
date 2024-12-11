import 'package:flutter/material.dart';

class ImageFullScreen extends StatefulWidget {
  final String tagName;
  final ImageProvider imageProvider;
  final Function()disposeWidget;
  const ImageFullScreen({super.key,
    required this.tagName,
    required this.imageProvider,
    required this.disposeWidget,
  });

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        close();
      },

      child: Scaffold(
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
            close();
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
      ),
    );
  }


  void close(){
    widget.disposeWidget();
  }
}
