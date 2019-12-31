import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'extensions.dart';

class DiceePage extends StatelessWidget {

  final Color diceeColor;
  DiceePage(this.diceeColor);

  int one = randomize(),
      two = randomize();

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
                    flex: 1,
                    child: delayOne ? SvgPicture.asset("images/dice$one.svg", color: Colors.transparent)
                        : SvgPicture.asset("images/dice$one.svg", color: diceeColor)
                ),
                Spacer(),
                Expanded(
                    flex: 1,
                    child: delayTwo ? SvgPicture.asset("images/dice$two.svg", color: Colors.transparent)
                        : SvgPicture.asset("images/dice$two.svg", color: diceeColor)
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
    one = randomize();
    two = randomize();
    invalidate();
    Future.delayed(Duration(milliseconds: 200), () {
      delayOne = false;
      invalidate();
    }).then((_) => Future.delayed(Duration(milliseconds: 50), () {
      delayTwo = false;
      invalidate();
    }));
  }

  static final random = Random.secure();
  static randomize() => 1 + random.nextInt(6);

}