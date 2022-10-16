// import 'package:austro_digital/core/settings/paths_img.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import 'colors.dart';
//
// class InputThemes {
//   static InputDecoration loginInputs(String nombre) => InputDecoration(
//       counterText: '',
//       contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
//       filled: true,
//       fillColor: AustroDigitalColors.grey3,
//       hintText: nombre.toUpperCase(),
//       hintStyle: const TextStyle(
//         color: AustroDigitalColors.newPLaceholder,
//         fontFamily: 'Texta',
//         fontWeight: FontWeight.w600,
//         fontSize: 18,
//       ),
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       suffixIconColor: AustroDigitalColors.newPLaceholder,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//       errorStyle: const TextStyle(color: AustroDigitalColors.red),
//       errorBorder: const OutlineInputBorder(
//           borderSide: BorderSide(width: 1, color: AustroDigitalColors.red)));
//
//   static InputDecoration searchInputs(String? nombre) => InputDecoration(
//     prefixIcon: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Image.asset(
//         imgLupa.path,
//         width: 20,
//         height: 20,
//         fit: BoxFit.fill,
//       ),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//     hintText: nombre?.toUpperCase(),
//     hintStyle: TextStyle(
//       color: AustroDigitalColors.newPLaceholder,
//       fontSize: 10.75.sp,
//     ),
//     border: const OutlineInputBorder(borderSide: BorderSide.none),
//     contentPadding: const EdgeInsets.only(left: 20, right: 8),
//   );
//
//   static InputDecoration secondInputDecoration = InputDecoration(
//     fillColor: Colors.transparent,
//     counterText: '',
//     focusedBorder: const OutlineInputBorder(
//       borderSide: BorderSide(color: AustroDigitalColors.blue1, width: 1.5),
//     ),
//     enabledBorder: const OutlineInputBorder(
//       borderSide: BorderSide(color: AustroDigitalColors.blue1, width: 1.5),
//     ),
//     errorBorder: const OutlineInputBorder(
//       borderSide: BorderSide(color: AustroDigitalColors.red, width: 1.5),
//     ),
//     focusedErrorBorder: const OutlineInputBorder(
//       borderSide: BorderSide(color: AustroDigitalColors.red, width: 1.5),
//     ),
//     contentPadding: EdgeInsets.all(4.w),
//   );
//
//   static InputDecoration dropDownsStyle(String placeholderText,
//       {bool showIcon = true,
//         bool haveError = false,
//         double? iconRightPadding,
//         double? placeholderSize,
//         Color? customFillColor}) =>
//       InputDecoration(
//         fillColor: customFillColor,
//         labelText: placeholderText.toUpperCase(),
//         labelStyle: placeholderSize != null
//             ? TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: placeholderSize,
//             color: AustroDigitalColors.newPLaceholder)
//             : null,
//         suffixIcon: showIcon
//             ? Image.asset(
//           imgCombo.path,
//           scale: 8,
//         )
//             : null,
//         border: haveError
//             ? const OutlineInputBorder(
//             borderSide: BorderSide(color: AustroDigitalColors.red))
//             : null,
//         focusedBorder: haveError
//             ? const OutlineInputBorder(
//             borderSide: BorderSide(color: AustroDigitalColors.red))
//             : null,
//         enabledBorder: haveError
//             ? const OutlineInputBorder(
//             borderSide: BorderSide(color: AustroDigitalColors.red))
//             : null,
//       );
// }
