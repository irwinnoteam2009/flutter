import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import 'package:movie_example/movie.dart';
import 'package:movie_example/poster.dart';

class VideoWidget extends StatefulWidget {
  final String url;

  VideoWidget(this.url);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    super.dispose(); 
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Chewie(controller: _chewieController));
  }
}

class MovieDetail extends StatelessWidget {
  final Movie _movie;
  MovieDetail(this._movie);

  Widget itemInfo(String key, value) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(value)
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie!"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _movie.title,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_movie.originalTitle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Poster(_movie.posterPath);
                        }));
                      },
                      child: Hero(
                        tag: 'movie_${_movie.id}',
                        child: Hero(
                          tag: 'poster',
                          child: Image.network(_movie.posterPath,
                              fit: BoxFit.cover, 
                              height: 200,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          itemInfo('Release:', DateFormat('yyyy-MM-dd').format(_movie.releaseAt)),
                          itemInfo('Popularity:', _movie.popularity.toString()),
                          itemInfo('Vote:', '${_movie.voteAvg} (${_movie.voteCount})'),
                          itemInfo('Genre:', _movie.genres.map((it) => it.name).toList().join("\n")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(_movie.overview),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                        height: 200.0, child: VideoWidget(_movie.video)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
