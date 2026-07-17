import 'package:flutter/material.dart';
import 'rz_animation_loader_widget.dart';

class RzFullScreenLoader {
  RzFullScreenLoader._();

  static void openLoadingDialog(
      BuildContext context,
      String text,
      String animation,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_)=> PopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 250,),
                RzAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
      ),
    );
  }

  static void popUpCircular() {
    /*Get.defaultDialog(
      title: "",
      onWillPop: () async => false,
      content: RzCircularLoader(),
      backgroundColor: Colors.transparent,
    );*/
  }

  static stopLoading(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}