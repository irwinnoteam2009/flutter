class Cinema {
  final int id;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final DateTime releaseAt;
  final String posterPath;
  final double popularity;
  final String title;
  final String video;
  final double voteAvg;
  final int voteCount;

  Cinema(this.id, this.adult, this.originalLanguage, this.originalTitle, this.overview, this.releaseAt, this.posterPath,
    this.popularity, this.title, this.video, this.voteAvg, this.voteCount);

  Cinema.fromJSON(Map<String, dynamic> json) : 
    id = json['id'],
    adult = json['adult'],
    originalLanguage = json['original_language'],
    originalTitle = json['original_title'],
    overview = json['overview'],
    releaseAt = json['release_date'],
    posterPath = json['poster_path'],
    popularity = json['popularity'],
    title = json['title'],
    video = json['video'],
    voteAvg = json['vote_average'],
    voteCount = json['vote_count'];
}