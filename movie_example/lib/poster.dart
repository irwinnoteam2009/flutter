import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String url;

  Poster(this.url);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Hero(
            tag: 'poster',
            child: Image.network(
              url,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            )),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
