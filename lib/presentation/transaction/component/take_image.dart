import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class TakeImageButton extends StatelessWidget {
  const TakeImageButton({
    super.key,
    required this.onImageCaptured,
  });
  final Function(XFile? xFile) onImageCaptured;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Sumber Foto",
                      style: Get.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    final file = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (file != null) {
                      onImageCaptured(file);
                      Get.back();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.camera),
                        const SizedBox(width: 8),
                        Text("Kamera", style: Get.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      onImageCaptured(file);
                      Get.back();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.photo),
                        const SizedBox(width: 8),
                        Text("Galeri", style: Get.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
          gradient: AppColors.secondaryGradient,
        ),
        child: const Center(
          child: Text(
            "Ambil Gambar",
          ),
        ),
      ),
    );
  }
}
