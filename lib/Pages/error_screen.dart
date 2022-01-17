import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  
  final String lottieFilePath;
  final String errorMessage;

  const ErrorScreen({
    Key? key,
    required this.lottieFilePath,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //String lottieFilePath = 'lottie/empty-state.json';
    //String errorMessage = 'Error loading the page. Please try again';
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  width: double.maxFinite,
                  child: Lottie.asset(lottieFilePath),
                ),
                const SizedBox(height: 40),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
