import 'package:movie_example/detail.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'dart:async';
import 'package:flutter/foundation.dart';

class Genre {
  final String name;

  Genre(this.name);
  Genre.fromJSON(Map<String, dynamic> json) : name = json['name'];
}

class Movie {
  int id;
  bool adult;
  String originalLanguage;
  String originalTitle;
  String overview;
  DateTime releaseAt;
  String posterPath;
  double popularity;
  String title;
  String video;
  double voteAvg;
  int voteCount;
  List<Genre> genres = List();

  Movie.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    adult = json['adult'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    releaseAt = DateTime.parse(json['release_date']);
    posterPath = json['poster_path'];
    popularity = json['popularity'];
    title = json['title'];
    video = json['video'];
    voteAvg = json['vote_average'];
    voteCount = json['vote_count'];
    if (json['genres'] != null) this.genres .addAll(json['genres'].map<Genre>((jsn) => Genre.fromJSON(jsn)).toList());
    if (json['genre_ids'] != null) this.genres .addAll(json['genre_ids'].map<Genre>((jsn) => Genre.fromJSON(jsn)).toList());
  }
}

Future<List<Movie>> fetchMovies(http.Client client, String url) async {
  final response = await client.get(url);
  return compute(parseMovies, response.body);
}

List<Movie> parseMovies(String response) {
  final parsed = convert.jsonDecode(response);
  return parsed['results'].map<Movie>((json) => Movie.fromJSON(json)).toList();
}

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  MoviesList({Key key, this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black26,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(
          height: 60.0,
          child: ListTile(
              title: Text(movies[index].title),
              leading: Hero(
                tag: 'movie_${movies[index].id}',
                child: Image.network(
                  movies[index].posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MovieDetail(movies[index]);
                }));
              }),
        );
      },
    );
  }
}
