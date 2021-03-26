import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';

class StepperOne extends StatelessWidget {
  // group3 svg is without text
  // group 4 svg is with text
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        'assets/images/Step1.svg',
        height: 60,
        width: SizeConfig.screenWidth * 0.8,
      ),
    );
  }
}

class StepperTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        'assets/images/Step2.svg',
        height: 60,
        width: SizeConfig.screenWidth * 0.8,
      ),
    );
  }
}
