
import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier{

  ThemeData _theme = ThemeData.dark();
  ThemeData get theme => _theme;
  set theme(ThemeData value) {
    _theme = value;
    notifyListeners();
  }

  void toggleTheme(){
    final isDark = _theme == ThemeData.dark();
    if(isDark){
      theme = ThemeData.light();
    }else{
      theme = ThemeData.dark();
    }
  }

}