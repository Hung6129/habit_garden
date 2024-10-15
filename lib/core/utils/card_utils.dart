import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/translations/strings.dart';
import 'package:habit_garden/share/widgets/app_icon_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_richtext_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class CardUtils {
  CardUtils._();

  static Widget buildDelete(BuildContext context, Function? onPressed) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: (context) => onPressed?.call(),
      backgroundColor: AppColors.get().errorColor[10]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconWidget(
            Icons.delete,
            iconSize: AppUIConstants.svgSize,
            iconColor: Theme.of(context).colorScheme.error,
            bgColor: AppColors.get().errorColor[10]!,
          ),
          SizedBox(height: AppUIConstants.majorScalePadding(2)),
          AppTextWidget(
            Strings.delete,
            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          )
        ],
      ),
    );
  }

  static Widget buildEdit(BuildContext context, Function? onPressed,
      {String? text}) {
    return CustomSlidableAction(
      onPressed: (context) => onPressed?.call(),
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.get().infoColor[5]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconWidget(
            Icons.edit,
            iconSize: AppUIConstants.svgSize,
            iconColor: AppColors.get().infoColor,
            bgColor: AppColors.get().infoColor[5]!,
          ),
          SizedBox(height: AppUIConstants.majorScalePadding(2)),
          AppTextWidget(
            text ?? Strings.edit,
            textAlign: TextAlign.center,
            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.get().infoColor,
                ),
          )
        ],
      ),
    );
  }

  static Widget cardSubHeaderRow(
    BuildContext context, {
    required Widget icon,
    required String content,
  }) {
    return Row(
      children: [
        icon,
        SizedBox(width: AppUIConstants.majorScalePadding(1)),
        AppTextWidget(
          content,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).appColor.neutralColor[80],
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  static Widget cardRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String content}) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppUIConstants.miniIconSize,
          color: Theme.of(context).iconTheme.color,
        ),
        SizedBox(width: AppUIConstants.majorScalePadding(1)),
        Flexible(
          child: AppRichTextWidget(
            textSpans: [
              TextSpan(
                text: label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).appColor.neutralColor[80],
                    ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: content,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // static Widget cardImage(
  //   BuildContext context, {
  //   Function? onTap,
  //   required String imgUrl,
  //   required String title,
  //   required double imageWidth,
  //   required double imageHeight,
  //   bool previewable = false,
  //   int titleMaxLine = 2,
  //   Widget? subHeader,
  //   List<Widget>? rowItems,
  //   CrossAxisAlignment? contentAlignment,
  //   bool? isImageFromAPI,
  // }) {
  //   return InkWell(
  //     onTap: () => onTap?.call(),
  //     child: Container(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: AppUIConstants.majorScalePadding(4),
  //       ),
  //       color: context.theme.appColor.neutralColor[0],
  //       child: Column(
  //         children: [
  //           SizedBox(height: AppUIConstants.majorScalePadding(4)),
  //           cardImageHeader(
  //             context,
  //             imgUrl: imgUrl,
  //             title: title,
  //             imageWidth: imageWidth,
  //             imageHeight: imageHeight,
  //             previewable: previewable,
  //             titleMaxLine: titleMaxLine,
  //             subHeader: subHeader,
  //             contentAlignment: contentAlignment,
  //             isImageFromAPI: isImageFromAPI,
  //           ),
  //           SizedBox(height: AppUIConstants.majorScalePadding(4)),
  //           ...?rowItems,
  //           rowItems != null
  //               ? SizedBox(height: AppUIConstants.majorScalePadding(2))
  //               : Container(),
  //           const Divider(thickness: 1, height: 1),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // static Widget cardImageHeader(
  //   BuildContext context, {
  //   required String imgUrl,
  //   required String title,
  //   required double imageWidth,
  //   required double imageHeight,
  //   bool previewable = false,
  //   int titleMaxLine = 2,
  //   Widget? subHeader,
  //   CrossAxisAlignment? contentAlignment,
  //   bool? isImageFromAPI,
  // }) {
  //   return Row(
  //     crossAxisAlignment: contentAlignment ?? CrossAxisAlignment.start,
  //     children: [
  //       previewable
  //           ? WidgetUtils.singleNetworkImagePreviewable(
  //               context,
  //               imgUrl,
  //               imageWidth: imageWidth,
  //               imageHeight: imageHeight,
  //               isImageFromAPI: isImageFromAPI,
  //             )
  //           : AppImageNetworkWidget(
  //               url: imgUrl,
  //               imageWidth: imageWidth,
  //               imageHeight: imageHeight,
  //               isImageFromAPI: isImageFromAPI,
  //             ),
  //       SizedBox(width: AppUIConstants.majorScalePadding(3)),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             AppTextWidget(
  //               title,
  //               textStyle: context.textTheme.titleMedium,
  //               maxLines: titleMaxLine,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //             SizedBox(height: AppUIConstants.majorScalePadding(1)),
  //             subHeader ??
  //                 AppTextWidget(
  //                   Strings.viewDetail.tr,
  //                   textStyle: context.textTheme.titleSmall?.copyWith(
  //                     color: context.theme.colorScheme.primary,
  //                   ),
  //                 ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // static Widget cardMapPlace(
  //   BuildContext context, {
  //   required String placeName,
  //   required String distance,
  //   required String address,
  //   List<String>? phoneNumbers,
  //   Function? onTap,
  // }) {
  //   return InkWell(
  //     onTap: () => onTap?.call(),
  //     child: Container(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: AppUIConstants.majorScalePadding(4),
  //       ),
  //       color: context.theme.appColor.neutralColor[0],
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: AppUIConstants.majorScalePadding(4)),
  //           Stack(
  //             alignment: AlignmentDirectional.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   Icon(
  //                     AppCustomIcons.fmd_good,
  //                     size: AppUIConstants.miniIconSize,
  //                     color: context.theme.iconTheme.color,
  //                   ),
  //                   SizedBox(width: AppUIConstants.majorScalePadding(1)),
  //                   Flexible(
  //                     child: AppTextWidget(
  //                       placeName,
  //                       textStyle: context.textTheme.titleMedium,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                   SizedBox(width: AppUIConstants.majorScalePadding(5)),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   AppTextWidget(
  //                     distance,
  //                     textStyle: context.textTheme.bodyMedium?.copyWith(
  //                       color: AppColors.get().neutralColor[80],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: AppUIConstants.majorScalePadding(1.5)),
  //           AppTextWidget(
  //             address,
  //             textStyle: context.textTheme.bodyMedium?.copyWith(
  //               color: AppColors.get().neutralColor[80],
  //             ),
  //           ),
  //           if (phoneNumbers != null)
  //             AppTextWidget(
  //               phoneNumbers.join(", "),
  //               textStyle: context.textTheme.bodyMedium?.copyWith(
  //                 color: AppColors.get().neutralColor[80],
  //               ),
  //             ),
  //           SizedBox(height: AppUIConstants.majorScalePadding(4)),
  //           const Divider(thickness: 1, height: 1),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // static Widget buildSignContract(BuildContext context, Function? onPressed) {
  //   return CustomSlidableAction(
  //     padding: EdgeInsets.zero,
  //     onPressed: (context) => onPressed?.call(),
  //     backgroundColor: AppColors.get().successColor[5]!,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SvgPicture.asset(
  //           'assets/vectors/ic_sign_contract.svg',
  //           width: AppUIConstants.svgSize,
  //         ),
  //         SizedBox(height: AppUIConstants.majorScalePadding(2)),
  //         AppTextWidget(
  //           Strings.signContract.tr,
  //           textAlign: TextAlign.center,
  //           textStyle: context.textTheme.titleSmall?.copyWith(
  //             color: context.theme.appColor.successColor,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
