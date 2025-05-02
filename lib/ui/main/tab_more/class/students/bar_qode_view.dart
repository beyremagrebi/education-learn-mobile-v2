import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarCodeView extends StatelessWidget {
  const BarCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBarcodeCard(
      context: context,
      description: 'test',
      title: 'hello',
      child: BarcodeWidget(
        barcode: Barcode.ean8(),
        data: "14509251",
        width: 300,
        height: 100,
        drawText: true,
      ),
    );
  }

  Widget _buildBarcodeCard({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Center(child: child),
        ],
      ),
    );
  }
}
