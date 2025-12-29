// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class AppButtons extends StatefulWidget {
//   final String text;
//   final VoidCallback ontap;
//   final Color color;
//   final Color textColor;
//   final double borderRadius;
//   final double? width;
//   final double? height;
//   final IconData? icon;
//
//
//   const AppButtons({
//
//     required this.text,
//     required this.ontap,
//     required this.color,
//     required this.textColor,
//     required this.borderRadius,
//     this.width,
//     this.height,
//     this.icon})
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width ?? double.infinity,
//       height: height,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           foregroundColor: textColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           elevation: 5,
//         ),
//         onPressed: (){},
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, size: 20),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               text,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
//
//

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 12,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SizedBox(
      width: width * 0.9, // 90% screen width
      height: height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
