import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.buttontitle = "View all",
    this.textColor,
    this.showButton = true,
    this.func,
  });

  final String title, buttontitle;
  final Color? textColor;
  final bool showButton;
  final void Function()? func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showButton)
          TextButton(
            onPressed: func,
            child: Text(
              buttontitle,
              style: Theme.of(context).textTheme.bodySmall!.apply(color: textColor),
            ),
          ),
      ],
    );
  }
}
