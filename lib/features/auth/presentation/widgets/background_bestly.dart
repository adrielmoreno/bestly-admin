import 'package:flutter/material.dart';

import '../../../../core/presentation/common/theme/constants/app_dimens.dart';

class BackgroundBestly extends StatelessWidget {
  const BackgroundBestly({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: AppDimens.imgBackgroundWidth),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.big),
            child: Image(
              image: AssetImage('assets/images/bestly.png'),
              width: AppDimens.imgBackgroundWidth,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bestly_bg.png'),
            fit: BoxFit.cover));
  }
}
