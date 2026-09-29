import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'app_card.dart';
import 'full_screen_image_viewer.dart';

/// ============================================================
/// بطاقة صورة الروشتة + فتحها Full Screen عند الضغط
/// ============================================================
class PrescriptionImageCard extends StatelessWidget {
  final String? imageUrl;

  const PrescriptionImageCard({super.key, required this.imageUrl});

  bool get _hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: () => _openFullScreen(context),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: !_hasImage
                ? _buildPlaceholder()
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      ),
                      _buildZoomHint(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_pharmacy_outlined, size: 44, color: AppColors.primary.withOpacity(0.6)),
          const SizedBox(height: 10),
          Text(
            'لا توجد صورة للروشتة',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primaryDark.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomHint() {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.zoom_in, size: 14, color: Colors.white),
            SizedBox(width: 4),
            Text('اضغط للتكبير', style: TextStyle(fontSize: 11, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    if (!_hasImage) return; // لا يوجد شيء نكبّره
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => FullScreenImageViewer(imageUrl: imageUrl!),
      ),
    );
  }
}
