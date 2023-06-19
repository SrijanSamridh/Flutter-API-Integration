import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.text,
    this.onPressed,
    required this.color,
    this.icon,
  });

  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: size.width * 0.8,
            child: Row(
              children: [
                Text(
                  text?.toUpperCase() ?? 'Button'.toUpperCase(),
                  style: TextStyle(color: color),
                ),
                const Spacer(),
                Text("$text Data".toUpperCase()),
                SizedBox(width: size.width * 0.02),
                Icon(icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
