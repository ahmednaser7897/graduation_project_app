import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:graduation_project/app/extensions.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app/app_colors.dart';
import '../../app/app_sized_box.dart';
import '../../app/text_style.dart';

class ShowPhotosScreen extends StatefulWidget {
  const ShowPhotosScreen({
    Key? key,
    required this.photos,
  }) : super(key: key);
  final List<File> photos;

  @override
  State<ShowPhotosScreen> createState() => _ShowPhotosScreenState();
}

class _ShowPhotosScreenState extends State<ShowPhotosScreen> {
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  int smoothPageIndicatorIndix = 0;
  @override
  Widget build(BuildContext context) {
    return buildScreenContent(context);
  }

  Widget buildScreenContent(context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: screenBody(),
      ),
    );
  }

  Widget screenBody() {
    if (widget.photos.length == 1) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h, child: imageViewer(widget.photos[0])),
          ],
        ),
      );
    } else if (widget.photos.isEmpty) {
      return emptyWidget();
    } else {
      return imagesViewer(widget.photos);
    }
  }

  Widget emptyWidget() {
    return Text(
      "لا يوجد صوره للعرض",
      style: AppTextStyle.getBoldStyle(
          color: AppColors.errorColor, fontSize: 15.sp),
    );
  }

  Widget imageViewer(File photo) {
    return InteractiveViewer(
      clipBehavior: Clip.none,
      panEnabled: false,
      minScale: 1,
      maxScale: 4,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRect(
          child: Image(
            image: FileImage(photo),
            fit: BoxFit.contain,
            // key: _pdfViewerKey,
          ),
        ),
      ),
    );
  }

  Widget imagesViewer(List<File> images) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: images.map((e) {
            return imageViewer(e);
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                smoothPageIndicatorIndix = index;
              });
            },
            initialPage: 0,
            enableInfiniteScroll: false,
            height: 80.h,
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
          ),
        ),
        AppSizedBox.h2,
        smoothPageIndicator(),
      ],
    );
  }

  Widget smoothPageIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: smoothPageIndicatorIndix,
      count: widget.photos.length,
      effect: SwapEffect(
        dotColor: AppColors.fillColor,
        activeDotColor: AppColors.primaryColor,
        dotWidth: 20.sp,
        dotHeight: 4.sp,
        spacing: 5,
      ),
    );
  }
}
