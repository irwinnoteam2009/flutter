import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';

import 'package:cinema_example/movie.dart';
import 'package:cinema_example/poster.dart';

// class VideoWidget extends StatefulWidget {
//   final String url;

//   VideoWidget(this.url);

//   @override
//   _VideoWidgetState createState() => _VideoWidgetState();
// }

// class _VideoWidgetState extends State<VideoWidget> {
//   VideoPlayerController _controller;
//   ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url);
//     _chewieController =ChewieController(
//       videoPlayerController: _controller,
//       aspectRatio: _controller.value.aspectRatio,
//       autoPlay: true,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     _chewieController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Chewie(controller: _chewieController,)
//       );
//     }
// }

class MovieDetail extends StatelessWidget {
  final Movie _movie;
  MovieDetail(this._movie); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie!"),
      ),
      body: Container(
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
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_movie.originalTitle),
              ),
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Poster(_movie.posterPath);
                    }));
                  },
                  child: Container(
                    height: 200,
                    child: Hero(
                      tag: 'poster',
                      child: Image.network(_movie.posterPath, fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Text(_movie.overview),
                  // VideoWidget(widget._movie.video),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
