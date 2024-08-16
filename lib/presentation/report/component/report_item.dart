import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportItem extends StatelessWidget {
  final String title;
  final String route;
  const ReportItem({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(46, 239, 239, 239)
            ], // Add your colors here
            stops: [0.4, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
            )
          ]),
      child: ListTile(
        onTap: () {
          Get.toNamed(route);
        },
        title: Text(title),
        trailing: const Icon(Icons.arrow_right_outlined),
      ),
    );
  }
}
