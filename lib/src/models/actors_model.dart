

class Cast{
  List<Actor> actors =[];

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList){

    if(jsonList==null) return;
    jsonList.forEach((element) {
      final actor=Actor.fromJson(element);
      actors.add(actor);
    });
  }
}


class Actor {
  String? image;
  String? name;
  String? description;

  Actor({this.image, this.name, this.description});

  Actor.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }

  getImage(){
    return image;
  }
  getName(){
    return name;
  }


}


