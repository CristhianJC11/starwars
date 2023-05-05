
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/data/model/Author.dart';
import 'package:starwars/ui/screens/details_screen.dart';
import 'package:starwars/viewmodel/FilmViewModel.dart';

class AuthorWidget extends StatelessWidget{
  const AuthorWidget({super.key, required this.author});
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black38,
      child: ListTile(
        onTap: (){
          Provider.of<FilmViewModel>(context, listen: false).getFilms(author.films??[]);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(author: author),));
        },
        title: Text(author.name??""),
        subtitle: Text((author.gender??"") == "n/a" ? "undefined gender" : author.gender??""),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }

}