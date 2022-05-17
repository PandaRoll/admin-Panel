import 'package:admin/screens/config/size_config.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

snackBarWidget(context, String msg, IconData icons, Color iconcolor, int time) {
  final snackbar = SnackBar(
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.white,
    duration: Duration(seconds: time),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          msg,
          style: GoogleFonts.montserrat(
              fontSize: 2.4 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.normal,
              color: Colors.blue),
        ),
        Icon(
          icons,
          color: iconcolor,
        )
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
