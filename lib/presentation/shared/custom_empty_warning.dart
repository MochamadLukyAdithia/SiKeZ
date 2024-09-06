import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/resources/assets.gen.dart';

class EmptyWarning extends StatelessWidget {
  const EmptyWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Assets.icons.transactionMinusSvgrepoCom.svg(
            width: Get.width * 0.3,
          ),
          const SizedBox(height: 8),
          Text(
            "Tidak ada transaksi.",
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text(
            "Silahkan tambahkan transaksi baru atau pilih tanggal lain.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
