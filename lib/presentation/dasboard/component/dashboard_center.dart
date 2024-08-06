import 'package:flutter/material.dart';

class DashboardCenter extends StatelessWidget {
  const DashboardCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
      child: Row(
        children: [
          const Icon(Icons.date_range_rounded),
          const SizedBox(
            width: 10,
          ),
          const Text("19 juli 2024 (hari ini)"),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 206, 206, 206), Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: const Text(
              "Ganti Tanggal",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
