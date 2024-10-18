import 'package:flutter/material.dart';

class FirstIntro extends StatelessWidget {
  const FirstIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          Expanded(
            child: Container(
              height: (WidgetsBinding.instance.platformDispatcher.views.first
                              .physicalSize /
                          WidgetsBinding.instance.platformDispatcher.views.first
                              .devicePixelRatio)
                      .height *
                  0.5,
              child: Image(
                image: AssetImage('assets/images/pathways.jpg'),
              ),
            ),
          ),

          // title
          // subtitle description
          // button to navigate to next screen
        ],
      ),
    );
  }
}
