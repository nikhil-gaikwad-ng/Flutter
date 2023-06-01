import 'package:flutter/material.dart';

Widget outlineButton({required Function function, required String text}) {
  bool loader = false;
  return StatefulBuilder(
    builder: (context, _setState) => OutlinedButton(
        onPressed: () async {
          if (!loader) {
            loader = true;
            _setState(() {});
            await function();
            loader = false;
            _setState(() {});
          }
        },
        child: loader
            ? const SizedBox(
                width: 25,
                height: 25,
                child: const CircularProgressIndicator(),
              )
            : Text(text)),
  );
}
