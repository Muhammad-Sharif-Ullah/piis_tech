// ignore_for_file: unnecessary_this

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnNetWorkImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxShape? shape;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? progressIndicatorBuilder;
  final Color? backgroundColor;
  final BlendMode? colorBlendMode;

  const OnNetWorkImage({
    super.key,
    required this.url,
    this.progressIndicatorBuilder,
    this.height,
    this.width,
    this.shape,
    this.backgroundColor,
    this.errorWidget,
    this.fit,
    this.colorBlendMode,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      color: backgroundColor,
      width: width,
      placeholderFadeInDuration: const Duration(microseconds: 50),
      maxHeightDiskCache: height?.toInt(),
      maxWidthDiskCache: width?.toInt(),
      memCacheHeight: height?.toInt(),
      memCacheWidth: width?.toInt(),
      colorBlendMode: colorBlendMode,
      progressIndicatorBuilder: (context, url, progress) {
        // return SizedBox(
        //   width: 40.r,
        //   height: 40.r,
        //   child: FittedBox(
        //     child: CircularProgressIndicator(
        //       value: progress.totalSize != progress.downloaded
        //           ? progress.progress
        //           : null,
        //       strokeWidth: 1,
        //     ),
        //   ),
        // );
        return progressIndicatorBuilder ??
            Container(
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              // color: Colors.grey.withOpacity(0.1),
              child: const CupertinoActivityIndicator(),
              // child: Image.asset(
              //   R.ASSETS_IMAGES_MM_JPG,
              //   height: 182.h * .25,
              //   width: 182.h * .25,
              //   cacheHeight: 100,
              //   cacheWidth: 100,
              // ),
            );
      },
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        );
      },
      // placeholder: (context, url) => Container(
      //   alignment: Alignment.center,
      //   color: Colors.grey.shade200,
      //   // color: Colors.grey.withOpacity(0.1),

      //   child: Opacity(
      //     opacity: 0.2,
      //     child: Image.asset(
      //       R.ASSETS_IMAGES_MM_JPG,
      //       height: 182.h * .25,
      //       width: 182.h * .25,
      //     ),
      //   ),
      // ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: errorWidget ??
            Container(
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              // color: Colors.grey.withOpacity(0.1),
              child: const CupertinoActivityIndicator(),
              // child: Image.asset(
              //   R.ASSETS_IMAGES_MM_JPG,
              //   height: 182.h * .25,
              //   width: 182.h * .25,
              //   cacheHeight: 100,
              //   cacheWidth: 100,
              // ),
            ),

        /*
            Container(
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              // color: Colors.grey.withOpacity(0.1),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  // FittedBox(
                  //   child: Text(
                  //     'Unable to load the Image.',
                  //     style: Theme.of(context).textTheme.caption?.copyWith(
                  //           color: const Color(0xFF1B1B28),
                  //         ),
                  //   ),
                  // ),
                  // FittedBox(
                  //   child: Text(
                  //     'Unable to load the Image.',
                  //     style: Theme.of(context).textTheme.caption?.copyWith(
                  //           color: const Color(0xFF1B1B28),
                  //         ),
                  //   ),
                  // ),
                  // 4.verticalSpace,
                  // Text(
                  //   'This can happen if you are not connected to the Internet, \nor if anunderlying system or component is not available.',
                  //   style: Theme.of(context).textTheme.caption?.copyWith(
                  //         color: const Color(0xFF1B1B28),
                  //         fontSize: 8.sp,
                  //       ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
     */
      ),
    );
  }
}
