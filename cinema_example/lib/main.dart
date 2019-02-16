import 'package:cinema_example/movie.dart';
import 'package:cinema_example/movieDetail.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema example',
      home: HomePage(),
    );
  }
}

Future<List<Movie>> fetchMovies(http.Client client, String url) async {
  final response =await client.get(url);
  return compute(parseMovies, response.body);
}

List<Movie> parseMovies(String response) {
  final parsed = convert.jsonDecode(response);
  return parsed['results'].map<Movie>((json) => Movie.fromJSON(json)).toList();
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinema example'),
      ),
      body: FutureBuilder(
        future: fetchMovies(http.Client(), 'https://gist.githubusercontent.com/irwinnoteam2009/b74bb8e7785275696d77002bbdedc80a/raw/adac09d873ba02e8419210abb8f1673a565a5223/cinema.json'),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error);

          return snapshot.hasData 
            ? MoviesList(movies: snapshot.data, onTap: (movie) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetail(movie);
                  }
                )
              );
            },)
            : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
