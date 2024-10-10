// import 'package:flutter/material.dart';
// import 'package:flutter_boilerplates/config/themes/app_theme.dart';
// import 'package:flutter_boilerplates/config/translations/strings.dart';
// import 'package:flutter_boilerplates/core/services/reachability_service.dart';
// import 'package:flutter_boilerplates/core/widgets/app_icon_widget.dart';
// import 'package:flutter_boilerplates/core/widgets/texts/app_text_widget.dart';
// import 'package:get/get.dart';

// class AppNoInternetWidget extends StatelessWidget {
//   const AppNoInternetWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.find<ReachabilityService>()
//             .showWarningForOfflineMode(forceShow: true);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: context.theme.appColor.waringColor[10],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AppIconWidget(
//               Icons.wifi_off,
//               bgSize: 14,
//               iconSize: 14,
//               bgColor: Colors.transparent,
//               iconColor: AppColors.get().errorColor,
//             ),
//             const SizedBox(width: 5),
//             AppTextWidget(
//               Strings.noInternetConnection,
//               textStyle: context.textTheme.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.get().errorColor,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AppInternetConnectionWidget extends StatelessWidget {
//   const AppInternetConnectionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.find<ReachabilityService>()
//             .showWarningForRetryConnection(forceShow: true);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: context.theme.appColor.waringColor[10],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AppIconWidget(
//               Icons.wifi,
//               bgSize: 14,
//               iconSize: 14,
//               bgColor: Colors.transparent,
//               iconColor: AppColors.get().successColor,
//             ),
//             const SizedBox(width: 5),
//             AppTextWidget(
//               Strings.hasInternetConnection,
//               textStyle: context.textTheme.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.get().successColor,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class OfflineWidgets {
// //   static Widget isOfflineWidget(BuildContext context) {
// //     return WidgetUtils.appTooltip(context,
// //         child: AppIconWidget(
// //           AppCustomIcons.wifi_off_1,
// //           iconSize: AppUIConstants.tinyIconSize,
// //           iconColor: context.theme.appColor.neutralColor[80],
// //         ),
// //         message: Strings.offlineModeTooltip.tr);
// //   }

// //   static Widget isOfflineConflictDataWidget(BuildContext context,
// //       {String? message}) {
// //     return WidgetUtils.appTooltip(context,
// //         child: AppIconWidget(
// //           AppCustomIcons.info,
// //           iconSize: AppUIConstants.tinyIconSize,
// //           iconColor: context.theme.appColor.errorColor,
// //         ),
// //         message: message ?? Strings.offlineModeUpdatedTooltip.tr);
// //   }
// // }
