import 'package:flutter/material.dart';

import 'app_colors.dart';

class InkWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double radius;

  const InkWrapper({
    super.key,
    required this.child,
    required this.onTap,
    required this.radius,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: AppColors.transparent,
            child: Ink(
              child: InkWell(
                  hoverColor: AppColors.shapeColor,
                  splashColor: AppColors.shapeColor,
                  onTap: onTap,
                  onLongPress: onLongPress,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius))),
            ),
          ),
        ),
      ],
    );
  }
}
