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
    double indicatorSize = screenWidth < 600 ? 5 : 8; // Dots size

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            CarouselSlider.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  color: Colors.black, // Black background
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover, 
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: LoadingAnimation()); // Use Custom Animation
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: IconButton(
                          icon: Icon(Icons.refresh, size: 40, color: Colors.white),
                          onPressed: () => setState(() {}),
                        ),
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
            if (widget.images.length > 1)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
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
        );
      },
    );
  }
}
