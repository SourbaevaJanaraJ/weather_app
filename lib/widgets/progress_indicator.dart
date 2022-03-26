import 'package:flutter/material.dart';

circularProgress() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.amberAccent,
      color: Colors.white,
    ),
  );
}

linearProgress() {
  return const SafeArea(
    child: LinearProgressIndicator(
      backgroundColor: Colors.amberAccent,
      color: Colors.white,
    ),
  );
}
