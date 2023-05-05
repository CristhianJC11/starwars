import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/ui/common_widgets/author_widget.dart';
import 'package:starwars/ui/common_widgets/error_widget.dart';
import 'package:starwars/ui/common_widgets/loading_widget.dart';
import 'package:starwars/viewmodel/AuthorsViewModel.dart';
import 'package:starwars/viewmodel/RotationViewModel.dart';
import 'package:starwars/viewmodel/ThemeViewModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("building HomeScreen");
    AuthorsViewModel authorsViewModel = Provider.of<AuthorsViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars - Demo App"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_list_sharp),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    value: 0,
                    child: ListTile(
                      title: const Text("Male"),
                      selected: authorsViewModel.filterSelected == FilterAuthor.male,
                    )),
                PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      title: const Text("Female"),
                      selected: authorsViewModel.filterSelected == FilterAuthor.female,
                    )),
                PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      title: const Text("None"),
                      selected: authorsViewModel.filterSelected == FilterAuthor.none,
                    ))
              ];
            },
            onSelected: (optionSelected) {
              switch(optionSelected){
                case 0:
                  authorsViewModel.filterListAuthors(filterAuthor: FilterAuthor.male);
                  break;
                case 1:
                  authorsViewModel.filterListAuthors(filterAuthor: FilterAuthor.female);
                  break;
                case 2:
                  authorsViewModel.filterListAuthors(filterAuthor: FilterAuthor.none);
                  break;
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/galaxy_sky.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Consumer<RotationViewModel>(
                builder: (context, vm, child) => Transform.rotate(
                    angle: (vm.angle * 2.0) / 100, //,
                    child: InkWell(
                        onTap: () {
                          Provider.of<ThemeViewModel>(context, listen: false).toggleTheme();
                        },
                        child: Image.asset(
                          "assets/images/starwars.png",
                          height: 70,
                        ))),
              ),
              const SizedBox(height: 20,),
              const Text(
                "Authors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: Consumer<AuthorsViewModel>(
                    builder: (context, vm, child) =>
                        ! vm.isNetworkError ?
                            /// loading widget
                            vm.isLoadingList ? const LoadingWidget()
                            : NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (scrollNotification is ScrollEndNotification &&
                                    scrollNotification.metrics.extentAfter == 0) {
                                    vm.loadNextPage();
                                }
                                return true;
                              },
                              child: RefreshIndicator(
                                child: ListView.builder(
                                  controller: ScrollController(),
                                  padding: const EdgeInsets.all(5),
                                  shrinkWrap: true,
                                  itemCount: vm.listAuthors.length + 1,
                                  itemBuilder: (context, index) {
                                    /// Loading next page
                                    if(vm.listAuthors.length == index){
                                      return vm.isLoadingNext ? const SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: CircularProgressIndicator()))
                                          : const SizedBox();
                                    }else{
                                      return AuthorWidget(author: vm.listAuthors[index]);
                                    }
                                  },
                                ),
                                onRefresh: () => Future(() => vm.getListAuthors() )
                              ),
                            )
                          /// Error Widget
                          : CustomErrorWidget(onTryPress: ()=> vm.getListAuthors())
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
