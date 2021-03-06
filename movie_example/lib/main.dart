import 'package:movie_example/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cinema example'),
        ),
        body: FutureBuilder(
          future: fetchMovies(http.Client(),
              'https://gist.githubusercontent.com/irwinnoteam2009/b74bb8e7785275696d77002bbdedc80a/raw/adac09d873ba02e8419210abb8f1673a565a5223/cinema.json'),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());

            return snapshot.hasData
                ? MoviesList(movies: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
