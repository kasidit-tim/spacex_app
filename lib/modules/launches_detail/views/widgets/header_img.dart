import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spacex_app/core/widgets/custom_network_img.dart';
import 'package:spacex_app/model/launch/launch.dart';

class HeaderImage extends StatefulWidget {
  const HeaderImage({
    super.key,
    required this.data,
  });

  final LaunchModel data;

  @override
  State<HeaderImage> createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final links = widget.data.links;
    final images = links?.images;
    final logo = links?.logo;

    if (images != null && images.isNotEmpty) {
      return _buildCarouselImg(images);
    }

    if (logo != null && logo.isNotEmpty) {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CustomNetworkImg(
              url: logo,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      );
    }
    return const SizedBox(
      height: 250,
      width: double.infinity,
    );
  }

  Widget _buildCarouselImg(
    List<dynamic> img,
  ) {
    return Stack(
      children: [
        CarouselSlider(
            items: List.generate(
              img.length,
              (index) => SizedBox(
                width: double.infinity,
                child: CustomNetworkImg(
                  url: img[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            options: CarouselOptions(
              viewportFraction: 0.9,
              height: 280,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
        Positioned.fill(
          top: 205,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: img.length,
                effect: const ScrollingDotsEffect(
                  maxVisibleDots: 5,
                  activeDotColor: Colors.purple,
                  dotColor: Colors.grey,
                  dotWidth: 10,
                  dotHeight: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
