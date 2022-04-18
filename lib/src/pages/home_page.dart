import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelis_pro/src/models/film_model.dart';
import 'package:pelis_pro/src/providers/films_provider.dart';
import 'package:pelis_pro/src/search/search_delegate.dart';
import 'package:pelis_pro/src/widgets/card_swiper_widget.dart';
import 'package:pelis_pro/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  FilmsProvider filmsProvider =new FilmsProvider();


  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Films 2021'),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: DataSearch(),
//                    query: ''
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _swiperCards(),
          _footer(context)
        ],
      ),

    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
        future: filmsProvider.getRankedFilms(),
        builder: (BuildContext context,AsyncSnapshot<List<Film>> snapshot){
          if(snapshot.hasData) {
            return SwiperCard(films: snapshot.requireData);
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
//    return
  }

 Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0,top: 10.0),
              child: Text('Clasics Films',style: Theme.of(context).textTheme.headline6,)
          ),
         SizedBox(height: 5.0,),

          StreamBuilder(
            stream:filmsProvider.popularStream ,
            builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return MovieHorizontal(
                films: snapshot.requireData ,
                followPage: filmsProvider.getPopular,
              );
            }
            return Container();
            },
          )
        ],
      ),
    );


 }
}
