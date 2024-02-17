import "package:flutter/material.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.asset(
          "",
          width: MediaQuery.of(context).size.width,
          height: 40,
          fit: BoxFit.cover,
        )
      ]),
    );
  }
}
