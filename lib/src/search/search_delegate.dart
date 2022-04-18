

import 'package:flutter/material.dart';
import 'package:pelis_pro/src/models/film_model.dart';
import 'package:pelis_pro/src/providers/films_provider.dart';


class DataSearch extends SearchDelegate{
  String select='';
  //TODO IMPLEMENT THIS MORE GENERIC
  //we can send the args, here
  final filmsProvider=new FilmsProvider();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Appbar accions
    return [
    IconButton(onPressed: (){
      query='';
    }, icon: Icon(Icons.clear))
  ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // icon on left Appbar
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,
          progress: transitionAnimation ,

        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // build the results
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child:Text(select) ,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // build suggestions when the user write
  if(query.isEmpty){
    return Container();
  }

  return FutureBuilder(
    future:filmsProvider.getFilm(query),
    builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot){
      final films=snapshot.data;
      if(snapshot.hasData){
        return ListView(
          children: films!.map((film){
             return ListTile(
              leading:FadeInImage(
                  placeholder:AssetImage('assets/img/loading.gif') ,
                  image: NetworkImage(film.getImage()),
                  width: 50.0,
                fit: BoxFit.contain,
              ),
            title:Text(film.getTitle()),
            subtitle: Text(film.getTitle(),style: TextStyle(color:Colors.blue),),
            onTap: (){
                close(context, null);
                film.uniqueId='';
                Navigator.pushNamed(context, 'detail',arguments: film);
            },
            );
          }).toList(),
        );
      }else{
        print('dont have data');
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }

  );

  }
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // build suggestions when the user write
//    final suggestionList=(query.isEmpty)
//        ? recentlyFilms
//        : films.where(
//            (p)=>p.toLowerCase().startsWith(query.toLowerCase()))
//            .toList();
//
//
//    return ListView.builder(
//        itemCount: suggestionList.length,
//        itemBuilder: (context,i){
//         return ListTile(
//          leading:Icon(Icons.movie),
//          title: Text(suggestionList[i]),
//          onTap: (){
//            select=suggestionList[i];
//            showResults(context);
//          },
//          );
//        },
//    );

  }






