
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? suffixIconData;

  const StyledTextField({super.key,
    required this.label,
    required this.hintText,
     this.suffixIconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.blue, // Change to your desired color
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black, // Change to your desired color
                  letterSpacing: -0.4,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.grey, // Change to your desired color
                    letterSpacing: -0.4,
                  ),
                  suffixIcon: Icon(
                    suffixIconData,
                    size: 24,
                    color: Colors.black, // Change to your desired color
                  ),
                ),
              ),
            ),
          ],
        ),


      ],
    );
  }
}