// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_boilerplates/config/themes/app_theme.dart';
// import 'package:flutter_boilerplates/core/services/reachability_service.dart';
// import 'package:get/get.dart';

// import 'app_no_internet_widget.dart';
// import 'buttons/app_icon_button_widget.dart';

// class AppBarWidgetChecker extends StatelessWidget
//     implements PreferredSizeWidget {
//   const AppBarWidgetChecker({
//     required this.text,
//     this.textWidget,
//     this.textStyle,
//     this.leading,
//     this.leadingWidget,
//     this.actions,
//     this.goBack,
//     this.goBackEnabled = true,
//     this.bottomWidget = const SizedBox(),
//     this.bottomHeight = 0,
//     this.backgroundColor,
//     this.enableWarningInternetConnect = true,
//     this.bottomRightRadius = 20,
//     super.key,
//   });

//   final String text;
//   final Widget? textWidget;
//   final TextStyle? textStyle;
//   final IconData? leading;
//   final List<Widget>? actions;
//   final bool goBackEnabled;
//   final Widget? leadingWidget;
//   final Function? goBack;
//   final Widget bottomWidget;
//   final double bottomHeight;
//   final Color? backgroundColor;
//   final bool enableWarningInternetConnect;
//   final int bottomRightRadius;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => AppBar(
//         leading: goBackEnabled
//             ? AppIconButtonWidget(
//                 icon: leading ?? Icons.arrow_back,
//                 iconColor: context.theme.colorScheme.onPrimary,
//                 onPressed:
//                     goBack != null ? () => goBack?.call() : () => Get.back(),
//               )
//             : (leadingWidget ?? Container()),
//         title: textWidget ??
//             AutoSizeText(
//               text,
//               maxLines: 1,
//               style: textStyle ??
//                   context.theme.textTheme.titleLarge
//                       ?.copyWith(color: context.theme.colorScheme.onPrimary),
//             ),
//         centerTitle: true,
//         actions: actions ?? [Container()],
//         automaticallyImplyLeading: false,
//         backgroundColor: context.theme.colorScheme.background,
//         flexibleSpace: Container(
//           color: backgroundColor ?? context.theme.appColor.neutralColor[10],
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 context.theme.primaryColorLight,
//                 context.theme.primaryColor,
//               ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(bottomRightRadius.toDouble()),
//               ),
//             ),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(bottomHeight +
//               16 +
//               (Get.find<ReachabilityService>().isOnlineNetwork().value == true
//                   ? 0
//                   : 42)),
//           child: Column(
//             children: [
//               bottomWidget,
//               Get.find<ReachabilityService>().isOnlineNetwork().value == true
//                   ? const AppInternetConnectionWidget()
//                   : const AppNoInternetWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => bottomHeight > 0
//       ? Size.fromHeight(kToolbarHeight +
//           bottomHeight +
//           16 +
//           (Get.find<ReachabilityService>().isOnlineNetwork().value == true
//               ? 0
//               : 42))
//       : Size.fromHeight(kToolbarHeight +
//           (Get.find<ReachabilityService>().isOnlineNetwork().value == true
//               ? 0
//               : 42));
// }
