
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/data/model/Author.dart';
import 'package:starwars/ui/common_widgets/film_widget.dart';
import 'package:starwars/ui/common_widgets/loading_widget.dart';
import 'package:starwars/viewmodel/FilmViewModel.dart';

class DetailsScreen extends StatelessWidget{
  const DetailsScreen({super.key, required this.author});
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(author.name??""),),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/galaxy_sky.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.movie),
                  SizedBox(width: 5,),
                  Text("Films",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Consumer<FilmViewModel>(
                  builder: (context, vm, child) {
                    if(vm.isLoading){
                      return const LoadingWidget();
                    }else {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: vm.listFilms.length,
                        itemBuilder: (context, index) {
                          return FilmWidget(film: vm.listFilms[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}