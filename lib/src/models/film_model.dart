


class Films{
  List<Film> items =[];

  Films();

  Films.fromJsonList(List<dynamic> jsonList){

    if(jsonList==null) return;
    for(var item in jsonList){
      final film=Film.fromJson(item);
      items.add(film);
    }
  }
}


class Film {
  String? uniqueId;
  String? id;
  String? title;
  String? image;
  String? year;
  List<String>? cast;

  Film({this.id, this.title, this.image, this.year, this.cast});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    year = json['year'];
    cast = json['cast'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['year'] = this.year;
    data['cast'] = this.cast;
    return data;
  }

  getImage(){
    if(image==null||image!.compareTo('/imgs/movies/noimgfull.jpg')==0){
    this.image= 'http://via.placeholder.com/350x150';
    }
    return image;
  }
  getTitle(){
    return title;
  }
  getId(){
    return id;
  }
  getYear(){
    return year;
  }
  getCast(){
    return cast;
  }
  getUniqueId(){
    return uniqueId;
  }



}