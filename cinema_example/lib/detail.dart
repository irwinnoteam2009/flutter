import 'package:cinema_example/poster.dart';
import 'package:flutter/material.dart';
import 'package:cinema_example/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie _movie;
  MovieDetail(this._movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie!"),
      ),
      body: Row(
        children: <Widget>[
          Text(
            _movie.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Poster(_movie.posterPath);
                  }));
                },
                child: Container(
                  height: 120,
                  child: Hero(
                    tag: 'poster',
                    child: Image.network(_movie.posterPath, fit: BoxFit.cover),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
