import 'package:flutter/material.dart';

import '../../../../core/localization/loalisation.dart';
import '../../../../models/training_center/class/class.dart';

class AnimatedClassSelector extends StatefulWidget {
  final Class? currentClassName;
  final List<Class> availableClasses;
  final Function(Class) onClassChanged;
  final Color? textColor;
  final Color? accentColor;
  final bool showSubtitle;
  final String subtitle;

  const AnimatedClassSelector({
    super.key,
    required this.currentClassName,
    required this.availableClasses,
    required this.onClassChanged,
    this.textColor = Colors.white,
    this.accentColor,
    this.showSubtitle = true,
    required this.subtitle,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedClassSelectorState();
}

class _AnimatedClassSelectorState extends State<AnimatedClassSelector> {
  void _showClassSelectionModal() {
    final Color accentColor =
        widget.accentColor ?? Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    'Select Class',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.availableClasses.length,
                itemBuilder: (context, index) {
                  final Class classe = widget.availableClasses[index];
                  final isSelected =
                      classe.name == widget.currentClassName?.name;

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: isSelected ? accentColor.withOpacity(0.1) : null,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? accentColor
                            : Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          classe.name!.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      classe.name ?? intl.undefined,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: accentColor,
                          )
                        : null,
                    onTap: () {
                      widget.onClassChanged(classe);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showClassSelectionModal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showSubtitle)
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.textColor?.withOpacity(0.7) ?? Colors.white70,
                  ),
                ),
              Row(
                children: [
                  Text(
                    widget.currentClassName?.name ?? intl.undefined,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor ?? Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    color: widget.textColor ?? Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
