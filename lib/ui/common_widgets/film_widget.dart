
import 'package:flutter/material.dart';
import 'package:starwars/data/model/Film.dart';

class FilmWidget extends StatelessWidget{
  const FilmWidget({super.key, required this.film});
  final Film film;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade800.withAlpha(200),
      elevation: 5,
      shape: const Border(left: BorderSide(color: Colors.yellow, width: 5)),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.movie_creation_outlined, size: 70, color: Colors.white,),
              const SizedBox(width: 5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title: ${film.title??""}", style: const TextStyle(color: Colors.white)),
                    Text("Director: ${film.director??""}", style: const TextStyle(color: Colors.white)),
                    Text("Producer: ${film.producer??""}", style: const TextStyle(color: Colors.white)),
                    Text("Release date: ${film.releaseDate??""}", style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
  
}