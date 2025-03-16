import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gradnet_web/widgets/loading_animation.dart';

class PostImages extends StatefulWidget {
  final List<String> images;
  final VoidCallback onLikeClicked;

  const PostImages({
    required this.images,
    required this.onLikeClicked,
    super.key,
  });

  @override
  _PostImagesState createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double carouselWidth = screenWidth > 800 ? screenWidth * 0.6 : screenWidth * 0.9;
    double carouselHeight = screenWidth > 800 ? screenHeight * 0.5 : screenHeight * 0.35;
    double indicatorSize = screenWidth < 600 ? 6 : 8;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: carouselWidth,
            height: carouselHeight,
            child: CarouselSlider.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: LoadingAnimation());
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: IconButton(
                        icon: Icon(Icons.refresh, size: 40, color: Colors.white),
                        onPressed: () => setState(() {}),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          if (widget.images.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? indicatorSize + 2 : indicatorSize,
                    height: indicatorSize,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Theme.of(context).primaryColor
                          : Color(0xFFD9D9D9),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}