import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppImageNetworkWidget extends StatelessWidget {
  const AppImageNetworkWidget({
    super.key,
    required this.url,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
    this.fit,
    this.placeHolder,
    this.isImageFromAPI,
  });

  final String url;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;
  final BoxFit? fit;
  final Widget? placeHolder;
  final bool? isImageFromAPI;

  @override
  Widget build(BuildContext context) {
    // final urlFinal =
    //     '${isImageFromAPI == true ? Get.find<EnvironmentService>().apiDomain() : ''}$url';
    // final headers =
    //     isImageFromAPI == true ? Get.find<NdAppService>().authorization : null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius ?? AppUIConstants.boxBorderRadius,
      ),
      child: url.isNotEmpty
          ? Image.network(
              // urlFinal,
              // headers: headers,
              url,

              errorBuilder: (ctx, error, stackTrace) =>
                  placeHolder ?? _placeHolder(),
              loadingBuilder: (ctx, child, loading) =>
                  loading == null ? child : _loadingHolder(ctx),
              height: imageHeight,
              width: imageWidth,
              cacheWidth: imageWidth?.round(),
              cacheHeight: imageHeight?.round(),
              fit: fit ?? BoxFit.cover,
            )
          : placeHolder ?? _placeHolder(),
    );
  }

  Widget _placeHolder() {
    return Image.asset(
      AppImageAsset.imagePlaceHolder,
      height: imageHeight,
      width: imageWidth,
      fit: BoxFit.fill,
    );
  }

  Widget _loadingHolder(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImageAsset.imagePlaceHolder,
          height: imageHeight,
          width: imageWidth,
          fit: BoxFit.fill,
        ),
        Positioned.fill(child: _overlayLoading(context))
      ],
    );
  }

  Widget _overlayLoading(BuildContext context) {
    return Container(
      color: AppColors.get().neutralColor[0]?.withOpacity(0.4),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.get().primaryColor,
          ),
        ),
      ),
    );
  }
}
