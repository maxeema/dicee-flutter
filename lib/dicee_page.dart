import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'dicee.dart';
import 'extensions.dart';

const _ROLL_DELAY = Duration(milliseconds: 200);

class DiceePage extends StatelessWidget {

  final dicee1 = Dicee()..roll(),
        dicee2 = Dicee()..roll();

  bool delayOne = false,
      delayTwo = false;

  var invalidate;

  @override
  Widget build(BuildContext context) =>
      InkWell(
        onTap: delayOne || delayTwo ? null : shake,
        child: StatefulBuilder(
            builder: (context, StateSetter setState)  {
              invalidate = () { setState((){}); };
              final children = [
                Spacer(),
                Expanded(
                    child: delayOne ? SvgPicture.asset("images/dice${dicee1.value}.svg", color: Colors.transparent)
                        : SvgPicture.asset("images/dice${dicee1.value}.svg", color: dicee1.color)
                ),
                Spacer(),
                Expanded(
                    child: delayTwo ? SvgPicture.asset("images/dice${dicee2.value}.svg", color: Colors.transparent)
                        : SvgPicture.asset("images/dice${dicee2.value}.svg", color: dicee2.color)
                ),
                Spacer(),
              ];
              return context.isLandscape ? Row(
                children: children,
              ) : Column(
                children: children,
              );
            }
        ),
      );

  shake() {
    delayOne = delayTwo = true;
    dicee1.roll(); dicee2.roll();
    invalidate();
    Future.delayed(_ROLL_DELAY, () {
      delayOne = false;
      invalidate();
    }).then((_) => Future.delayed(Duration(milliseconds: 50), () {
      delayTwo = false;
      invalidate();
    }));
  }

}