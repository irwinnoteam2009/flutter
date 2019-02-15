import 'package:cinema_example/cinema.dart';
import 'package:cinema_example/movieDetail.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> _movies = loadCinemaList('https://gist.githubusercontent.com/irwinnoteam2009/b74bb8e7785275696d77002bbdedc80a/raw/adac09d873ba02e8419210abb8f1673a565a5223/cinema.json');

  _showMovieDetail(Movie _movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MovieDetail(_movie);
        },
      )
    );
  }

  Widget _movieItem(Movie _movie) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.only(bottom: 4.0),
      child: ListTile(
        title: Text(_movie.title),
        leading: Image.network(_movie.posterPath, fit: BoxFit.cover,),
        onTap: () { _showMovieDetail(_movie); },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinema example'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _movies.length,
        itemBuilder: (BuildContext _context, int i) {
          return _movieItem(_movies[i]);
        },        
      )
    );
  }
}
