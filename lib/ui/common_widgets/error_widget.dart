
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget{
  const CustomErrorWidget({super.key, required this.onTryPress});
  final VoidCallback onTryPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.signal_wifi_bad, size: 50,),
          const SizedBox(height: 20,),
          const Text("Network error"),
          TextButton(onPressed: ()=> onTryPress(), child: const Text("Try again"))
        ],
      ),
    );
  }

}