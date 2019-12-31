import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dicee.dart';

void main() => runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[850]
      ),
      home: Scaffold(
        body: SizedBox.expand(child: DiceePage(Colors.lightBlueAccent)),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );


