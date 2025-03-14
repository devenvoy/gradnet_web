import 'package:flutter/material.dart';
import '../theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final Function() onPressed;
  final bool showLoader; // Make final since it's not mutable in StatelessWidget

  CustomPrimaryButton({
    super.key,
    required this.buttonColor,
    required this.textValue,
    required this.textColor,
    required this.onPressed,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: showLoader ? null : onPressed, // Disable tap when loading
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min, // Aligns content properly
                children: [
                  if (showLoader) // Show loader if true
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  Text(
                    textValue,
                    style: heading5.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
