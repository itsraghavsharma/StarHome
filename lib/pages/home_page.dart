
import 'package:flutter/material.dart';
import 'package:star_home/widgets/accessory_card.dart';
import 'package:star_home/widgets/titles.dart';

class HomePage extends StatelessWidget {
  static String route = 'homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
          children: const [
            Title1(text: "Your Appliances"),
            AccessoryCard(text1: "text1"),

      ]
      ),

    );

  }
}
