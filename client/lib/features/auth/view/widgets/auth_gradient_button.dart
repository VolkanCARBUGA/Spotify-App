import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double? width;
  final double? height;
  const AuthGradientButton({super.key, this.onPressed, required this.text, required this.color, required this.textColor,  this.width,  this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        
        height: height ?? 50,
        width: width,
        decoration: BoxDecoration(
        color: color,
          gradient:  const LinearGradient(
            colors: [
             Pallete.gradient1,
             Pallete.gradient2,
            
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child:  Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}