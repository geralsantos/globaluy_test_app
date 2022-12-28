import 'package:flutter/material.dart';

class RecordNotFound extends StatelessWidget {
  const RecordNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'lib/resources/images/not-found.webp',
            colorBlendMode: BlendMode.overlay,
          )),
          Text('Record not found')
        ],
      ),
    );
  }
}
