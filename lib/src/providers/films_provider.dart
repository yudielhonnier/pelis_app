import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pelis_pro/src/models/actors_model.dart';
import 'package:pelis_pro/src/models/film_detail_model.dart';
import 'package:pelis_pro/src/models/film_model.dart';

class FilmsProvider {
// LIST BEST FILMS 2021
//  https://jk-feed.000webhostapp.com/film/?page=ranked&from=0

// LIST BEST FILMS OF ALL THE TIMES
//  https://jk-feed.000webhostapp.com/film/?page=listAll&from=0

// LIST ONE ACTOR
//  https://jk-feed.000webhostapp.com/film/?page=actor&search

// FILM DETAIL
//  https://jk-feed.000webhostapp.com/film/?page=details&id=814379

// LIST SEARCH FILMS
//  https://jk-feed.000webhostapp.com/film/?page=search&name=catch+me+if+you+can&page_no=1

  String _url = 'jk-feed.000webhostapp.com';
  final String _pageActor = 'actor';
  final String _pageSearch = 'search';
  final String _pageRanked = 'ranked';
  final String _pageDetails = 'details';

  int _popularPage = 0;
  int _searchFrom=1;

  List<Film> _popular = [];
  final _popularStreamController = StreamController<List<Film>>.broadcast();
  Function(List<Film>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Film>> get popularStream => _popularStreamController.stream;

  void disposeStream() {
    _popularStreamController.close();
  }

  Future<List<Film>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films =  Films.fromJsonList(decodedData);

    return films.items;
  }

  Future<List<Film>> getRankedFilms() async {
    final url = Uri.https(_url, '/film/', {
      'page': _pageRanked,
      'from': '0'
    });

    return await _processResponse(url);
  }

  Future<List<Film>> getPopular() async {
    _popularPage++;
    final url = Uri.https(_url, '/film/', {
      'page': 'listAll',
      'from': _popularPage.toString()
    });

    final resp = await _processResponse(url);
    _popular.addAll(resp);
    popularSink(_popular);
    return resp;
  }

  Future<List<Actor>> getCasting(List<String> actors) async {
    var futures = <Future<Actor>>[];
    for (String item in actors) {
      futures.add(getActor(item));
    }
    return await Future.wait(futures);
  }

  Future<Actor> getActor(String actorName) async {
    final url =
    Uri.https(_url, '/film/', {'page': _pageActor, 'search': actorName});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final actor = Actor.fromJson(decodeData);
    return actor;
  }

  //TODO MAKE A SERVICE TO READ MOVIE FROM SEARCH
  Future<List<Film>> getFilm(String query) async {
    _searchFrom++;
    final url = Uri.https(_url, '/film/', {
      'page': _pageSearch,
      'name':query,
      'page_no':'1',
    });

    return await _processResponse(url);
  }

  Future<FilmDetail> getFilmDetail(String id) async {
    final url = Uri.https(_url, '/film/', {'page': _pageDetails, 'id': id});

    final resp= await http.get(url);
    final decodeData=json.decode(resp.body);
    final filmDetails=FilmDetail.fromJson(decodeData);
    return filmDetails;
  }

}
