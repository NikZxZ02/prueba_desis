import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPress;
  final String label;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final bool isDisabled;
  final int? textSize;
  final Alignment alignment;
  final bool isLoading;

  const CustomButton(
      {super.key,
      required this.onPress,
      required this.label,
      this.height = 42,
      required this.width,
      this.color = Colors.blue,
      this.textColor = Colors.white,
      this.icon,
      this.isDisabled = false,
      this.textSize = 14,
      this.alignment = Alignment.centerLeft,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(
                !isDisabled ? color : Colors.grey.withOpacity(0.8)),
            fixedSize: MaterialStatePropertyAll(Size(width, height))),
        onPressed: () => isDisabled || isLoading ? null : onPress(),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style:
                    TextStyle(color: textColor, fontSize: textSize!.toDouble()),
              ),
      );
    }

    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              !isDisabled ? color : Colors.grey),
          fixedSize: MaterialStatePropertyAll(
            Size(width, height),
          ),
          alignment: alignment),
      onPressed: () => isDisabled ? null : onPress(),
      icon: Icon(
        icon,
        color: textColor,
        size: 20,
      ),
      label: Text(
        label,
        style: TextStyle(color: textColor, fontSize: textSize!.toDouble()),
      ),
    );
  }
}
