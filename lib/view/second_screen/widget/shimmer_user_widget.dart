import 'package:flutter/widgets.dart';
import 'package:test/view/second_screen/widget/shimmer_user_item_widget.dart';

class ShimmerUserWidget extends StatelessWidget {
  const ShimmerUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 6,
      itemBuilder: (context, index) => ShimmerUserItemWidget(),
    );
  }
}
