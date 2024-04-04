import 'package:flutter/material.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class MFGridLayout extends StatelessWidget {
  const MFGridLayout({
    super.key,
    required this.size,
    required this.itemcount,
    this.mainAxisExtent = 243,
    required this.itemBuilder,
  });

  final Size size;
  final int itemcount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemcount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: MFSizes.gridViewSpacing,
        crossAxisSpacing: MFSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
      // itemBuilder: (_, index) {
      //   return ItemContainer(size: size);
      // },
    );
  }
}
