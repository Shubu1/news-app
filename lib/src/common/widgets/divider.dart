import 'package:flutter/material.dart';

class Dividerr extends StatelessWidget {
  const Dividerr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
