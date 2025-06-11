  import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/MFGooglePayButton.dart';

Widget googlePayButton({required MFGooglePayButton  mfGooglePayButton}) {
    return SizedBox(
      height: 70,
      child: mfGooglePayButton,
    );
  }

  Widget applePayView({required MFApplePayButton mfApplePayButton}) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: mfApplePayButton,
        ),
      ],
    );
  }

