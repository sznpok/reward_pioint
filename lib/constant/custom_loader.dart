import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customCupertinoActivityIndicator() {
  return const Center(
    child: CupertinoActivityIndicator(
      radius: 16.0,
    ),
  );
}

void onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return customCupertinoActivityIndicator();
    },
  );
}
