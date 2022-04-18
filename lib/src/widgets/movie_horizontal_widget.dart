import 'package:flutter/material.dart';
import 'package:pelis_pro/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film>? films;
  final Function? followPage;

  MovieHorizontal({this.films, this.followPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        followPage!();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: films!.length,
        itemBuilder:(context,i)=> _card(context,films![i]),
      ),
    );
  }

  Widget _card(BuildContext context,Film film) {
    film.uniqueId='${film.getId()}-pageView';
      final card= Container(
        margin: EdgeInsets.only(
          right: 15.0,
        ),
        child: Column(
          children: [
            Hero(
              tag: film.getUniqueId(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(film.getImage()),
                  fit: BoxFit.cover,
                  height: 140.0,
                ),
              ),
            ),
            Text(
              film.getTitle(),
              style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis
            )
          ],
        ),
      );
  return GestureDetector(
    child: card,
    onTap: (){

      Navigator.pushNamed(context, 'detail',arguments: film);
     },
  );
  }
  }

