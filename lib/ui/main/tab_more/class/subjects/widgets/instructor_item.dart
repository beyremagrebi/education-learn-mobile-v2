import 'package:flutter/material.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

class InstructorItem extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const InstructorItem({
    super.key,
    required this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.s),
      child: Row(
        children: [
          ApiImageWidget(
            imageFilename: imageUrl,
            width: 32,
            height: 32,
            hasImageViewer: true,
            isMen: true,
          ),
          Dimensions.widthMedium,
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
