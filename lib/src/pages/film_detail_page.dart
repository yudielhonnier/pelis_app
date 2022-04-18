

import 'package:flutter/material.dart';
import 'package:pelis_pro/src/models/actors_model.dart';
import 'package:pelis_pro/src/models/film_detail_model.dart';
import 'package:pelis_pro/src/models/film_model.dart';
import 'package:pelis_pro/src/providers/films_provider.dart';

class FilmDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Film film=ModalRoute.of(context)!.settings.arguments as Film;


    return Scaffold(
      body:CustomScrollView(
        slivers: <Widget>[
           _createAppbar(film),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _postTitle(film,context),
                _description(film,context),
                _createCasting(film,context),

              ]
            ),
          )
        ],
      )

    );
  }



 Widget _createAppbar(Film film) {

    return  SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
            film.getTitle(),
          style: TextStyle(color: Colors.white,fontSize: 16.0,),
        ),
        background: FadeInImage(
          image: NetworkImage(film.getImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
           fit: BoxFit.cover,
        ),
      ),
    );


 }

  Widget _postTitle(Film film,BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: film.getId(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(film.getImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range_sharp,size: 40.0,),
                      Text(film.getYear(),style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border,size: 40.0,),
                      _TextVotes(film,context)
                    ],
                  ),

                ],
              ))
        ],
      ),
    );
  }

  Widget _TextVotes(Film film,BuildContext context) {
    final filmsProvider=FilmsProvider();

    return FutureBuilder(
        future: filmsProvider.getFilmDetail(film.getId()),
        builder: (context,AsyncSnapshot<FilmDetail> snapshot){
          if(snapshot.hasData){
            FilmDetail filmDetail=snapshot.requireData;
            print(filmDetail.vote![0]);
            return Text((filmDetail.vote!=[])
                ?filmDetail.vote![0]
                :'0'
              ,style: TextStyle(fontSize: 30.0),);
          }else{
            return Container();
          }
        }
    );
  }

  Widget _description(Film film,BuildContext context) {
    final filmsProvider=FilmsProvider();

    return FutureBuilder(
      future: filmsProvider.getFilmDetail(film.getId()),
      builder: (context,AsyncSnapshot<FilmDetail> snapshot){
        if(snapshot.hasData){
          FilmDetail filmDetail=snapshot.requireData;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: Text(
              //TODO NEED A DESCRIPTION METHOD
              filmDetail.getSynopsis(),
              textAlign: TextAlign.justify,
            ),
          );
        }else{
          return Container();
        }
      }
    );
  }

  Widget _createCasting(Film film,BuildContext context) {

    final peliProvider = new FilmsProvider();

   List<String> actors= film.getCast();

    return FutureBuilder(
      future: peliProvider.getCasting(actors),
      builder: (context,AsyncSnapshot<List<Actor>> snapshat){
        if(snapshat.hasData){
          print('aaa ${snapshat.requireData.length}');
         return ((snapshat.requireData.length)!=0)
              ?  _createActoresPageView(context,snapshat.requireData)
              : Text('Actors not found',style: TextStyle(fontSize: 45.0,color: Colors.blue),);
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActoresPageView(BuildContext context,List<Actor> actors,) {

  return SizedBox(
    height: 200.0,
    child: PageView.builder(
      controller: PageController(
        viewportFraction: 0.3
      ),
      itemCount: actors.length,
      itemBuilder: (context, int i) {

         return _CardActor(actors[i]);
      },
    ),
  );
  }

  Widget _CardActor(Actor actor){

    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(actor.getImage()),
                height: 140.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),

          ),
          Text(actor.getName(),overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
