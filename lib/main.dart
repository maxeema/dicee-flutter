import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'extensions.dart';

void main() => runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.green.shade700
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Dicee'),),
        body: SizedBox.expand(child: DiceePage()),
      ),
    ),
  );

class DiceePage extends StatelessWidget {

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
                flex: 4,
                child: delayOne ? SvgPicture.asset("images/dice$one.svg", color: Colors.transparent)
                    : SvgPicture.asset("images/dice$one.svg", color: Colors.white)
              ),
              Spacer(),
              Expanded(
                flex: 4,
                child: delayTwo ? SvgPicture.asset("images/dice$two.svg", color: Colors.transparent)
                    : SvgPicture.asset("images/dice$two.svg", color: Colors.white)
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
    invalidate();
    Future.delayed(Duration(milliseconds: 200), () {
      delayOne = false;
      one = randomize();
      invalidate();
    }).then((_) => Future.delayed(Duration(milliseconds: 50), () {
      delayTwo = false;
      two = randomize();
      invalidate();
    }));
  }

  static final random = Random.secure();
  static randomize() => 1 + random.nextInt(6);

}
