



class FilmsDetails{
  List<FilmDetail> items =[];

  FilmsDetails();

  FilmsDetails.fromJsonList(List<dynamic> jsonList){

    if(jsonList==null) return;
    for(var item in jsonList){
      final filmDetail=FilmDetail.fromJson(item);
      items.add(filmDetail);
    }
  }
}



class FilmDetail {
  String? originalTitle;
  String? year;
  String? duration;
  String? countryImg;
  String? country;
  List<String>? direction;
  List<String>? script;
  List<String>? cast;
  List<String>? photography;
  List<String>? producer;
  List<String>? genders;
  String? synopsis;
  List<String>? vote;
  List<String>? votes;

  FilmDetail(
      {this.originalTitle,
        this.year,
        this.duration,
        this.countryImg,
        this.country,
        this.direction,
        this.script,
        this.cast,
        this.photography,
        this.producer,
        this.genders,
        this.synopsis,
        this.vote,
        this.votes});

  FilmDetail.fromJson(Map<String, dynamic> json) {
    originalTitle = json['original_title'];
    year = json['year'];
    duration = json['duration'];
    countryImg = json['country_img'];
    country = json['country'];
    direction = json['direction'].cast<String>();
    script = json['script'].cast<String>();
    cast = json['cast'].cast<String>();
    photography = json['photography'].cast<String>();
    producer = json['producer'].cast<String>();
    genders = json['genders'].cast<String>();
    synopsis = json['synopsis'];
    vote = json['vote'].cast<String>();
    votes = json['votes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_title'] = this.originalTitle;
    data['year'] = this.year;
    data['duration'] = this.duration;
    data['country_img'] = this.countryImg;
    data['country'] = this.country;
    data['direction'] = this.direction;
    data['script'] = this.script;
    data['cast'] = this.cast;
    data['photography'] = this.photography;
    data['producer'] = this.producer;
    data['genders'] = this.genders;
    data['synopsis'] = this.synopsis;
    data['vote'] = this.vote;
    data['votes'] = this.votes;
    return data;
  }

  getOriginalTitle(){
    return originalTitle;
  }
  getYear(){
    return year;
  }
  getDuration(){
    return duration;
  }
  getCountryImg(){
    return countryImg;
  }
  getCountry(){
    return country;
  }
  getSynopsis(){
    return synopsis;
  }



}