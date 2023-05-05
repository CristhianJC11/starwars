
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: Colors.yellow,),
          SizedBox(height: 20,),
          Text("Loading..")
        ],
      ),
    );
  }

}