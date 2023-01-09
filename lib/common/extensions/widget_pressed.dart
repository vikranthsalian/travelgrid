import 'package:flutter/material.dart';

extension OnPressed on Widget{
  Widget clickWidget({
    required Function onPressed
  }) {
    return Stack(
      children: [
        this,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: InkWell(
              onTap: () {
                if(onPressed!=null){
                  onPressed();
                }
              },
              child: const SizedBox.shrink()),
        ),
      ],
    );
  }
}