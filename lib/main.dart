import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starwars/helpers/HttpHelper.dart';
import 'package:starwars/ui/screens/home_screen.dart';
import 'package:starwars/viewmodel/AuthorsViewModel.dart';
import 'package:starwars/viewmodel/FilmViewModel.dart';
import 'package:starwars/viewmodel/RotationViewModel.dart';
import 'package:starwars/viewmodel/ThemeViewModel.dart';

void main() {
  final HttpHelper http = HttpHelper(baseUrl: "https://swapi.dev/api/");
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthorsViewModel(http: http)),
            ChangeNotifierProvider(create: (context) => RotationViewModel()),
            ChangeNotifierProvider(create: (context) => ThemeViewModel()),
            ChangeNotifierProvider(create: (context) => FilmViewModel(http: http))
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authorsVM = Provider.of<AuthorsViewModel>(context, listen: false);
      authorsVM.getListAuthors();
      Provider.of<RotationViewModel>(context, listen: false).listenGyroscope();
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);
    return  MaterialApp(
        title: 'Star Wars App',
        theme: themeViewModel.theme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}
