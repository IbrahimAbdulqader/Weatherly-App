import 'package:flutter/material.dart';
import '../general_widgets/custom_text_widget.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    this.iconButton,
    required this.title,
    required this.info,
  });
  final String title;
  final String info;
  final Widget? iconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              iconButton ?? Container(),
              CustomTextWidget(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const Spacer(),
              CustomTextWidget(
                text: info,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const Divider(color: Colors.white12, height: 2),
        ],
      ),
    );
  }
}
