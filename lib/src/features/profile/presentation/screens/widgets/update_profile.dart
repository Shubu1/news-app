import 'package:flutter/material.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final String subText;
  final IconData icon;
  final VoidCallback onPressed;
  const OptionCard(
      {super.key,
      required this.icon,
      required this.text,
      required this.subText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 80,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15.0), // Set the border radius here
            ),
            color: Colors.grey[80],
            margin: const EdgeInsets.only(
              bottom: 2,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 13, top: 12),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 23,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              textAlign: TextAlign.start,
                              style: getBoldStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              subText,
                              textAlign: TextAlign.start,
                              style: getBoldStyle(
                                color: const Color(0xFF707070),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
