import 'package:flutter/material.dart';

class Genre {
  final String name;

  Genre(this.name);
  Genre.fromJSON(Map<String, dynamic> json):
    name = json['name'];
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
  final List<Genre> genres = List();

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
    if (json['genres'] != null) {
      json['genres'].forEach((v) {
        genres.add(Genre.fromJSON(v));
      });
    }
  }
}

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie) onTap;

  MoviesList({Key key, this.movies, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(
          height: 60.0,
          child: ListTile(
            title: Text(movies[index].title),
            leading: Image.network(movies[index].posterPath, fit: BoxFit.cover,),
            onTap: () {
              onTap(movies[index]);
            },
          ),
        );
      },
    );
  }
}