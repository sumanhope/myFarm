import 'package:flutter/material.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/store/screens/widget/orderlistitem.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(MFSizes.defaultSpace),
        child: OrderListItems(),
      ),
    );
  }
}
