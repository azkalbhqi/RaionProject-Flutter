// ignore_for_file: unused_import, use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/styles.dart';

class Buttons extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double width;
  final Color backgroundColor;
  final Color fontColor;

  const Buttons({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.width,
    required this.backgroundColor,
    required this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          elevation: MaterialStateProperty.all<double>(0),
          minimumSize: MaterialStateProperty.all<Size>(Size(width, 52))
        ),
        onPressed: onClicked,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: fontColor,
            fontSize: 16,
            fontWeight:  FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
