import 'package:flutter/material.dart';
import 'package:cinema_example/cinema.dart';

class MovieDetail extends StatelessWidget {
  final Movie _movie;
  MovieDetail(this._movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie!"),
      ),
      body: Center(
        child: Text(_movie.overview),
      ),
    );
  }
}
