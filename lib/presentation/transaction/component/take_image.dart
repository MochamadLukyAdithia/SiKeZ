import 'package:flutter/material.dart';

class TakeImageButton extends StatelessWidget {
  const TakeImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Bukti"),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                colors: [Colors.white, Color.fromARGB(255, 212, 212, 212)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: const Center(child: Text("Ambil Gambar")),
        ),
      ],
    );
  }
}
