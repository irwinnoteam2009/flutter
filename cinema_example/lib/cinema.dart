import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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

  Movie(this.id, this.adult, this.originalLanguage, this.originalTitle, this.overview, this.releaseAt, this.posterPath,
    this.popularity, this.title, this.video, this.voteAvg, this.voteCount);

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

class MovieResponse {
  int page;
  int totalPages;
  int totalResults;
  List<Movie> movies = List();

  MovieResponse.fromJSON(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    if (json['results'] !=null) {
      json['results'].forEach((v) {
        movies.add(Movie.fromJSON(v));
      });
    }
  }
}

List<Movie> loadCinemaList(String url) {
  List<Movie> movies = List();
  
  Future<http.Response> future = http.get(url);
  future.then((resp) {
    if (resp.statusCode == 200) {
      var json = convert.jsonDecode(resp.body);    
      var response = MovieResponse.fromJSON(json); 
      movies.addAll(response.movies);
    }
  })
  .catchError((e) {
    print(e);
  });

  return movies;
}