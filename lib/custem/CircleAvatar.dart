import 'package:elhwar/const/const.dart';
import 'package:flutter/material.dart';

class Circleavatarl extends StatefulWidget {
  final String name;
  const Circleavatarl({super.key, required this.name});

  @override
  State<Circleavatarl> createState() => _CircleavatarState();
}

class _CircleavatarState extends State<Circleavatarl> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // كل الدواير هتبقى في نفس المكان
      children: [
        const CircleAvatar(backgroundColor: AppColors.brown, radius: 50),
        CircleAvatar(
          backgroundColor: AppColors.gray,
          radius: 30,
          child: Text(
            widget.name, // الحرف اللي هيتعرض
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
