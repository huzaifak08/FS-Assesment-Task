import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:path/path.dart' as path;

class ImageDisplayWidget extends StatelessWidget {
  final String mediaId;
  final String imageUrl;
  final String imageFor;
  final double? height;
  final bool showProgress;
  final String? blurHash;
  final double? width;
  final String? errorPlaceholder;
  final Widget? errorWidget;
  final BoxFit fit;

  const ImageDisplayWidget({
    super.key,
    required this.mediaId,
    required this.imageUrl,
    required this.imageFor,
    this.height,
    this.width,
    this.errorPlaceholder,
    this.errorWidget,
    this.blurHash,
    required this.showProgress,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return errorWidget ??
          PlaceholderWidget(
            errorPlaceholder: errorPlaceholder,
            height: height,
            width: width,
            errorWidget: errorWidget,
            blurHash: blurHash,
            imageFor: imageFor,
          );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: path.basename(Uri.parse(imageUrl).path),
      width: width,
      height: height,
      fit: fit,
      placeholder: showProgress
          ? null
          : (context, url) => PlaceholderWidget(
              errorPlaceholder: errorPlaceholder,
              height: height,
              width: width,
              errorWidget: errorWidget,
              blurHash: blurHash,
              imageFor: imageFor,
            ),
      progressIndicatorBuilder: showProgress
          ? (context, url, progress) {
              if (progress.progress != null) {
                if (blurHash != null) {
                  return Stack(
                    children: [
                      PlaceholderWidget(
                        errorPlaceholder: errorPlaceholder,
                        height: height,
                        width: width,
                        blurHash: blurHash,
                        errorWidget: errorWidget,
                        imageFor: imageFor,
                      ),
                      const Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container(
                  color: AppColors.grayColor,
                  child: const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }
              return errorWidget ??
                  PlaceholderWidget(
                    errorPlaceholder: errorPlaceholder,
                    height: height,
                    width: width,
                    errorWidget: errorWidget,
                    blurHash: blurHash,
                    imageFor: imageFor,
                  );
            }
          : null,
      errorWidget: (context, url, error) {
        return errorWidget ??
            PlaceholderWidget(
              errorPlaceholder: errorPlaceholder,
              height: height,
              width: width,
              errorWidget: errorWidget,
              blurHash: blurHash,
              imageFor: imageFor,
            );
      },
      errorListener: (value) {
        // if (value is HttpExceptionWithStatus &&
        //     (value.statusCode == 403 || value.statusCode == 400)) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     MediaService().evictCacheAndResign(mediaId, imageFor, imageUrl);
        //   });
        // }
      },
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String? errorPlaceholder;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final String? blurHash;
  final String imageFor;

  const PlaceholderWidget({
    super.key,
    this.errorPlaceholder,
    this.errorWidget,
    this.height,
    this.width,
    this.blurHash,
    required this.imageFor,
  });

  @override
  Widget build(BuildContext context) {
    if (errorPlaceholder?.endsWith('.svg') == true) {
      return SvgPicture.asset(
        errorPlaceholder!,
        height: height,
        width: width,
        fit: BoxFit.fitWidth,
      );
    }

    if (errorWidget != null) return errorWidget!;

    if (errorPlaceholder != null) {
      return Image.asset(
        errorPlaceholder!,
        height: imageFor == 'message' ? 350 : height,
        width: width,
        fit: BoxFit.fitWidth,
      );
    }

    return SvgPicture.asset(
      './assets/images/user_placeholder_avatar.svg',
      height: imageFor == 'message' ? 350 : height,
      width: width,
      fit: BoxFit.fitWidth,
    );
  }
}
