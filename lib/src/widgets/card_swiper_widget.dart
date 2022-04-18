
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelis_pro/src/models/film_model.dart';

class SwiperCard extends StatelessWidget {

  final List<Film> films;
   SwiperCard({required this.films}) ;

  @override
  Widget build(BuildContext context) {
    final _screenSize=MediaQuery.of(context).size;

    return  Column(
      children: [
        SizedBox(
          height: 10.0
        ),
        Container(
          padding: EdgeInsets.only(top: 0),
          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              films[index].uniqueId='${films[index].getId()}-swiper';
              return Hero(
                tag: films[index].getUniqueId(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: ()=>Navigator.pushNamed(context, 'detail',arguments: films[index]),

                    child: FadeInImage(
                      image: NetworkImage(films[index].getImage() ),
                      placeholder:AssetImage('assets/img/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ) ;
            },
            itemCount: films.length,
//        pagination: new SwiperPagination(),
//        control: new SwiperControl(),
            itemWidth: _screenSize.width*0.6,
            itemHeight: _screenSize.height*0.5,
            layout:SwiperLayout.STACK,
          ),
        ),
      ],
    );
  }
}
