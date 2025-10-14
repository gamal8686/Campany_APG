import 'package:elhwar/custem/CircleAvatar.dart';
import 'package:flutter/material.dart';

class LogoCampany extends StatelessWidget {
  const LogoCampany({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0.02),
      child: SizedBox(
        child: Stack(
          children: const [
            Positioned(left: 0, child: Circleavatarl(name: 'A')),
            Positioned(left: 80, child: Circleavatarl(name: 'P')),
            Positioned(left: 160, child: Circleavatarl(name: 'G')),
          ],
        ),
      ),
    );
  }
}
