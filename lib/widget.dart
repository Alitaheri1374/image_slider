import 'package:flutter/material.dart';
import 'full_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';



///اسلایدر image
class ImageSliderWidget extends StatefulWidget {
  ///لیست آدرس عکس ها
  final List<String> imagesList;
  /// ویجت برای loading گرفتن عکس ها
  final Widget Function(BuildContext,String url)? placeholder;
  /// ویجت برای وقتی که عکس ها به مشکل بخورند
  final Widget Function(BuildContext,String url,Object error)? errorWidget;
  const ImageSliderWidget({
    super.key,
    required this.imagesList,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {

  int _currentIndex = 0;
  final PageController _pageController = PageController();
  List<Color> colorBgList=[];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.imagesList.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(
              child: CachedNetworkImage(
                imageUrl: widget.imagesList[index],
                cacheKey: widget.imagesList[index],
                imageBuilder: (context, imageProvider) {
                  return InkWell(
                    onTap: () {
                      Route route=MaterialPageRoute(builder: (context) => ImageSliderFullScreen(
                        tagName: widget.imagesList[index],
                        imageProvider: imageProvider,
                      ),);
                      Navigator.push(context, route);
                    },
                    child: Hero(
                      tag: widget.imagesList[index],
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(image: imageProvider,fit: BoxFit.scaleDown)
                        ),
                      ),
                    ),
                  );
                },
                // fit: BoxFit.cover,
                placeholder: (context, url) =>
                    widget.placeholder?.call(context,url)??
                    Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // errorWidget: (context, url, error) => Icon(Icons.error),
                errorWidget: (context, url, error) =>
                    widget.errorWidget?.call(context,url,error)??
                    Icon(Icons.error,color: Theme.of(context).colorScheme.error,),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,left: 0,right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imagesList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _pageController.animateToPage(entry.key,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key?
                            Theme.of(context).primaryColor:
                            (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                                .withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        )

      ],
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
