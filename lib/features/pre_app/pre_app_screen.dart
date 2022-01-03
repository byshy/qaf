import 'package:qaf/utils_and_services/decoration/colors.dart';
import 'package:qaf/utils_and_services/decoration/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreAppScreen extends StatelessWidget {
  const PreAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        child: Image.asset(
          logo,
          height: 120,
        ),
        decoration: const BoxDecoration(
          // color: Colors.blue,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blue13479C,
              blue072B66,
            ],
          ),
          image: DecorationImage(
            image: AssetImage(appBG),
            alignment: Alignment.bottomRight
          ),
        ),
      ),
    );
  }
}
